//
//  GameManager.swift
//  Colors!
//
//  Created by Андрей Останин on 06.09.2020.
//  Copyright © 2020 Андрей Останин. All rights reserved.
//

import Foundation
import UIKit

protocol GameDelegate {
    func didTriesCountBecameZero()
    func gameWillFinish()
}

class GameManager{
    var currentLevel: Int {
        didSet {
            if currentLevel > 9 { currentLevel = 9 }
        }
    }
    private(set) var levelPassed: Bool
    private(set) var triesLeft = 20
    
    var levelName: String {
        return namesDict[currentLevel]!
    }
    
    private let namesDict = [ 1: "one", 2: "two", 3: "three",
                              4: "four", 5: "five", 6: "six",
                              7: "seven", 8: "eight", 9: "NINE!!"]
    
    private(set) var userScore = 0
    var userName = ""
    
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
    
    var delegate: GameDelegate?
    
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
    
    func checkAnswer(for array: [UIView]){
        // check by hue, change levelPassed prop
        var counterUp = 1, counterDown = 1
        for i in 1..<array.count {
            if let first = array[i-1].backgroundColor?.hue, let second = array[i].backgroundColor?.hue {
                if first > second {
                    counterUp += 1
                }
                else {
                    counterDown += 1
                }
            }
        }
        
        if counterUp == array.count || counterDown == array.count {
            levelPassed = true
            userScore += numberOfElems * triesLeft * currentLevel
            if currentLevel == 9 {
                delegate?.gameWillFinish()
            }
        }
        else {
            levelPassed = false
            triesLeft -= 1
        }
        if triesLeft == 0 { delegate?.didTriesCountBecameZero() }
    }
    
    func getSubviewHeight(for backgroundView: UIView) -> CGFloat {
        return (backgroundView.bounds.height - K.Constraints.spaceBetweenViews * CGFloat(numberOfElems + 1)) / CGFloat(numberOfElems)
    }
    
}
