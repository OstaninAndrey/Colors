//
//  HomeViewController.swift
//  Colors!
//
//  Created by Андрей Останин on 06.09.2020.
//  Copyright © 2020 Андрей Останин. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    var scoreList: [User]? = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.reuseCell)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        
        setupButtonsShape()
        nameTextField.delegate = self
        nameTextField.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        loadScoreRecords()
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Draw UI
    func setupButtonsShape() {
        startButton.layer.cornerRadius = K.Corner.defaultRadius
        nameTextField.layer.cornerRadius = K.Corner.defaultRadius
        nameTextField.clipsToBounds = true
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Set your name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        tableView.layer.cornerRadius = K.Corner.defaultRadius
    }
    
    func loadScoreRecords(){
        var array: [User] = []
        db.collection(K.FStore.userCollectionName).order(by: K.FStore.scoreField, descending: true).limit(to: 10).addSnapshotListener { (query, error) in
            if let e = error {
                print(e)
            } else {
                if let docs = query?.documents {
                    docs.forEach { (doc) in
                        let data = doc.data()
                        if let username = data[K.FStore.nameField] as? String,
                            let userScore = data[K.FStore.scoreField] as? Int {
                            let user = User(name: username, score: userScore)
                            print(user)
                            array.append(user)
                        }
                    }
                }
                self.scoreList = array
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - IBActions, segues and other
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

// MARK: - TextFieldDelegate
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

// MARK: - TableViewDelegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreList?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reuseCell, for: indexPath) as! RecordTableCell
        if let score = scoreList?[indexPath.row] {
            cell.nameLabel.text = score.name
            cell.placeLabel.text = "\(indexPath.row + 1)"
            cell.scoreLabel.text = "\(score.score)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
