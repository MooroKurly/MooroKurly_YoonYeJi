//
//  DailySpecialCollectionViewCell.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/05/30.
//

import UIKit

import Then

class DailySpecialCollectionViewCell: UICollectionViewCell {
    var productImageView = UIImageView()
    
    var remainingTimeLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .white
    }
    
    var saleBoxView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.4, green: 0.0, blue: 0.52, alpha: 0.5)
    }
    
    var titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.numberOfLines = 2
    }
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
        
        addSubviews(productImageView, saleBoxView, remainingTimeLabel, titleLabel, salePercentLabel, priceLabel)
        
        productImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(173)
        }
        
        saleBoxView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(139)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(34)
        }
        
        remainingTimeLabel.snp.makeConstraints {
            $0.top.equalTo(saleBoxView).offset(6)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(9)
            $0.leading.equalToSuperview()
        }
        
        salePercentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-34)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.left.equalTo(salePercentLabel.snp.right).offset(10)
            $0.bottom.equalToSuperview().offset(-34)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setData(productImage: String,
                 remaingTime: String,
                 title: String,
                 salePercent: String,
                 price: String) {
        productImageView.kf.setImage(with: URL(string: productImage))
        remainingTimeLabel.text = remaingTime
        titleLabel.text = title
        salePercentLabel.text = salePercent + "%"
        priceLabel.text = price + "원"
    }
 
}
