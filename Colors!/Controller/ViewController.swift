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
    var draggingView: UIView = .init()
    
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
    
    func showAnswerImage(fileName: String) {
        print(fileName)
        let answerImage = UIImageView(image: UIImage.init(named: fileName))
        answerImage.center = self.view.center
        
        UIView.animate(withDuration: CATransaction.animationDuration()*2, delay: 0, options: [.curveEaseIn], animations: {
            self.view.addSubview(answerImage)
            answerImage.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            answerImage.alpha = 0
        }, completion: nil)
    }
    
    @objc func checkResultButton(sender: UIButton) {
        correctConditionForAnswerChoosing() ? showAnswerImage(fileName: "Correct.png") : showAnswerImage(fileName: "Incorrect.png")
    }
    
    // MARK: - Touches
    var canMove = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)                              //for keyboard hiding
        
        print("TOUCH STARTED")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
}
