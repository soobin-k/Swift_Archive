//
//  User.swift
//  Cafe
//
//  Created by 김수빈 on 2023/06/25.
//

import SwiftUI

struct User {
    let username: String
    let account: String
    
    static let shared = User(username: "수빈", account: "tnqls27qks")
}
