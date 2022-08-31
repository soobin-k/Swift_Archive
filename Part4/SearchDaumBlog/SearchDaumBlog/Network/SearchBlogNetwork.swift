//
//  SearchBlogNetwork.swift
//  SearchDaumBlog
//
//  Created by 김수빈 on 2022/09/01.
//

import RxSwift
import Foundation

class SearchBlogNetwork {
    private let session: URLSession
    let api = SearchBlogAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func searchBlog(query: String) -> Single<Result<DKBlog, SearchNetworkError>> {
        //✨ Result<Success, Failure>: reponse가 success/failure 둘중 하나로만 옴(rx 기본적인 타입)
        guard let url = api.searchBlog(query: query).url else {
            return .just(.failure(.invalidURL)) //❌ request url 가져오기 실패
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK 5869b7971259a9e25e167ea6fc632198", forHTTPHeaderField: "Authorization")
        
        return session.rx.data(request: request as URLRequest)
        //✨ data(request: URLRequest) -> Observable<Data>
            .map { data in
                do {
                    let blogData = try JSONDecoder().decode(DKBlog.self, from: data) // reponse 데이터 디코딩(data -> DKBlog)
                    return .success(blogData) //✅ 전문 호출 성공
                } catch {
                    return .failure(.invalidJSON) //❌ 데이터 파싱 실패
                }
            }
            .catch { _ in
                .just(.failure(.networkError)) //❌ 전문 호출 실패
            }
            .asSingle()
    }
}
