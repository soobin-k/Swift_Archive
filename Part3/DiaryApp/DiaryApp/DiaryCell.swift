//
//  DiaryCell.swift
//  DiaryApp
//
//  Created by 김수빈 on 2022/07/19.
//

import UIKit

class DiaryCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    required init?(coder: NSCoder) {
      super.init(coder: coder)
      self.contentView.layer.cornerRadius = 3.0
      self.contentView.layer.borderWidth = 1.0
      self.contentView.layer.borderColor = UIColor.black.cgColor
    }
}
