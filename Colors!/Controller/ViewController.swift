//
//  ViewController.swift
//  Colors!
//
//  Created by Андрей Останин on 13.07.2020.
//  Copyright © 2020 Андрей Останин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    var inputTextField: UITextField = .init()
    var okButton: UIButton = .init()
    var numberOfElemsOnScreen = 0
    var numberOfColors = 0
    var checkButton: UIButton = .init()
    var headLabel: UILabel = .init()
    var colors: [UIView] = .init()
    var touchOffset: CGPoint = .init()
    //var draggingView: UIView = .init()
    
    // MARK: - Constants
    let numberOfElemsBeforeColors = 2
    let minNumberOfColors = 3
    let maxNumberOfColors = 15
    let cancelCondition = -1
    let interfaceElems = 3
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Initiating interface elements
    
    func showRangeErrorAlert() {
        let warning = UIAlertController(title: "Oops!",
                                    message: "You are only allowed to use numbers in range from 3 to 15",
                                    preferredStyle: .alert)
        warning.addAction(UIAlertAction(title: "Got it!", style: .default, handler: nil))
        present(warning, animated: true)
    }
    
    @objc func okButtonPress(sender: UIButton) {
        if let input = Int(inputTextField.text!) {
            if (input >= minNumberOfColors && input <= maxNumberOfColors) {
                //remove old
                inputTextField.removeFromSuperview()
                okButton.removeFromSuperview()
                numberOfColors = input
                numberOfElemsOnScreen = numberOfColors + interfaceElems
                //show new
                createRandomColors()
            }else{
                showRangeErrorAlert()
            }
        }else {
            showRangeErrorAlert()
        }
    }
    
    // MARK: - Initialize game screen

    func createRandomColors() {
        for _ in 1...numberOfColors{
            //colors.append(getRandomColorView())
        }
    }
    
    // MARK: - Showing answer
    func correctConditionForAnswerChoosing() -> Bool {
        let sortedUpColors = colors.sorted(by: { $0.backgroundColor!.hue < $1.backgroundColor!.hue})
        let sortedDownColors = colors.sorted(by: { $0.backgroundColor!.hue > $1.backgroundColor!.hue})
        
        if (colors == sortedUpColors ||
            colors == sortedDownColors) {
            return true
        }
        return false
    }
    
    
    @objc func checkResultButton(sender: UIButton) {
       // correctConditionForAnswerChoosing() ? showAnswerImage(fileName: "Correct.png") : showAnswerImage(fileName: "Incorrect.png")
    }
    
}
