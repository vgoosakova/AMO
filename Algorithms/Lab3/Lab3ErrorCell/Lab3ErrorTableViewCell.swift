//
//  Lab3ErrorTableViewCell.swift
//  Algorithms
//
//  Created by Денис Данилюк on 15.04.2020.
//  Copyright © 2020 Viktory. All rights reserved.
//

import UIKit

class Lab3ErrorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nLabel: UILabel!
    
    @IBOutlet weak var deltaNLabel: UILabel!
    
    @IBOutlet weak var deltaExactNLabel: UILabel!
    
    @IBOutlet weak var kLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
