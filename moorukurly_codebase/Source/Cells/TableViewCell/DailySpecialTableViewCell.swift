//
//  DailySpecialTableViewCell.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/05/30.
//

import UIKit

class DailySpecialTableViewCell: UITableViewCell {
    
    // MARK: - UI properties
    var titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    
    var subTitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    }
    
    var dailySpecialCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        $0.backgroundColor = .white
        $0.isScrollEnabled = false
        $0.contentInset = UIEdgeInsets.zero
        $0.collectionViewLayout = layout
    }

    // MARK: - properties
    var saleProductList: [ProductModelData] = []
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUI(){
        addSubviews(titleLabel, dailySpecialCollectionView, subTitleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(76)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalTo(subTitleLabel.snp.top).offset(-6)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalTo(dailySpecialCollectionView.snp.top).offset(-16)
        }
        
        dailySpecialCollectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        dailySpecialCollectionView.delegate = self
        dailySpecialCollectionView.dataSource = self
        dailySpecialCollectionView.register(DailySpecialCollectionViewCell.self, forCellWithReuseIdentifier: "DailySpecialCollectionViewCell")
    }
    
    func setDummyData() {
        saleProductList = [
            ProductModelData(productImage: "imgDailysale", productName: "[Kurly’s] 간편하게 바삭, 통등심 돈까스", productSalePercent: "15%", productPrice: "19000원"),
            ProductModelData(productImage: "imgDailysale", productName: "[홍대쭈꾸미] 쭈꾸미볶음 300g", productSalePercent: "15%", productPrice: "5300원")
        ]
    }
}

extension DailySpecialTableViewCell: UICollectionViewDelegate {

}

extension DailySpecialTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return saleProductList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailySpecialCollectionViewCell", for: indexPath) as? DailySpecialCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        
        cell.setData(productImage: saleProductList[indexPath.row].productImage, remaingTime: "17:04:11", title: saleProductList[indexPath.row].productName, salePercent: saleProductList[indexPath.row].productSalePercent, price: saleProductList[indexPath.row].productPrice)
        
        return cell
    }
    
    
}

extension DailySpecialTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = UIScreen.main.bounds.width
        let cellWidth = width * (343/375)
        let height = cellWidth * (250/343)
        
        print(height)
        return CGSize(width: cellWidth, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
