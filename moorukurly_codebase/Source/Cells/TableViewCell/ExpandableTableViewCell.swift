//
//  ExpandableTableViewCell.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/06/03.
//

import UIKit
import Then

class ExpandableTableViewCell: UITableViewCell {

    var titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .black
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUI() {
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.left.equalToSuperview().offset(59)
            $0.bottom.equalToSuperview().offset(-16)
        }

    }
    
    func setData(title: String) {
        titleLabel.text = title
    }

}
