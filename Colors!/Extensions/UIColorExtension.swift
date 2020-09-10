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

    static func getRandom(r: CGFloat = CGFloat.random(in: 0...1), g: CGFloat = CGFloat.random(in: 0...1),
                          b: CGFloat = CGFloat.random(in: 0...1), alpha: CGFloat = 1) -> UIColor{
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }

}
