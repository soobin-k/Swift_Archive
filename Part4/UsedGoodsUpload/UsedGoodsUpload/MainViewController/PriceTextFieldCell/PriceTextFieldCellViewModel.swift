//
//  PriceTextFieldCellViewModel.swift
//  UsedGoodsUpload
//
//  Created by 김수빈 on 2022/09/05.
//

import RxSwift
import RxCocoa

struct PriceTextFieldCellViewModel {
    // ViewModel -> View
    let showFreeShareButton: Signal<Bool>
    let resetPrice: Signal<Void>
    
    // View -> ViewModel
    let priceValue = PublishRelay<String?>() // UI Event
    let freeShareButtonTapped = PublishRelay<Void>() // UI Event
    
    init() {
        self.showFreeShareButton = Observable
            .merge(
                priceValue.map { $0 ?? "" == "0" }, // price 값에 빈값이나 0을 넣으면
                freeShareButtonTapped.map { _ in false } // 무료 나눔 버튼 눌렀을 때
            )
            .asSignal(onErrorJustReturn: false)
        
        self.resetPrice = freeShareButtonTapped // 무료 나눔 설정되면 price reset 해줘!
            .asSignal(onErrorSignalWith: .empty())
    }
}
