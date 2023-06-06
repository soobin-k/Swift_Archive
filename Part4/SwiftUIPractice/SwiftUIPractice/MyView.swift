//
//  MyView.swift
//  SwiftUIPractice
//
//  Created by 김수빈 on 2023/06/07.
//

import SwiftUI

struct MyView: View {
    var body: some View {
      VStack {
        Text("Hello, World!")
          .font(.title)
        Text("만나서 반가워요")
      }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
