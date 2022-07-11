//
//  RoundButton.swift
//  calculatorApp
//
//  Created by 김수빈 on 2022/07/12.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var isRound: Bool = false {
        didSet{
            if isRound{
                self.layer.cornerRadius = self.frame.height / 3
            }
        }
    }
}
