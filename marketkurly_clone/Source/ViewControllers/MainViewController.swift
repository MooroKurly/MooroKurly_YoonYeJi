//
//  MainViewController.swift
//  marketkurly_clone
//
//  Created by 윤예지 on 2021/05/11.
//

import UIKit

class MainViewController : UIViewController
{
    @IBOutlet weak var MainTableView: UITableView! {
        didSet {
            MainTableView.delegate = self
            MainTableView.dataSource = self
           
        }
    }
    
    @IBOutlet weak var CustomTabCollectionView: UICollectionView! {
        didSet {
            CustomTabCollectionView.delegate = self
            CustomTabCollectionView.dataSource = self
        }
    }
    
    
    var tabList = ["컬리추천", "신상품", "베스트", "알뜰쇼핑", "특가/혜택"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}


// MARK:- 커스텀 탭바를 위한 컬렉션 뷰
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomTabCollectionViewCell", for: indexPath) as? CustomTabCollectionViewCell else {
                return UICollectionViewCell()
            }
            
        cell.setData(title: tabList[indexPath.row])
            
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    
}


extension MainViewController : UICollectionViewDelegateFlowLayout {
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

// MARK:- 메인뷰 구성을 위한 테이블뷰
extension MainViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            let width = UIScreen.main.bounds.width
            let cellWidth = UIScreen.main.bounds.width * (375/375)
            let height = width * (345/cellWidth)
            
            return height
        case 1:
            let cellWidth = UIScreen.main.bounds.width * (375/375)
            let height = cellWidth * (333/cellWidth)
            
            print(height)
            return height
        default:
            return 340
        }
    
    }
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let bannerCell = tableView.dequeueReusableCell(withIdentifier: "BannerTableViewCell", for: indexPath)
                    as? BannerTableViewCell else { return UITableViewCell() }
            return bannerCell
        case 1:
            guard let productCell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath)
                    as? ProductTableViewCell else { return UITableViewCell() }
            return productCell
        default:
            return UITableViewCell()
        }
    }
    
    
}
