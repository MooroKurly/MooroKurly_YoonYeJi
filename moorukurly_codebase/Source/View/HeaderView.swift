//
//  HeaderView.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/06/02.
//

import Foundation
import UIKit

class HeaderView: UIView {
 
    var headerBoxView = UIView().then {
        $0.backgroundColor = .purple
    }
    
    var titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = .white
    }
    
    var cartButton = UIButton().then {
        $0.setImage(UIImage(named: "btn_cart"), for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews(headerBoxView)
        headerBoxView.addSubviews(titleLabel, cartButton)
        
        headerBoxView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(88)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(headerBoxView.snp.centerX)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        cartButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-17)
            $0.bottom.equalToSuperview().offset(-14)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
