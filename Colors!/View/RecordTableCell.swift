//
//  RecordTableCell.swift
//  Colors!
//
//  Created by Андрей Останин on 15.09.2020.
//  Copyright © 2020 Андрей Останин. All rights reserved.
//

import UIKit

class RecordTableCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
