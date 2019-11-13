//
//  SimplePopoverCell.swift
//  PublicServiceLeader
//
//  Created by Crep on 6/19/18.
//  Copyright © 2018 NhatCuong. All rights reserved.
//

import UIKit

class SimplePopoverCell: UITableViewCell {
    
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var buttonCheck: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setChosen(_ chosen: Bool) {
        self.buttonCheck.isSelected = chosen
    }
    
}
