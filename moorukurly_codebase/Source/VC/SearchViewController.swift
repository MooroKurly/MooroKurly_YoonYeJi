//
//  SearchViewController.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/05/28.
//

import UIKit

class SearchViewController: UIViewController {

    var headerView = HeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.titleLabel.text = "검색"
        view.addSubview(headerView)
        
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
