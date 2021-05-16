//
//  ProductCollectionViewCell.swift
//  marketkurly_clone
//
//  Created by 윤예지 on 2021/05/14.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productSalePercentLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    func setData(productImage: String,
                 productName: String,
                 productSalePercent: String,
                 productPrice: String) {
        if let image = UIImage(named: productImage) {
                    productImageView.image = image
        }
        
        self.productNameLabel.text = productName
        self.productSalePercentLabel.text = productName
        self.productSalePercentLabel.text = productSalePercent
        self.productPriceLabel.text = productPrice
    }
}
