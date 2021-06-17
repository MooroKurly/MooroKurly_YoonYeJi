//
//  BannerCollectionViewCell.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/05/28.
//

import UIKit
import Kingfisher

class BannerCollectionViewCell: UICollectionViewCell {
    
    var bannerImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bannerImageView)
        
        bannerImageView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(bannerImage: String) {
        bannerImageView.kf.setImage(with: URL(string: bannerImage))
    }
    
}
