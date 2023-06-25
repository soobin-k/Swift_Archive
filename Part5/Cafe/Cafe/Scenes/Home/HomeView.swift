//
//  HomeView.swift
//  Cafe
//
//  Created by 김수빈 on 2023/06/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            HomeHeaderView(isNeedToReload: $viewModel.isNeedToReload)
            MenuSuggestionSectinonView(coffeeMenu: $viewModel.coffeeMenu)
            Spacer(minLength: 32.0)
            EventSectionView(events: $viewModel.events)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
