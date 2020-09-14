//
//  UIButtonExtension.swift
//  Colors!
//
//  Created by Андрей Останин on 14.09.2020.
//  Copyright © 2020 Андрей Останин. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func shake() {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
