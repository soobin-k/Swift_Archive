//
//  EventSectionView.swift
//  Cafe
//
//  Created by 김수빈 on 2023/06/25.
//

import SwiftUI

struct EventSectionView: View {
    @Binding var events: [Event]
    
    var body: some View {
        VStack {
            HStack {
                Text("Events")
                    .font(.headline)
                Spacer()
                Button("See all") {}
                    .accentColor(.green)
                    .font(.subheadline)
            }
            .padding(.horizontal, 16.0)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(events) { event in
                        EventSectionItemView(event: event)
                    }
                }
            }
            .frame(maxWidth: .infinity, minHeight: 220, maxHeight: .infinity)
            .padding(.horizontal, 16.0)
        }
    }
}

struct EventSectionItemView: View {
    let event: Event
    
    var body: some View {
        VStack {
            event.image
            // 아래 코드 순서 중요
                .resizable() // <- 제일 먼저 적용해야함
                .scaledToFill()
                .frame(height: 150.0)
                .clipped() // 자르기
            Text(event.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
            Text(event.description)
                .lineLimit(1)
                .font(.callout)
                .frame(maxWidth: .infinity, alignment: .topLeading)
        }.frame(width: UIScreen.main.bounds.width - 32.0)
    }
}
