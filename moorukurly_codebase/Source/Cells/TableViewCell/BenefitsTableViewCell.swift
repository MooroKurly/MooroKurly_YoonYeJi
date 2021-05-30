//
//  BenefitsTableViewCell.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/05/30.
//

import UIKit

class BenefitsTableViewCell: UITableViewCell {

    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    var BenefitsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 246 / 255, green: 247 / 255, blue: 248 / 255, alpha: 1.0)
        collectionView.isScrollEnabled = false
        layout.scrollDirection = .vertical
        return collectionView
    }()
    
    let imageList = ["imgSale1", "imgSale2", "imgSale3"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUI() {
        
        addSubviews(titleLabel, BenefitsCollectionView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(29)
            $0.leading.equalToSuperview().offset(16)
        }
        
        BenefitsCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.bottom.equalToSuperview().offset(0)
        }
        
        BenefitsCollectionView.delegate = self
        BenefitsCollectionView.dataSource = self
        BenefitsCollectionView.register(BenefitsCollectionViewCell.self, forCellWithReuseIdentifier: "BenefitsCollectionViewCell")
    }
    
}

extension BenefitsTableViewCell: UICollectionViewDelegate {
    
}


extension BenefitsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BenefitsCollectionViewCell", for: indexPath) as? BenefitsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setData(productImage: imageList[indexPath.row], title: "아티제 최대 15% 할인", subTitle: "쿠키부터 롤케이크까지")
        
        return cell
    }
    

}

extension BenefitsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width
        let cellWidth = width * (375/375)
        let height = cellWidth * (94/375)
        
        return CGSize(width: cellWidth, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
