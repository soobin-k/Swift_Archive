//
//  SearchBarViewModel.swift
//  SearchDaumBlog
//
//  Created by 김수빈 on 2022/09/04.
//

import RxSwift
import RxCocoa

struct SearchBarViewModel{
    //SearchBar 텍스트
    let queryText = PublishRelay<String?>()
    
    //SearchBar 외부로 내보낼 이벤트
    let shouldLoadResult: Observable<String>
    
    //SearchBar 버튼 탭 이벤트
    let searchButtonTapped = PublishRelay<Void>()
    
    init(){
        self.shouldLoadResult = searchButtonTapped // 트리거: 가장 최근의 text를 보내줘라
            .withLatestFrom(queryText){ $1 ?? ""} // 없으면 빈값으로
            .filter{ !$0.isEmpty }
            .distinctUntilChanged() // 동일한건 한번만 처리
    }
}
