//
//  Extension+UIView.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/05/28.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews (_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
