//
//  GameManager.swift
//  Colors!
//
//  Created by Андрей Останин on 06.09.2020.
//  Copyright © 2020 Андрей Останин. All rights reserved.
//

import Foundation
import UIKit

class GameManager {
    var currentLevel = 1
    
    var numberOfCells: Int {
        switch currentLevel {
        case 1...8:
            return 2 + currentLevel
        case 9:
            return 15
        default:
            return 0
        }
    }
    
    func getArray() -> [ColoredTableViewCell] {
        var array: [ColoredTableViewCell] = []
        
        for _ in 0...numberOfCells - 1 {
            array.append(ColoredTableViewCell())
        }
        
        return array
    }
    
    func correctAnswer(for array: [ColoredTableViewCell]) -> Bool{
        
        return true
    }
    
    
    
}
