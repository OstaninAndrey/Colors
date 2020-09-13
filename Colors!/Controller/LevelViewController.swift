//
//  LevelViewController.swift
//  Colors!
//
//  Created by Андрей Останин on 06.09.2020.
//  Copyright © 2020 Андрей Останин. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class LevelViewController: ViewController {
    
    @IBOutlet weak var nextLevelButton: UIButton!
    @IBOutlet weak var checkButtonOutlet: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    
    var colorsArray: [UIView] = []
    var gameManager = GameManager()
    
    var isDragging = false
    var draggingView: UIView = .init()
    var offset: CGPoint = .init()
    var originalIndex: Int?

    // MARK: - VC Lifecycle
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setTitleColor()
        setupButtonsShape()
        colorsArray = gameManager.generateArray()
        animate {
            self.drawGameScreen()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Draw UI
    func setTitleColor() {
        let font = UIFont.boldSystemFont(ofSize: 26)
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black
        shadow.shadowBlurRadius = 1
        shadow.shadowOffset.height = 1
        shadow.shadowOffset.width = 1
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: font,
            .shadow: shadow
        ]
        
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        title = "Level \(gameManager.levelName)!"
    }
    
    func setupButtonsShape() {
        nextLevelButton.layer.cornerRadius = K.Corner.defaultRadius
        checkButtonOutlet.layer.cornerRadius = K.Corner.defaultRadius
        backgroundView.layer.cornerRadius = K.Corner.defaultRadius
    }
    
    func drawGameScreen() {
        let heightOfView = gameManager.getSubviewHeight(for: backgroundView)
        
        for i in 0..<colorsArray.count {
            backgroundView.addSubview(colorsArray[i])
            
            colorsArray[i].translatesAutoresizingMaskIntoConstraints = false
            colorsArray[i].leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: K.Constraints.leftSpace).isActive = true
            colorsArray[i].trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: K.Constraints.rightSpace).isActive = true
            colorsArray[i].heightAnchor.constraint(equalToConstant: heightOfView).isActive = true
            if i != 0 {
                colorsArray[i].topAnchor.constraint(equalTo: colorsArray[i-1].bottomAnchor, constant: K.Constraints.spaceBetweenViews).isActive = true
            } else {
                colorsArray[i].topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: K.Constraints.spaceBetweenViews).isActive = true
            }
            
            colorsArray[i].layer.cornerRadius = K.Corner.defaultRadius
        }
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
    
    func clearGameScreen() {
        colorsArray.forEach { (color) in
            color.removeFromSuperview()
        }
    }
    
    func animate(_ closure: @escaping () -> Void) {
        UIView.animate(withDuration: CATransaction.animationDuration(), delay: 0, options: [.curveEaseOut], animations: {
            closure()
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    // MARK: - IBActions
    @IBAction func checkButtonAction(_ sender: UIButton) {
        
    }
    
    @IBAction func nextLevelButtonAction(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "LevelVC") as? LevelViewController {
            vc.gameManager = self.gameManager
            vc.gameManager.currentLevel += 1
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func exitPressedAction(_ sender: UIBarButtonItem) {
        let warning = UIAlertController(title: "Quit",
                                    message: "Are you sure want to quit the game?",
                                    preferredStyle: .alert)
        warning.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        warning.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            self.animate {
                self.navigationController?.popToRootViewController(animated: false)
            }
        }))
        
        present(warning, animated: true)
    }
    
    // MARK: - Touches and user interaction
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)                              //for keyboard hiding
        
        guard let touch = touches.first else {
            return
        }
        
        if let touchedView = findTouchedView(for: touch) {
            isDragging = true
            draggingView = touchedView
            backgroundView.bringSubviewToFront(draggingView)
        }
        print("TOUCH STARTED")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDragging, let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: view)
        draggingView.frame.origin.x = location.x - offset.x
        draggingView.frame.origin.y = location.y - offset.y
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let newIndex = findMaxIntersectionIndex(), let oldIndex = originalIndex{
            clearGameScreen()
            colorsArray.remove(at: oldIndex)
            colorsArray.insert(self.draggingView, at: newIndex)
            self.animate {
                self.drawGameScreen()
            }
        }
        
        isDragging = false
    }
    
    // MARK: - Drag additional methods
    func findTouchedView(for touch: UITouch) -> UIView? {
        var touchedView: UIView?
        for i in 0..<colorsArray.count {
            let location = touch.location(in: colorsArray[i])
            if colorsArray[i].bounds.contains(location) {
                touchedView = colorsArray[i]
                offset.x = location.x - colorsArray[i].bounds.origin.x + K.Constraints.leftSpace
                offset.y = location.y - colorsArray[i].bounds.origin.y + K.Constraints.spaceBetweenViews
                originalIndex = i
                
            }
        }
        return touchedView
    }
    
    func findMaxIntersectionIndex() -> Int? {
        var maxIntersectionSquare: CGFloat = 0
        var intersectionIndex: Int?
        
        for i in 0..<colorsArray.count {
            let intersection = colorsArray[i].frame.intersection(draggingView.frame)
            if (intersection.width * intersection.height > maxIntersectionSquare) && !colorsArray[i].isEqual(draggingView) {
                maxIntersectionSquare = intersection.width * intersection.height
                intersectionIndex = i
            }
        }
        
        return intersectionIndex
    }
    
}
