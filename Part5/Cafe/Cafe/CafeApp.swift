//
//  CafeApp.swift
//  Cafe
//
//  Created by 김수빈 on 2023/06/12.
//

import SwiftUI

@main
struct CafeApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView() // 앱의 초기 화면 설정
                .accentColor(.green) // 탭바 틴트 컬러
        }
    }
}
