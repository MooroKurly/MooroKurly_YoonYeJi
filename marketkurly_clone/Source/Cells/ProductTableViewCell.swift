//
//  ProductTableViewCell.swift
//  marketkurly_clone
//
//  Created by 윤예지 on 2021/05/14.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    var productDummyData : [ProductModelData] = []
    
    @IBOutlet weak var ProductCollectionView: UICollectionView! {
        didSet{
            ProductCollectionView.delegate = self
            ProductCollectionView.dataSource = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setDummyData() {
        productDummyData = [
            ProductModelData(productImage: "productImage1", productName: "[우리밀] 백밀가루 & 옛밀가루", productSalePercent: "15%", productPrice: "19000원"),
            ProductModelData(productImage: "productImage2", productName: "[홍대쭈꾸미] 쭈꾸미볶음 300g", productSalePercent: "15%", productPrice: "5300원"),
            ProductModelData(productImage: "productImage2", productName: "[기와] LA갈비 800g", productSalePercent: "15%", productPrice: "19000원"),
        ]
    }
}



// MARK: -
extension ProductTableViewCell: UICollectionViewDelegate {
    
}

extension ProductTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        setDummyData()
        return productDummyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else {
                  return UICollectionViewCell()
              }

        cell.setData(productImage: productDummyData[indexPath.row].productImage, productName: productDummyData[indexPath.row].productName, productSalePercent: productDummyData[indexPath.row].productSalePercent, productPrice: productDummyData[indexPath.row].productPrice)
        
        return cell
    }
    
    
}

extension ProductTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = UIScreen.main.bounds.width
        let cellWidth = width * (150/375)
        let height = cellWidth * (266/150)
        
//        print(cellWidth, height)
        
        return CGSize(width: cellWidth, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
