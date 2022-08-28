//
//  Alert.swift
//  SearchDaumBlog
//
//  Created by 김수빈 on 2022/08/29.
//

import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
