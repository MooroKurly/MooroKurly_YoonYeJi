//
//  MyPageTableViewCell.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/06/17.
//

import UIKit

class MyPageTableViewCell: UITableViewCell {

    var titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
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
        addSubviews(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-15)
            $0.leading.equalToSuperview().offset(16)
        }
    }
    
    func setData(title: String) {
        titleLabel.text = title
    }
}
