//
//  BenefitsCollectionViewCell.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/05/30.
//

import UIKit

import Then

class BenefitsCollectionViewCell: UICollectionViewCell {
    
    var productImageView = UIImageView()
    
    var titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    var subTitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        $0.textColor = UIColor(red: 152 / 255, green: 153 / 255, blue: 154 / 255, alpha: 1.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(productImageView, titleLabel, subTitleLabel)
        
        productImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(94)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.top).offset(26)
            $0.leading.equalTo(productImageView.snp.trailing).offset(20)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.equalTo(productImageView.snp.trailing).offset(20)
            $0.bottom.equalTo(productImageView.snp.bottom).offset(-26)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(productImage: String,
                 title: String,
                 subTitle: String) {
        
        if let image = UIImage(named: productImage) {
            productImageView.image = image
        }
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
    
    
    
}
