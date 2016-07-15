//
//  BookTableViewCell.swift
//  HackerBooks
//
//  Created by CLAG on 1/7/16.
//  Copyright © 2016 Clag. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
          
    }
    
}
