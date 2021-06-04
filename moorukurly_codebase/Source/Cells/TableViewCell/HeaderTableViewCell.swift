//
//  HeaderTableViewCell.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/06/02.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    var headerBoxView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.text = "자주 사는 상품"
        $0.textColor = .purple
    }
    
    var moreButton = UIButton().then {
        $0.setImage(UIImage(named: "btn_more_purple"), for: .normal)
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI() {
        
        addSubviews(headerBoxView)
        headerBoxView.addSubviews(titleLabel, moreButton)
        
        headerBoxView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
        }
    
        
    }

}
