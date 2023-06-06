//
//  ContentView.swift
//  NetflixStyleCollectionViewSampleApp
//
//  Created by 김수빈 on 2023/06/07.
//

import SwiftUI

struct ContentView: View {
    let titles = ["Netflix Sample App"]
    var body: some View {
        NavigationView {
            List(titles, id: \.self) {
                let netflixVC = HomeViewControllerRepresentable()
                    .navigationBarHidden(true) // 내비바 hidden
                    .edgesIgnoringSafeArea(.all) // 전체 화면 채우기
                NavigationLink($0, destination: netflixVC)
            }
            .navigationTitle("SwiftUI to UIKit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
