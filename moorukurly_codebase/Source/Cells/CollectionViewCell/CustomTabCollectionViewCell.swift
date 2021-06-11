//
//  CustomTabCollectionViewCell.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/05/28.
//

import UIKit
import SnapKit

class CustomTabCollectionViewCell: UICollectionViewCell {
    
    var tabLabel = UILabel().then {
//        $0.setTitleColor(.black, for: .normal)
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .darkGray
    }
    
    override var isHighlighted: Bool{
        didSet{
            tabLabel.textColor = isHighlighted ? .purple : .darkGray
        }
    }
    
    override var isSelected: Bool{
        didSet{
            tabLabel.textColor = isSelected ? .purple : .darkGray
        }
    }
    
    var isFirst: Bool = true
         
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tabLabel)
        
        tabLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.bottom.equalToSuperview().offset(-14)
            $0.centerX.centerY.equalToSuperview()
        }
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
