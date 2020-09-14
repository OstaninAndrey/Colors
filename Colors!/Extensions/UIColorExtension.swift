//
//  UIColorExtension.swift
//  Colors!
//
//  Created by Андрей Останин on 07.09.2020.
//  Copyright © 2020 Андрей Останин. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    var hue: CGFloat {
        var hue: CGFloat = .init()
        var saturation: CGFloat = .init()
        var brightness: CGFloat = .init()
        var alpha: CGFloat = .init()

        self.getHue(&hue,
                    saturation: &saturation,
                    brightness: &brightness,
                    alpha: &alpha)

        return hue
    }

    static func getRandom() -> UIColor{
        let r = CGFloat.random(in: 0.4...1)
        let g = CGFloat.random(in: 0.4...1)
        let b = CGFloat.random(in: 0.4...1)
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }

}
