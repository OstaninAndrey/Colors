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
import TableViewDragger

class LevelViewController: ViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextLevelButton: UIButton!
    @IBOutlet weak var checkButtonOutlet: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    
    var colorsArray: [ColoredTableViewCell] = []
    let gameManager = GameManager()
//    var dragger: TableViewDragger!
//    var statusBarHidden: Bool = false {
//        didSet {
//            setNeedsStatusBarAppearanceUpdate()
//        }
//    }
//
//    override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
//        return .slide
//    }
//
//    override var prefersStatusBarHidden : Bool {
//        return statusBarHidden
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonsShape()
        navigationItem.hidesBackButton = true
        
        colorsArray = gameManager.getArray()
        
//        dragger = TableViewDragger(tableView: tableView)
//        dragger.dataSource = self
//        dragger.delegate = self
//        dragger.tableView?.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
//        dragger.tableView?.separatorStyle = .singleLine
//        dragger.tableView?.isScrollEnabled = true
//        dragger.availableHorizontalScroll = true
//        dragger.alphaForCell = 0.7
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
    }
    
    func setupButtonsShape() {
        nextLevelButton.layer.cornerRadius = K.Corner.cellRadius
        checkButtonOutlet.layer.cornerRadius = K.Corner.cellRadius
        backgroundView.layer.cornerRadius = K.Corner.cellRadius
    }
    
    @IBAction func checkButtonAction(_ sender: UIButton) {
        
    }
    
    @IBAction func nextLevelButtonAction(_ sender: UIButton) {
        
    }
    
    @IBAction func exitPressedAction(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: false)
    }
    
    
}

extension LevelViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        colorsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        if let demoCell = cell as? ColoredTableViewCell {
            demoCell.coloredView = colorsArray[indexPath.row].coloredView
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(0.97 * backgroundView.bounds.height) / CGFloat(colorsArray.count)
    }
    
}

//extension LevelViewController: TableViewDraggerDataSource, TableViewDraggerDelegate{
//
//    func dragger(_ dragger: TableViewDragger, moveDraggingAt indexPath: IndexPath, newIndexPath: IndexPath) -> Bool {
//        let color = colorsArray[indexPath.row]
//        colorsArray.remove(at: indexPath.row)
//        colorsArray.insert(color, at: newIndexPath.row)
//
//        tableView.moveRow(at: indexPath, to: newIndexPath)
//
//
//        return true
//    }
//
//    func dragger(_ dragger: TableViewDragger, willBeginDraggingAt indexPath: IndexPath) {
//        if let tableView = dragger.tableView {
//            let scale = min(max(tableView.bounds.height / tableView.contentSize.height, 0.4), 1)
//            dragger.scrollVelocity = scale
//
//
//            UIView.animate(withDuration: 0.3) {
//                self.navigationController?.setNavigationBarHidden(true, animated: true)
//
//                if let tabBarHeight = self.tabBarController?.tabBar.bounds.height {
//                    self.tabBarController?.tabBar.frame.origin.y += tabBarHeight
//                }
//
//                //self.tableViewHeightConstraint.constant = (tableView.bounds.height) / scale - tableView.bounds.height
//                tableView.transform = CGAffineTransform(scaleX: scale, y: scale)
//                self.view.layoutIfNeeded()
//            }
//        }
//    }
//
//    func dragger(_ dragger: TableViewDragger, willEndDraggingAt indexPath: IndexPath) {
//
//        UIView.animate(withDuration: 0.3) {
//            self.statusBarHidden = false
//            self.navigationController?.setNavigationBarHidden(false, animated: false)
//            
//            if let tabBarHeight = self.tabBarController?.tabBar.bounds.height {
//                self.tabBarController?.tabBar.frame.origin.y -= tabBarHeight
//            }
//
//            //self.tableViewHeightConstraint.constant = 0
//            if let tableView = dragger.tableView {
//                tableView.transform = CGAffineTransform.identity
//                self.view.layoutIfNeeded()
//                tableView.scrollToRow(at: indexPath, at: .top, animated: false)
//            }
//        }
//    }
//}
