//
//  ProductCollectionViewCell.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/05/28.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    var productImageView = UIImageView()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    var salePercentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .orange
        return label
    }()
    var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(productImageView, titleLabel, salePercentLabel, priceLabel)
        
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
            $0.right.equalTo(priceLabel.snp.left).offset(-9)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(productImage: String,
                 title: String,
                 salePercent: String,
                 price: String) {
        if let image = UIImage(named: productImage) {
            productImageView.image = image
        }
        titleLabel.text = title
        salePercentLabel.text = salePercent
        priceLabel.text = price
    }
}
