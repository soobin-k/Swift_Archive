//
//  OtherView.swift
//  Cafe
//
//  Created by 김수빈 on 2023/06/25.
//

import SwiftUI

struct OtherView: View {
    init() {
        UITableView.appearance().backgroundColor = .systemBackground
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Menu.allCases){ section in
                    Section(
                        header: Text(section.title)
                    ) {
                        ForEach(section.menu, id: \.hashValue) { raw in
                            Text(raw)
                            NavigationLink(raw, destination: Text("\(raw)"))
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Other")
            .toolbar {
                NavigationLink(
                   destination: SettingView(),
                   label: {
                       Image(systemName: "gear")
                   }
                )
            }
        }
    }
}

struct OtherView_Previews: PreviewProvider {
    static var previews: some View {
        OtherView()
    }
}
