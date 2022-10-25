//
//   LocationInformationViewModel.swift
//  FindCVS
//
//  Created by 김수빈 on 2022/10/23.
//

import RxSwift
import RxCocoa

struct LocationInformationViewModel{
    let disposeBag = DisposeBag()
    
    //subViewModels
    let detailListBackgroundViewModel = DetailListBackgroundViewModel()
    
    //viewModel -> view
    let setMapCenter: Signal<MTMapPoint>
    let errorMessage: Signal<String>
    let detailListCellData: Driver<[DetailListCellData]>
    let scrollToSelectedLocation: Signal<Int>
    
    //view -> viewModel
    let currentLocation = PublishRelay<MTMapPoint>()
    let mapCenterPoint = PublishRelay<MTMapPoint>()
    let selectPOIItem = PublishRelay<MTMapPOIItem>()
    let mapViewError = PublishRelay<String>()
    let curentLocationButtonTapped = PublishRelay<Void>()
    let detailListItemSelected = PublishRelay<Int>()
    
    let documentData = PublishSubject<[KLDocument?]>()
    
    init(){
        //MARK: 지도 중심점 설정
        let selectDetailListItem = detailListItemSelected
            .withLatestFrom(documentData) { $1[$0]}
            .map { data -> MTMapPoint in
               guard let data = data,
                     let longtitue = Double(data.x),
                     let latitude = Double(data.y) else{
                   return MTMapPoint()
               }
                let geoCoord = MTMapPointGeo(latitude: latitude, longitude: longtitue)
                return MTMapPoint(geoCoord: geoCoord)
            }
        
        let moveToCurrentLocation = curentLocationButtonTapped.withLatestFrom(currentLocation)
        
        let currentMapCenter = Observable
            .merge(
                selectDetailListItem, // 리스트를 선택했거나
                currentLocation.take(1), // 최초로 현재 위치 받았을 때
                moveToCurrentLocation // 현재 위치 이동
            )
        setMapCenter = currentMapCenter
            .asSignal(onErrorSignalWith: .empty())
        errorMessage = mapViewError.asObservable()
            .asSignal(onErrorJustReturn: "잠시 후 다시 시도해주세요.")
        
        detailListCellData = Driver.just([])
        
        scrollToSelectedLocation = selectPOIItem
            .map{$0.tag}
            .asSignal(onErrorJustReturn: 0)
    }
}
