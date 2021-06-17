//
//  NoLoginView.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/06/17.
//

import UIKit

class NoLoginView: UIView {
    
    var guideLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.text = "회원 가입하고\n다양한 혜택을 받아보세요!"
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    
    var joinBenefitsLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.text = "가입 혜택 보기 >"
        $0.textColor = .darkGray
    }
    
    var loginButton = UIButton().then {
        $0.backgroundColor = .purple
        $0.setTitle("로그인/회원가입", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        $0.layer.cornerRadius = 3
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(guideLabel, joinBenefitsLabel, loginButton)
        
        guideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
        }
        
        joinBenefitsLabel.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(joinBenefitsLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(40)
        }
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
