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
    var currentLevel: Int {
        didSet {
            if currentLevel > 9 { currentLevel = 9 }
        }
    }
    private(set) var levelPassed: Bool
    
    var levelName: String {
        return namesDict[currentLevel]!
    }
    
    private let namesDict = [ 1: "one", 2: "two", 3: "three",
                              4: "four", 5: "five", 6: "six",
                              7: "seven", 8: "eight", 9: "NINE!!"]
    
    var numberOfElems: Int {
        switch currentLevel {
        case 1...8:
            return 2 + currentLevel
        case 9:
            return 15
        default:
            return 0
        }
    }
    
    init() {
        currentLevel = 1
        levelPassed = false
    }
    
    func generateArray() -> [UIView] {
        var array: [UIView] = []
        
        for _ in 0...numberOfElems - 1 {
            let view = UIView()
            view.backgroundColor = .getRandom()
            array.append(view)
        }
        
        return array
    }
    
    func checkAnswer(for array: [UIView]) -> Bool{
        
        return true
    }
    
    func getSubviewHeight(for backgroundView: UIView) -> CGFloat {
        return (backgroundView.bounds.height - K.Constraints.spaceBetweenViews * CGFloat(numberOfElems + 1)) / CGFloat(numberOfElems)
    }
    
}
