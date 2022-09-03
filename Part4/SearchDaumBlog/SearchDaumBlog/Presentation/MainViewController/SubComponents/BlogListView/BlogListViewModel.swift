//
//  BlogListViewModel.swift
//  SearchDaumBlog
//
//  Created by 김수빈 on 2022/09/04.
//

import RxSwift
import RxCocoa

struct BlogListViewModel{
    let filterViewModel = FilterViewModel()
    
    //MainViewController -> BlogListView
    let blogCellData = PublishSubject<[BlogListCellData]>()
    let cellData: Driver<[BlogListCellData]>
    
    init(){
        self.cellData = blogCellData
            .asDriver(onErrorJustReturn: []) // 에러가 나면 빈 배열 전달
    }
}
