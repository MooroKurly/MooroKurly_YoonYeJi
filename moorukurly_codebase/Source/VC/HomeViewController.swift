//
//  HomeViewController.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/05/28.
//

import UIKit

import SnapKit
import Then

class HomeViewController: UIViewController {
    
    // MARK: - UI properties
    var headerView = UIView().then {
        $0.backgroundColor = .purple
    }
    
    var logoImageView = UIImageView().then {
        $0.image = UIImage(named: "img_logo")
    }
    
    var cartButton = UIButton().then {
        $0.setImage(UIImage(named: "btn_cart"), for: .normal)
    }
    
    var customTabbarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.backgroundColor = .white
        $0.isScrollEnabled = false
        $0.contentInset = UIEdgeInsets.zero
        $0.collectionViewLayout = layout
    }
    
    var topButton = UIButton().then {
        $0.setImage(UIImage(named: "buttonFloatingbtn"), for: .normal)
        $0.isHidden = true
    }
    
    let footer = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 352))
    
    var footerImageView = UIImageView()
    
    var mainTableView = UITableView()
    
    // MARK: - properties
    var tabList = ["컬리추천", "신상품", "베스트", "알뜰쇼핑", "특가/혜택"]
    
    let refreshControl = UIRefreshControl()
    
    let productDummyData: [ProductModelData] = [
        ProductModelData(productImage: "imgFood1", productName: "[우리밀] 백밀가루 & 옛밀가루", productSalePercent: "15%", productPrice: "19000원"),
        ProductModelData(productImage: "imgFood2", productName: "[홍대쭈꾸미] 쭈꾸미볶음 300g", productSalePercent: "15%", productPrice: "5300원"),
        ProductModelData(productImage: "imgFood3", productName: "[기와] LA갈비 800g", productSalePercent: "15%", productPrice: "19000원"),
    ]
    
    let productDummyData2: [ProductModelData] = [
        ProductModelData(productImage: "imgProduct", productName: "[윤예지] 윤예지표", productSalePercent: "15%", productPrice: "19000원"),
        ProductModelData(productImage: "imgProduct", productName: "[홍대쭈꾸미] 쭈꾸미볶음 300g", productSalePercent: "15%", productPrice: "5300원"),
        ProductModelData(productImage: "imgProduct", productName: "[기와] LA갈비 800g", productSalePercent: "15%", productPrice: "19000원"),
    ]
    
    var cachedPosition : [CGFloat] = [0,0,0,0,0,0,0]
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
        initRefresh()
    }
    
    
    func setDelegate() {
        customTabbarCollectionView.delegate = self
        customTabbarCollectionView.dataSource = self
        customTabbarCollectionView.register(CustomTabCollectionViewCell.self, forCellWithReuseIdentifier: "CustomTabCollectionViewCell")
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(BannerTableViewCell.self, forCellReuseIdentifier: "BannerTableViewCell")
        mainTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
        mainTableView.register(DailySpecialTableViewCell.self, forCellReuseIdentifier: "DailySpecialTableViewCell")
        mainTableView.register(BenefitsTableViewCell.self, forCellReuseIdentifier: "BenefitsTableViewCell")
    }

    func setUI() {
        view.addSubviews(headerView, logoImageView, cartButton, customTabbarCollectionView, customTabbarCollectionView, mainTableView, footerImageView, topButton)
        
        footer.addSubview(footerImageView)
        
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(88)
        }
        
        logoImageView.snp.makeConstraints {
            $0.bottom.equalTo(headerView).offset(-5)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        cartButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-17)
            $0.bottom.equalTo(headerView).offset(-14)
        }
        
        customTabbarCollectionView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        mainTableView.snp.makeConstraints {
            $0.top.equalTo(customTabbarCollectionView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        footerImageView.snp.makeConstraints {
            if let image = UIImage(named: "footerImage") {
                footerImageView.image = image
            }
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-60)
        }
        
        topButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-98)
            $0.width.height.equalTo(47)
        }
        
        topButton.addTarget(self, action: #selector(topButtonClicked), for: .touchUpInside)
            
        mainTableView.separatorStyle = .none
        footer.backgroundColor = UIColor(red: 246 / 255, green: 247 / 255, blue: 248 / 255, alpha: 1.0)
        mainTableView.tableFooterView = footer
    }
    
    @objc func topButtonClicked() {
        let indexPath = IndexPath(row: 0, section:0)
        self.mainTableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }
    
    func initRefresh() {
        refreshControl.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        mainTableView.refreshControl = refreshControl
    }
    
    @objc func refreshTable(refresh: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.mainTableView.reloadData()
            refresh.endRefreshing()
        }
    }

}

// MARK: - 커스텀 탭바 메뉴

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomTabCollectionViewCell", for: indexPath) as? CustomTabCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.tabButton.setTitle(tabList[indexPath.row], for: .normal)
        
        return cell
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let cellwidth = width * (69/375)
        
        return CGSize(width: cellwidth, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}


// MARK: - 홈뷰를 구성하는 메인 테이블뷰

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 없어졌을 때 호출
        if let cell = cell as? ProductTableViewCell {
//            print(indexPath.row)
            cachedPosition[indexPath.section] = cell.productCollectionView.contentOffset.x
//            print("current Cache",cachedPosition)
        }
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: // 배너
            let width = UIScreen.main.bounds.width
            let cellWidth = UIScreen.main.bounds.width * (375/375)
            let height = width * (345/cellWidth)
            return height
        case 1: // 이 상품 어때요?
            let cellWidth = UIScreen.main.bounds.width * (375/375)
            let height = cellWidth * (333/cellWidth)
            return height
        case 2: // 일일특가
            return 650
        case 3: // 특가/혜택
            return 406
        case 4: // 놓치면 후회할 가격
            let width = UIScreen.main.bounds.width
            let cellWidth = UIScreen.main.bounds.width * (375/375)
            let height = width * (345/cellWidth)
            return height
        default:
            return 340
        }
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: // 배너 
            guard let bannerCell = tableView.dequeueReusableCell(withIdentifier: "BannerTableViewCell", for: indexPath)
                    as? BannerTableViewCell else { return UITableViewCell() }
            bannerCell.selectionStyle = .none
            bannerCell.backgroundColor = .white
            bannerCell.setUI()
            return bannerCell
        case 1: // 이 상품 어때요?
            guard let productCell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else {
                return UITableViewCell() }
            productCell.selectionStyle = .none
            productCell.setUI()
            productCell.titleLabel.text = "이 상품 어때요?"
            productCell.setData(productList: productDummyData)
            productCell.productCollectionView.contentOffset.x = cachedPosition[indexPath.section]
            return productCell
        case 2: // 일일특가
            guard let dailySpecialCell = tableView.dequeueReusableCell(withIdentifier: "DailySpecialTableViewCell", for: indexPath) as? DailySpecialTableViewCell else {
                return UITableViewCell() }
            dailySpecialCell.selectionStyle = .none
            dailySpecialCell.titleLabel.text = "일일특가"
            dailySpecialCell.subTitleLabel.text = "24시간 한정 특가"
            dailySpecialCell.setDummyData()
            dailySpecialCell.setUI()
            return dailySpecialCell
        case 3: // 특가/혜택
            guard let benefitCell = tableView.dequeueReusableCell(withIdentifier: "BenefitsTableViewCell", for: indexPath) as? BenefitsTableViewCell else {
                return UITableViewCell() }
            benefitCell.selectionStyle = .none
            benefitCell.backgroundColor = UIColor(red: 246 / 255, green: 247 / 255, blue: 248 / 255, alpha: 1.0)
            benefitCell.titleLabel.text = "특가/혜택"
            benefitCell.setUI()
            return benefitCell
        case 4: // 놓치면 후회할 가격
            guard let regretCell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else {
                return UITableViewCell() }
            regretCell.selectionStyle = .none
            regretCell.setUI()
            regretCell.titleLabel.text = "놓치면 후회할 가격"
            regretCell.setData(productList: productDummyData2)
            regretCell.productCollectionView.contentOffset.x = cachedPosition[indexPath.section]

            return regretCell
        default:
            return UITableViewCell()
        }
    }
}


extension HomeViewController: UIScrollViewDelegate {
    // 테이블뷰 스크롤 될 때마다 호출되는 함수.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let initialPoint = CGPoint(x: 0, y: 0)
        
        if mainTableView.contentOffset.y - initialPoint.y > 100 {
            UIView.animate(withDuration: 1.0) {
                self.topButton.alpha = 1.0
                self.topButton.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.topButton.alpha = 0.0
            }
        }
    }
}
