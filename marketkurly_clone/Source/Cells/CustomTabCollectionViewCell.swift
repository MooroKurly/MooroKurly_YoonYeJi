//
//  CustomTabCollectionViewCell.swift
//  marketkurly_clone
//
//  Created by 윤예지 on 2021/05/12.
//

import UIKit

class CustomTabCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func setData(title: String) {
        self.titleLabel.text = title
    }
}
