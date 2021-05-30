//
//  CustomTabCollectionViewCell.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/05/28.
//

import UIKit
import SnapKit

class CustomTabCollectionViewCell: UICollectionViewCell {
    
    var tabButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tabButton)
        
        tabButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.bottom.equalToSuperview().offset(-14)
            $0.centerX.centerY.equalToSuperview()
        }
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
