//
//  User.swift
//  Colors!
//
//  Created by Андрей Останин on 05.09.2020.
//  Copyright © 2020 Андрей Останин. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var name = ""
    @objc dynamic var score = 0
    
}
