//
//  ProductCollectionViewCell.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/05/28.
//

import UIKit

import Then
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {
    
    var productImageView = UIImageView()

    var titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.numberOfLines = 2
    }
    
    var salePercentLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .orange
    }
    
    var discountPriceLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    }
 
    var priceLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .darkGray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(productImageView, titleLabel, salePercentLabel, discountPriceLabel, priceLabel)
        
        productImageView.snp.makeConstraints {
            $0.top.leading.right.equalToSuperview()
            $0.height.equalTo(195)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(10)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        salePercentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.left.equalToSuperview()
        }
        
        discountPriceLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(salePercentLabel.snp.trailing).offset(9)
        }
       
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(discountPriceLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(productImage: String,
                 title: String,
                 salePercent: String,
                 price: String) {
        productImageView.kf.setImage(with: URL(string: productImage))
        titleLabel.text = title
        if salePercent != "0" {
            salePercentLabel.text = salePercent + "%"
        }
        discountPriceLabel.text = price + "원"
        priceLabel.text = String(Int(price)! + Int(price)! * Int(salePercent)! / 100) + "원"
        priceLabel.attributedText = priceLabel.text?.strikeThrough()
    }
}
