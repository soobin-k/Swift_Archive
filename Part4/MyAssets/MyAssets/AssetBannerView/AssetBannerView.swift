//
//  AssetBannerView.swift
//  MyAssets
//
//  Created by 김수빈 on 2023/06/11.
//

import SwiftUI

struct AssetBannerView: View {
    let bannerList: [AssetBanner] = [
        AssetBanner(title: "공지사항", description: "추가된 공지사항을 확인하세요", backgroundColor: .red),
        AssetBanner(title: "공지사항", description: "추가된 공지사항을 확인하세요", backgroundColor: .orange),
        AssetBanner(title: "공지사항", description: "추가된 공지사항을 확인하세요", backgroundColor: .yellow),
        AssetBanner(title: "공지사항", description: "추가된 공지사항을 확인하세요", backgroundColor: .green)
    ]
    
    @State private var currentPage = 0
    
    var body: some View {
        let bannerCards = bannerList.map { BannerCard(banner: $0) }
        
        ZStack(alignment: .bottomTrailing) {
            PageViewController(
                pages: bannerCards,
                currentPage: $currentPage
            )
            
            PageControl(
                numberOfPages: bannerList.count,
                currentPage: $currentPage
            )
            .frame(width: CGFloat(bannerCards.count * 18))
            .padding(.trailing)
            
        }
    }
}

struct AssetBannerView_Previews: PreviewProvider {
    static var previews: some View {
        AssetBannerView()
            .aspectRatio(5/2, contentMode: .fit)
    }
}
