//
//  HomeHeaderView.swift
//  Cafe
//
//  Created by 김수빈 on 2023/06/25.
//

import SwiftUI

struct HomeHeaderView: View {
    @Binding var isNeedToReload: Bool
    
    var body: some View {
        VStack(spacing: 16.0) {
            HStack {
                Text("""
                \(User.shared.username)님~
                반갑습니다!👋🏻
                """)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true) // 세로 사이즈 조정
                Button(action: {
                    isNeedToReload = true
                }, label: {
                    Image(systemName: "arrow.2.circlepath")
                })
                .frame(alignment: .top)
            }
            HStack {
                Button(action: {}) {
                   Image(systemName: "mail")
                        .foregroundColor(.secondary)
                    Text("What's New")
                        .foregroundColor(.primary)
                        .font(.system(size: 16.0, weight: .semibold, design: .default))
                }
                Button(action: {}) {
                   Image(systemName: "ticket")
                        .foregroundColor(.secondary)
                    Text("Coupon")
                        .foregroundColor(.primary)
                        .font(.system(size: 16.0, weight: .semibold, design: .default))
                }
                Spacer() // 간격이 최대한으로 늘어나게됨
                Button(action: {}) {
                   Image(systemName: "bell")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(16.0)
    }
}
