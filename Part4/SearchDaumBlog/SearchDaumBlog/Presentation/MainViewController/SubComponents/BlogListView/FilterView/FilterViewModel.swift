//
//  FilterViewModel.swift
//  SearchDaumBlog
//
//  Created by 김수빈 on 2022/09/04.
//

import RxSwift
import RxCocoa

struct FilterViewModel{
    //FilterView 외부에서 관찰
    let sortButtonTapped = PublishRelay<Void>()
}
