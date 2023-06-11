//
//  SelectRegionViewModel.swift
//  FindCoronaCenter
//
//  Created by 김수빈 on 2023/06/11.
//

import Foundation
import Combine

class SelectRegionViewModel: ObservableObject { // 외부에서 바라볼 수 있는 object다.
    @Published var centers = [Center.Sido: [Center]]()
    private var cancellables = Set<AnyCancellable>() // rx의 disposeBag과 유사
    
    init(centerNetwork: CenterNetwork = CenterNetwork()) {
        centerNetwork.getCenterList()
            .receive(on: DispatchQueue.main)
            .sink (receiveCompletion: { [weak self] in
                guard case .failure(let error) = $0 else { return }
                print(error.localizedDescription)
                self?.centers = [Center.Sido: [Center]]()
            }, receiveValue: { [weak self] centers in
                self?.centers = Dictionary(grouping: centers) { $0.sido }
            })
            .store(in: &cancellables) // disposed(by: disposeBag)
    }
}
