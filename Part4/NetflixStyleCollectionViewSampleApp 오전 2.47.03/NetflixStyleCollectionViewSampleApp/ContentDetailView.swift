//
//  ContentDetailView.swift
//  NetflixStyleCollectionViewSampleApp
//
//  Created by 김수빈 on 2023/06/07.
//

import SwiftUI

struct ContentDetailView: View {
    @State var item: Item? // 상태를 받아야 view를 표현할 수 있음
    
    var body: some View {
        VStack {
            if let item = item {
                Image(uiImage: item.image)
                    .aspectRatio(contentMode: .fit)
                
                Text(item.description)
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                Color.white
            }
        }
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let item0 = Item(description: "흥미 진진, 판타지, 액션", imageName: "poster0")
        ContentDetailView(item: item0)
    }
}
