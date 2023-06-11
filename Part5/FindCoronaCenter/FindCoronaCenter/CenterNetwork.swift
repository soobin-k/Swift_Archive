//
//  CenterNetwork.swift
//  FindCoronaCenter
//
//  Created by 김수빈 on 2023/06/11.
//

import Foundation
import Combine

class CenterNetwork {
    private let session: URLSession
    let api = CenterAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getCenterList() -> AnyPublisher<[Center], URLError> {
        guard let url = api.getCenterListComponents().url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.setValue("Infuser 31BtokBfa0MOpW34rYsB0QYnh8h+zJG3TYrQxVgFoUR59qOmi5HVnYSLfxeZ7zSd+LCguYGNdw63sab4TokCGA==", forHTTPHeaderField: "Authorization")
        
        return session.dataTaskPublisher(for: request) // Publisher생성 (dataTaskPublisher)
            .tryMap { data, response in // tryMap (data가 있는지 없는지 상태가 좋은지 확인)
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.unknown)
                }
                
                switch httpResponse.statusCode {
                case 200..<300:
                    return data
                case 400..<500:
                    throw URLError(.clientCertificateRejected)
                case 500..<599:
                    throw URLError(.badServerResponse)
                default:
                    throw URLError(.unknown)
                }
            }
            .decode(type: CenterAPIResponse.self, decoder: JSONDecoder()) // decode (데이터를 원하는 type으로 디코딩)
            .map { $0.data }
            .mapError { $0 as! URLError }
            .eraseToAnyPublisher() // Publisher가 아닌 AnyPublisher형태로 리턴
    }
}
