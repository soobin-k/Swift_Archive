//
//  Event.swift
//  Cafe
//
//  Created by 김수빈 on 2023/06/25.
//

import SwiftUI

struct Event: Identifiable {
    let id = UUID()
    
    let image: Image
    let title: String
    let description: String
}
