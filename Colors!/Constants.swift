//
//  Constants.swift
//  Colors!
//
//  Created by Андрей Останин on 05.09.2020.
//  Copyright © 2020 Андрей Останин. All rights reserved.
//
import UIKit

struct K {

    static let reuseCell = "RecordTableCell"
    static let cellNibName = "RecordTableCell"
    
    struct Corner {
        static let defaultRadius = CGFloat(20)
        static let smallRadius = CGFloat(10)
    }
    
    struct Constraints {
        static let spaceBetweenViews: CGFloat = 10
        static let leftSpace: CGFloat = 20
        static let rightSpace: CGFloat = -20
        static let answerImgDimension: CGFloat = 100
    }
    
    static let gameScreenSegueID = "GameScreenSegue"
    
    struct FStore {
        static let userCollectionName = "user"
        static let nameField = "name"
        static let scoreField = "score"
    }
}
