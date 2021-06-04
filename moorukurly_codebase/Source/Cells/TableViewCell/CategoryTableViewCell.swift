//
//  TableViewCell.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/06/02.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    var categoryIconImageView = UIImageView()
    var categoryNameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    }
    var moreButton = UIButton().then {
        $0.setImage(UIImage(named: "btn_more"), for: .normal)
    }
    var separateLineView = UIView().then {
        $0.backgroundColor = .gray
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
        addSubviews(categoryIconImageView, categoryNameLabel, moreButton, separateLineView)
        
        categoryIconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(11)
            $0.bottom.equalToSuperview().offset(-11)
        }
        
        categoryNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-15)
            $0.leading.equalTo(categoryIconImageView.snp.trailing).offset(10)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
        }
        
        separateLineView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    func setData(categoryIcon: String,
                 categoryName: String) {
        if let image = UIImage(named: categoryIcon) {
            categoryIconImageView.image = image
        }
        
        categoryNameLabel.text = categoryName
        
    }
}
