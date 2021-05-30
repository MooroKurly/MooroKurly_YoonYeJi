//
//  BannerCollectionViewCell.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/05/28.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    var bannerImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bannerImage)
        
        bannerImage.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(BannerImage: String) {
        if let image = UIImage(named: BannerImage) {
            bannerImage.image = image
        }
    }
    
}
