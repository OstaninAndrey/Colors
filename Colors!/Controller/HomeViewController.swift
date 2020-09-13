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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)                              //for keyboard hiding
    }
    
}
