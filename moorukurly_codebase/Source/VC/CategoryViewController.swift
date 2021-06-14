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
    var categoryList: [CategoryDataModel] = [
        CategoryDataModel(image: "ic_bookmark", categoryName: "채소"),
        CategoryDataModel(image: "ic_bookmark", categoryName: "과일·견과·쌀"),
        CategoryDataModel(image: "ic_bookmark", categoryName: "수산·해물·건어물"),
        CategoryDataModel(image: "ic_bookmark", categoryName: "정육·계란"),
        CategoryDataModel(image: "ic_bookmark", categoryName: "국·반찬·메인요리"),
        CategoryDataModel(image: "ic_bookmark", categoryName: "샐러드·간편식"),
        CategoryDataModel(image: "ic_bookmark", categoryName: "면·양념·오일"),
        CategoryDataModel(image: "ic_bookmark", categoryName: "음료·우유·떡·간식"),
        CategoryDataModel(image: "ic_bookmark", categoryName: "베이커리·치즈·델리"),
        CategoryDataModel(image: "ic_bookmark", categoryName: "건강식품"),
        CategoryDataModel(image: "ic_bookmark", categoryName: "생활용품·리빙")
    ]
    
    var isOpen : [Bool] = [false, false, false, false, false, false, false, false, false, false, false]
    var rowOfCategory : [Int] = []
    var subCategoryList : [[String]] = [["친환경", "고구마·감자·당근", "시금치·쌈채소·나물"], ["친환경", "제철과일", "국산과일"], ["제철수산", "생선류", "굴비·반건류", "오징어·낙지·문어"], ["국내산 소고기", "수입산 소고기"],["국·탕·찌개","밀키트·메인요리"],["샐러드·닭가슴살","도시락·밥류","파스타·면류"],["식초·소스·드레싱","양념·액젓·장류"],["생수·탄산수", "음류·주스", "우유·두유·요거트"],["과자·스낵·쿠키", "초콜렛·젤리·캔디"],["식빵·빵류", "잼·버터·스프레드", "케이크·파이·디저트"],["영양제", "유산균", "홍삼·인삼·꿀"]]
    var clickedIndex: Int = 10 // 처음 index 에러 + didSelected 조건을 피하기 위한..
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...subCategoryList.count - 1 {
            rowOfCategory.append(subCategoryList[i].count - 1)
        }
        setUI()
    }
    
    func setUI() {
        view.addSubviews(headerView, categoryTableView)
        
        headerView.snp.makeConstraints {
            headerView.titleLabel.text = "카테고리"
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(88)
        }
        
        categoryTableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(0)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        categoryTableView.backgroundColor = .gray
        categoryTableView.separatorStyle = .none
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoryTableViewCell")
        categoryTableView.register(HeaderTableViewCell.self, forCellReuseIdentifier: "HeaderTableViewCell")
        categoryTableView.register(ExpandableTableViewCell.self, forCellReuseIdentifier: "ExpandableTableViewCell")
    }

}


extension CategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var newClickedIndex = indexPath.row
        if newClickedIndex > clickedIndex {
            newClickedIndex = newClickedIndex - rowOfCategory[clickedIndex] - 1
        }
        print(newClickedIndex)
        if isOpen[newClickedIndex] == false {
            isOpen[clickedIndex] = false
            isOpen[newClickedIndex] = true
        } else {
            isOpen[newClickedIndex] = false
        }
        clickedIndex = newClickedIndex
        categoryTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 69
        case 1:
            return 51
        default:
            return 340
        }
    }
}

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if isOpen[clickedIndex] == true {
                return categoryList.count + rowOfCategory[clickedIndex] + 1
            }
            return categoryList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath)
                    as? HeaderTableViewCell else { return UITableViewCell() }
            headerCell.setUI()
            headerCell.backgroundColor = .gray
            headerCell.selectionStyle = .none
            return headerCell
        case 1:
            if isOpen[clickedIndex] == true {
                switch indexPath.row {
                case clickedIndex+1...(clickedIndex+1)+rowOfCategory[clickedIndex]: // 클릭된 row 기준으로 더 그려줘야 할 row들..
                    guard let expandableCell = tableView.dequeueReusableCell(withIdentifier: "ExpandableTableViewCell", for: indexPath)
                            as? ExpandableTableViewCell else {
                        return UITableViewCell() }
                    expandableCell.setData(title: subCategoryList[clickedIndex][indexPath.row - clickedIndex - 1])
                    expandableCell.setUI()
                    expandableCell.backgroundColor = .gray
                    return expandableCell
                default:
                    guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath)
                            as? CategoryTableViewCell else { return UITableViewCell() }
                    return categoryCell
                }
            } else {
                guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath)
                        as? CategoryTableViewCell else { return UITableViewCell() }
                categoryCell.setData(categoryIcon: "ic_bookmark", categoryName: categoryList[indexPath.row].categoryName)
                categoryCell.setUI()
                categoryCell.selectionStyle = .none
                return categoryCell
            }
        default:
            return UITableViewCell()
        }
    }
}
