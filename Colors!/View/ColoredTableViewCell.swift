//
//  ColoredTableViewCell.swift
//  Colors!
//
//  Created by Андрей Останин on 06.09.2020.
//  Copyright © 2020 Андрей Останин. All rights reserved.
//

import UIKit
import Foundation

class ColoredTableViewCell: UITableViewCell {

    @IBOutlet weak var coloredView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupShape()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupShape() {
        layer.cornerRadius = K.Corner.cellRadius
        coloredView.layer.cornerRadius = K.Corner.cellRadius
        coloredView.backgroundColor = .getRandom()
    }
    
}
