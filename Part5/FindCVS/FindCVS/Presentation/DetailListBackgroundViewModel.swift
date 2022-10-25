//
//  DetailListBackgroundViewModel.swift
//  FindCVS
//
//  Created by 김수빈 on 2022/10/26.
//

import RxSwift
import RxCocoa

struct DetailListBackgroundViewModel{
    // viewModel -> view
    let isStatusLabelHidden: Signal<Bool>
    
    // 외부에서 전달받을 값
    let shoudHideStatusLabel = PublishSubject<Bool>()
    
    init(){
        isStatusLabelHidden = shoudHideStatusLabel
            .asSignal(onErrorJustReturn: true)
    }
}
