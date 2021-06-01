//
//  CategoryViewController.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/05/28.
//

import UIKit

class CategoryViewController: UIViewController {

    var headerView = HeaderView()
    var categoryTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        view.addSubviews(headerView)
        
        headerView.snp.makeConstraints {
            headerView.titleLabel.text = "카테고리"
            $0.top.leading.trailing.equalToSuperview()
        }
    }

}
