//
//  BannerTableViewCell.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/05/28.
//

import UIKit
import SnapKit

class BannerTableViewCell: UITableViewCell {
        
    var handler: ((Result<[AdDataModel], Error>) -> Void)!
    
    var bannerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.isScrollEnabled = true
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .white
        $0.contentInset = UIEdgeInsets.zero
        $0.collectionViewLayout = layout
    }
    
    var indicatorBox = UIView().then {
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        $0.layer.cornerRadius = 8
    }
    
    var indicatorPage = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 12)
    }

    var bannerList: [AdDataModel] = []
    
    func setUI(){
        addSubviews(bannerCollectionView, indicatorBox)
        indicatorBox.addSubview(indicatorPage)
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCollectionViewCell")
        
        bannerCollectionView.snp.makeConstraints {
            let width = UIScreen.main.bounds.width
            let cellWidth = UIScreen.main.bounds.width * (375/375)
            let height = width * (345/cellWidth)
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(height)
        }
        
        bannerCollectionView.scrollToItem(at: IndexPath(item: 500, section: 0), at: .right, animated: false)
        
        indicatorBox.snp.makeConstraints {
            $0.trailing.equalTo(bannerCollectionView.snp.trailing).offset(-10)
            $0.bottom.equalTo(bannerCollectionView.snp.bottom).offset(-10)
            $0.height.equalTo(20)
            $0.width.equalTo(40)
        }
        
        indicatorPage.snp.makeConstraints {
            indicatorPage.text = "1 / \(bannerList.count)"
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func serverConneted() {
        handler = { result in
            switch result {
            case .success(let ad):
                self.bannerList = ad
                self.indicatorPage.text = "1 / \(self.bannerList.count)"
                self.bannerCollectionView.reloadData()
            case .failure(let err):
                print(err)
            }
        }
        RecommandService.shared.getAdBanner(completion: handler)
    }
}

extension BannerTableViewCell: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        var page = Int(targetContentOffset.pointee.x / self.frame.width)
        if page >= bannerList.count {
            page = page % bannerList.count
        }
        self.indicatorPage.text = "\(page + 1) / \(bannerList.count)"
    }
}

extension BannerTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as? BannerCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setData(bannerImage: bannerList[indexPath.row % bannerList.count].img)
        
        return cell
    }
}

extension BannerTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = UIScreen.main.bounds.width
        let cellWidth = width * (375/375)
        let height = width * (345/375)
        
        return CGSize(width: cellWidth, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
