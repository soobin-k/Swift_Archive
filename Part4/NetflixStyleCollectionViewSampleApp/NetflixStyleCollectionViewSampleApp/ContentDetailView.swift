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
        ZStack(alignment: .bottom) {
            if let item = item {
                Image(uiImage: item.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                
                Text(item.description)
                      .font(.caption)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.primary)
                    .background(Color.primary.colorInvert().opacity(0.75))
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
