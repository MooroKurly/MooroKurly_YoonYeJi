//
//  kurlyRecommandViewController.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/06/11.
//

import UIKit

class KurlyRecommandViewController: UIViewController {

    // MARK: - UI Properties
    
    var mainTableView = UITableView()
    
    let footer = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 352))
    
    var footerImageView = UIImageView()
    
    var topButton = UIButton().then {
        $0.setImage(UIImage(named: "buttonFloatingbtn"), for: .normal)
        $0.isHidden = true
    }
    
    let refreshControl = UIRefreshControl()
    
    // MARK: - Properties
    
    var cachedPosition : [CGFloat] = [0,0,0,0,0,0,0]
    
    let productDummyData: [ProductModelData] = [    ]
    
    var handler: ((Result<[ProductModelData], Error>) -> Void)!
    var eventHandler: ((Result<[EventDataModel], Error>) -> Void)!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
        initRefresh()
    }
    
    
    func setDelegate() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(BannerTableViewCell.self, forCellReuseIdentifier: "BannerTableViewCell")
        mainTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
        mainTableView.register(DailySpecialTableViewCell.self, forCellReuseIdentifier: "DailySpecialTableViewCell")
        mainTableView.register(BenefitsTableViewCell.self, forCellReuseIdentifier: "BenefitsTableViewCell")
    }
    
    func setUI() {
        
        view.addSubviews(mainTableView, footer, topButton)
        footer.addSubview(footerImageView)
        
        mainTableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
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

// MARK: - 홈뷰를 구성하는 메인 테이블뷰

extension KurlyRecommandViewController: UITableViewDelegate {
    
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
            return 400
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

extension KurlyRecommandViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: // 배너
            guard let bannerCell = tableView.dequeueReusableCell(withIdentifier: "BannerTableViewCell", for: indexPath)
                    as? BannerTableViewCell else { return UITableViewCell() }
            bannerCell.serverConneted()
            bannerCell.selectionStyle = .none
            bannerCell.backgroundColor = .white
            bannerCell.setUI()
            return bannerCell
        case 1: // 이 상품 어때요?
            guard let productCell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else {
                return UITableViewCell() }
            productCell.selectionStyle = .none
            handler = { result in
                switch result {
                case .success(let product):
                    productCell.setData(productList: product)
                case .failure(let err):
                    print("에러")
                    print(err)
                }
            }
            RecommandService.shared.getThisItem(completion: handler)
            productCell.setUI()
            productCell.titleLabel.text = "이 상품 어때요?"
            productCell.productCollectionView.contentOffset.x = cachedPosition[indexPath.section]
            return productCell
        case 2: // 일일특가
            guard let dailySpecialCell = tableView.dequeueReusableCell(withIdentifier: "DailySpecialTableViewCell", for: indexPath) as? DailySpecialTableViewCell else {
                return UITableViewCell() }
            dailySpecialCell.selectionStyle = .none
            handler = { result in
                switch result {
                case .success(let product):
                    dump(product)
                    dailySpecialCell.setData(productList: product)
                    dailySpecialCell.dailySpecialCollectionView.reloadData()
                case .failure(let err):
                    print("에러")
                    print(err)
                }
            }
            RecommandService.shared.getOnedayItem(completion: handler)
            dailySpecialCell.titleLabel.text = "일일특가"
            dailySpecialCell.subTitleLabel.text = "24시간 한정 특가"
            dailySpecialCell.setUI()
            return dailySpecialCell
        case 3: // 특가/혜택
            guard let benefitCell = tableView.dequeueReusableCell(withIdentifier: "BenefitsTableViewCell", for: indexPath) as? BenefitsTableViewCell else {
                return UITableViewCell() }
            eventHandler = { result in
                switch result {
                case .success(let product):
                    benefitCell.imageList = product
                    benefitCell.BenefitsCollectionView.reloadData()
                case .failure(let err):
                    print(err)
                }
            }
            RecommandService.shared.getEventItem(completion: eventHandler)
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
            handler = { result in
                switch result {
                case .success(let product):
                    regretCell.setData(productList: product)
                case .failure(let err):
                    print("에러")
                    print(err)
                }
            }
            RecommandService.shared.getBigSaleItem(completion: handler)
            regretCell.productCollectionView.contentOffset.x = cachedPosition[indexPath.section]
            return regretCell
        default:
            return UITableViewCell()
        }
    }
}


extension KurlyRecommandViewController: UIScrollViewDelegate {
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
