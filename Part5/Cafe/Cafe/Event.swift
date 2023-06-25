//
//  Event.swift
//  Cafe
//
//  Created by 김수빈 on 2023/06/25.
//

import SwiftUI

struct Event: Identifiable {
    let id = UUID()
    
    let image: Image
    let title: String
    let description: String
    
    static let sample: [Event] = [
        Event(image: Image("coffee"), title: "제주도 한정 메뉴", description: "제주도 한정 메뉴가 출시되었습니다! 꼭 드셔보세요"),
        Event(image: Image("coffee"), title: "제주도 한정 메뉴", description: "제주도 한정 메뉴가 출시되었습니다! 꼭 드셔보세요")
    ]
}
