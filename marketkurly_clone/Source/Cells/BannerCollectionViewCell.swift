//
//  BannerCollectionViewCell.swift
//  marketkurly_clone
//
//  Created by 윤예지 on 2021/05/12.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var BannerImageView: UIImageView!
    
    func setData(BannerImage: String) {
        if let image = UIImage(named: BannerImage) {
                    BannerImageView.image = image
                }
    }
}
