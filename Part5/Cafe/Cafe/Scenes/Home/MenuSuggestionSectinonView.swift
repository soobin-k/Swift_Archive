//
//  MenuSuggestionSectinonView.swift
//  Cafe
//
//  Created by 김수빈 on 2023/06/25.
//

import SwiftUI

struct MenuSuggestionSectinonView: View {
    @Binding var coffeeMenu: [CoffeeMenu]
    
    var body: some View {
        VStack {
            Text("\(User.shared.username)님을 위한 추천메뉴")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16.0)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(coffeeMenu) { menu in
                        MenuSuggestionItemView(coffeeMenu: menu)
                    }
                }
                .padding(.horizontal, 16.0)
            }
        }
    }
}

struct MenuSuggestionItemView: View {
    let coffeeMenu: CoffeeMenu
    
    var body: some View {
        VStack {
            coffeeMenu.image
                .resizable()
                .clipShape(Circle())
                .frame(width: 100.0, height: 100.0)
            Text(coffeeMenu.name)
                .font(.caption)
        }
    }
}
