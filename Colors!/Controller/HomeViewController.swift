//
//  HomeViewController.swift
//  Colors!
//
//  Created by Андрей Останин on 06.09.2020.
//  Copyright © 2020 Андрей Останин. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class HomeViewController: ViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonsShape()
        nameTextField.delegate = self
        nameTextField.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupButtonsShape() {
        startButton.layer.cornerRadius = K.Corner.defaultRadius
        nameTextField.layer.cornerRadius = K.Corner.defaultRadius
        nameTextField.clipsToBounds = true
    }
    
    @IBAction func startGameButtonAction(_ sender: UIButton) {
        if nameTextField.text != "" {
            performSegue(withIdentifier: K.gameScreenSegueID, sender: self)
        }
        else {
            nameTextField.placeholder = "Type a nickname"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? LevelViewController {
            destinationVC.gameManager.userName = nameTextField.text!
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)                              //for keyboard hiding
    }
    
}

extension HomeViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 9
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.endEditing(true)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if nameTextField.text == "" {
            nameTextField.placeholder = "Type a nickname"
            return false
        } else {
            return true
        }
    }
}
