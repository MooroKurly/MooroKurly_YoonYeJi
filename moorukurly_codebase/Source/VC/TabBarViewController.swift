//
//  ViewController.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/05/28.
//

import UIKit

class TabBarViewController: UITabBarController {

    private let homeTab = HomeViewController()
    private let recommendTab = RecommendViewController()
    private let categoryTab = CategoryViewController()
    private let searchTab = SearchViewController()
    private let myTab = MyKurlyViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setTabBar()
        view.backgroundColor = .white
    }

    func setTabBar() {
        let tabBarVCs = [homeTab, recommendTab, categoryTab, searchTab, myTab]
 
        setTabBarIcon()
        tabBar.tintColor = .purple
    
        self.viewControllers = tabBarVCs
    }
    
    
    func setTabBarIcon() {
        homeTab.tabBarItem = UITabBarItem(title: "홈", image: .ic_home_selected, tag: 0)
        recommendTab.tabBarItem = UITabBarItem(title: "추천", image: .ic_recom_selected, tag: 0)
        categoryTab.tabBarItem = UITabBarItem(title: "카테고리", image: .ic_category_selected, tag: 0)
        searchTab.tabBarItem = UITabBarItem(title: "검색", image: .ic_search_selected, tag: 0)
        myTab.tabBarItem = UITabBarItem(title: "마이컬리", image: .ic_my_selected, tag: 0)
    }
}

