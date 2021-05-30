//
//  Extension+UIImage.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/05/28.
//

import Foundation
import UIKit

public extension UIImage {
    class var ic_home_selected  : UIImage{imageIcon(#function)}
    class var ic_recom_selected : UIImage{imageIcon(#function)}
    class var ic_category_selected  : UIImage{imageIcon(#function)}
    class var ic_search_selected : UIImage{imageIcon(#function)}
    class var ic_my_selected  : UIImage{imageIcon(#function)}

    private static func imageIcon(_ name : String) -> UIImage {
        guard let icon = UIImage(named: name) else { return UIImage() }
        return icon
    }
}
