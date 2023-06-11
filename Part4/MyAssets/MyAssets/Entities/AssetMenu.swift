//
//  AssetMenu.swift
//  MyAssets
//
//  Created by 김수빈 on 2023/06/08.
//

import Foundation

enum AssetMenu: String, Identifiable, Decodable {
    case creditScore
    case bankAccount
    case investment
    case loan
    case insurance
    case creditCard
    case cash
    case realEstate
    
    var id: String {
        return self.rawValue
    }
    
    var systemImageName: String {
        switch self {
        case .creditScore:
            return "number.circle"
        case .bankAccount:
            return "banknote"
        case .loan:
            return "hand.wave"
        case .insurance:
            return "lock.shield"
        case .cash:
            return "dollarsign.circle"
        case .realEstate:
            return "house.fill"
        case .investment:
            return "bitcoinsign.circle"
        case .creditCard:
            return "creditcard"
        }
    }
    
    var title: String {
        switch self {
        case .creditScore:
            return "신용점수"
        case .bankAccount:
            return "계좌"
        case .loan:
            return "대출"
        case .insurance:
            return "보험"
        case .cash:
            return "현금영수증"
        case .realEstate:
            return "부동산"
        case .investment:
            return "투자"
        case .creditCard:
            return "카드"
        }
    }
}
