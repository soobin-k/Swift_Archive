//
//  MainViewModel.swift
//  UsedGoodsUpload
//
//  Created by 김수빈 on 2022/09/05.
//

import UIKit
import RxSwift
import RxCocoa
import XCTest

struct MainViewModel{
    let titleTextFieldCellViewModel = TitleTextFieldViewModel()
    let priceTextFieldCellViewModel =  PriceTextFieldCellViewModel()
    let detailWriteFormCellViewModel = DetailWriteFormCellViewModel()
    
    // ViewModel -> View
    let cellData: Driver<[String]>
    let presentAlert: Signal<Alert>
    let push: Driver<CategoryViewModel> // 카테고리 푸시 이벤트
    
    // View -> ViewModel
    let itemSelected = PublishRelay<Int>() // 아이템 선택 감지
    let submitButtonTapped = PublishRelay<Void>() // 제출 버튼 탭 감지
    
    init(model: MainModel = MainModel()) {
        //MARK:-cell data
        // 보이는 초기 텍스트들을 driver로 한번에 전달
        let title = Observable.just("글 제목")
        let categoryViewModel = CategoryViewModel()
        let category = categoryViewModel
            .selectedCategory
            .map { $0.name } // 선택된 카테고리 표현
            .startWith("카테고리 선택") // 시작은 아무것도 선택 안한 상태라 placeholder!
        
        let price = Observable.just("₩ 가격 (선택사항)")
        let detail = Observable.just("내용을 입력하세요.")
        
        self.cellData = Observable
            .combineLatest( // 데이터 묶어주기
                title,
                category,
                price,
                detail
            ) { [$0, $1, $2, $3] }
            .asDriver(onErrorDriveWith: .empty()) // 에러나면 빈 array로~
        
        //MARK:-present alert
        let titleMessage = titleTextFieldCellViewModel
            .titleText // 타이틀 텍스트를 확인해 본다.
            .map { $0?.isEmpty ?? true } // 비어있으면 true
            .startWith(true) // 초기값은 true
            .map { $0 ? ["- 글 제목을 입력해주세요."] : [] } // 내용을 입력했다면 아무 메시지도 보내지 x
        
        let categoryMessage = categoryViewModel
            .selectedCategory // 선택된 카테고리를 확인해본다.
            .map { _ in false }
            .startWith(true) // 초기값은 true
            .map { $0 ? ["- 카테고리를 선택해주세요."] : [] }
        
        let detailMessage = detailWriteFormCellViewModel
            .contentValue // 콘텐츠 텍스트를 확인해 본다.
            .map { $0?.isEmpty ?? true }
            .startWith(true)
            .map { $0 ? ["- 내용을 입력해주세요."] : [] }
        
        let errorMessages = Observable
            .combineLatest( // 가장 최근의 에러 메시지 합쳐줌
                titleMessage,
                categoryMessage,
                detailMessage
            ) { $0 + $1 + $2 }
        
        self.presentAlert = submitButtonTapped // 제출 버튼을 트리거로 사용
            .withLatestFrom(errorMessages)
            .map(model.setAlert)
            .asSignal(onErrorSignalWith: .empty())
        
        //MARK:-push
        self.push = itemSelected
            .compactMap { row -> CategoryViewModel? in
                guard case 1 = row else { // 카테고리 셀을 선택했을 때만
                    return nil
                }
                return categoryViewModel
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
