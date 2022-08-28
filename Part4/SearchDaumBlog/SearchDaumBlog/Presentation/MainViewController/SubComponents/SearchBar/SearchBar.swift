//
//  SearchBar.swift
//  SearchDaumBlog
//
//  Created by 김수빈 on 2022/08/29.
//

import RxSwift
import RxCocoa
import UIKit
import SnapKit

class SearchBar: UISearchBar{
    let disposeBag = DisposeBag()
    
    let searchButton = UIButton()
    
    //SearchBar 버튼 탭 이벤트
    let searchButtonTapped = PublishRelay<Void>()
    
    //SearchBar 외부로 내보낼 이벤트
    var shouldLoadResult = Observable<String>.of("")
    
    override init(frame: CGRect){
        super.init(frame: frame)
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(){
        Observable
            .merge( // searchBar의 검색 버튼과, 커스텀 검색 버튼 눌렀을때 이벤트 통합
                self.rx.searchButtonClicked.asObservable(),
                searchButton.rx.tap.asObservable()
            )
            .bind(to: searchButtonTapped)
            .disposed(by: disposeBag)
        
        searchButtonTapped
            .asSignal()
            .emit(to: self.rx.endEditing) // 커스텀 델리게이트와 연결
            .disposed(by: disposeBag)
        
        self.shouldLoadResult = searchButtonTapped // 트리거: 가장 최근의 text를 보내줘라
            .withLatestFrom(self.rx.text){ $1 ?? ""} // 없으면 빈값으로
            .filter{ !$0.isEmpty }
            .distinctUntilChanged() // 동일한건 한번만 처리
    }
    
    private func attribute(){
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    private func layout(){
        addSubview(searchButton)
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-12)
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}

// rx extension
extension Reactive where Base: SearchBar{
    var endEditing: Binder<Void>{
        return Binder(base){base, _ in
            base.endEditing(true)
        }
    }
}
