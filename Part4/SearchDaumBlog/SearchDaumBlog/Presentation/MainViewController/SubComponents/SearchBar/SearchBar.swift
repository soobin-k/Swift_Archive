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
    
    override init(frame: CGRect){
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: SearchBarViewModel){
        self.rx.text
            .bind(to: viewModel.queryText)
            .disposed(by: disposeBag)
        
        Observable
            .merge( // searchBar의 검색 버튼과, 커스텀 검색 버튼 눌렀을때 이벤트 통합
                self.rx.searchButtonClicked.asObservable(),
                searchButton.rx.tap.asObservable()
            )
            .bind(to: viewModel.searchButtonTapped)
            .disposed(by: disposeBag)
        
        viewModel.searchButtonTapped
            .asSignal()
            .emit(to: self.rx.endEditing) // 커스텀 델리게이트와 연결
            .disposed(by: disposeBag)
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
