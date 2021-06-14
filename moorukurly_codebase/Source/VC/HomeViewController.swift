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
    
    
    
    // MARK:- status Properties
    
    var tabSelectedIndex : Int = 0
    
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
    
    var separateLineView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    let footer = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 352))
    
    var footerImageView = UIImageView()
    
    var mainTableView = UITableView()
    
    var scrollView = UIScrollView(frame: .zero).then {
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
    }
    
    var tabIndicator = UIView().then {
        $0.backgroundColor = .purple
    }
    // MARK: - properties
    var tabList = ["컬리추천", "신상품", "베스트", "알뜰쇼핑", "특가/혜택"]
    
    let kurlyRecommandVC = KurlyRecommandViewController()
    let newProductVC = NewProductViewController()
    let bestVC = BestViewController()
    let shoppingVC = ShoppingViewController()
    let specialVC = SpecialViewController()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
        setScrollView()
    }
    
    
    func setDelegate() {
        customTabbarCollectionView.delegate = self
        customTabbarCollectionView.dataSource = self
        customTabbarCollectionView.register(CustomTabCollectionViewCell.self, forCellWithReuseIdentifier: "CustomTabCollectionViewCell")
    }

    func setUI() {
        view.addSubviews(headerView, logoImageView, cartButton, customTabbarCollectionView, customTabbarCollectionView, scrollView, separateLineView, tabIndicator)
        
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
    
        separateLineView.snp.makeConstraints {
            $0.top.equalTo(customTabbarCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(customTabbarCollectionView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        tabIndicator.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalTo(customTabbarCollectionView.snp.bottom)
            $0.height.equalTo(3)
            $0.width.equalTo(UIScreen.main.bounds.width * (69/375))
        }
        
    }
    
    func setScrollView() {
        scrollView.delegate = self
        scrollView.contentSize.width = self.view.frame.width * 5
        
        self.addChild(kurlyRecommandVC)
        guard let kurlyRecommandView = kurlyRecommandVC.view else { return }
        kurlyRecommandView.frame = CGRect(x: 0, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
        
        self.addChild(newProductVC)
        guard let newProductView = newProductVC.view else { return }
        newProductView.frame = CGRect(x: self.view.frame.width, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
        
        self.addChild(bestVC)
        guard let bestView = bestVC.view else { return }
        bestView.frame = CGRect(x: self.view.frame.width * 2, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
        
        self.addChild(shoppingVC)
        guard let shoppingView = shoppingVC.view else { return }
        shoppingView.frame = CGRect(x: self.view.frame.width * 3, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
        
        self.addChild(specialVC)
        guard let specialView = specialVC.view else { return }
        specialView.frame = CGRect(x: self.view.frame.width * 4, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
        
        scrollView.addSubviews(kurlyRecommandView, newProductView, bestView, shoppingView, specialView)
    }

}

// MARK: - 커스텀 탭바 메뉴

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        tabSelectedIndex = indexPath.row

        switch indexPath.row {
        case 0:
            scrollView.setContentOffset(CGPoint.zero, animated: true)
        case 1:
            scrollView.setContentOffset(CGPoint(x: self.scrollView.frame.width, y: 0), animated: true)
        case 2:
            scrollView.setContentOffset(CGPoint(x: self.scrollView.frame.width * 2, y: 0), animated: true)
        case 3:
            scrollView.setContentOffset(CGPoint(x: self.scrollView.frame.width * 3, y: 0), animated: true)
        case 4:
            scrollView.setContentOffset(CGPoint(x: self.scrollView.frame.width * 4, y: 0), animated: true)
        default:
            break
        }
        
        customTabbarCollectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomTabCollectionViewCell", for: indexPath) as? CustomTabCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.row != tabSelectedIndex {
            cell.setStatus(name: tabList[indexPath.row], isTouched: false)
        }
        else {
            cell.setStatus(name: tabList[indexPath.row], isTouched: true)
        }
    
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

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / UIScreen.main.bounds.width)
        
        switch page {
        case 0:
            tabSelectedIndex = 0
        case 1:
            tabSelectedIndex = 1
        case 2:
            tabSelectedIndex = 2
        case 3:
            tabSelectedIndex = 3
        case 4:
            tabSelectedIndex = 4
        default:
            break
        }
       
        customTabbarCollectionView.reloadData()
    }
    


    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 양 옆 마진 고려
        let cellwidth = UIScreen.main.bounds.width * (69/375)
    
        print((scrollView.contentOffset.x / UIScreen.main.bounds.width))
        tabIndicator.snp.updateConstraints {
            $0.leading.equalToSuperview().offset( (scrollView.contentOffset.x / UIScreen.main.bounds.width) * cellwidth + 16)
        }
    }
}

