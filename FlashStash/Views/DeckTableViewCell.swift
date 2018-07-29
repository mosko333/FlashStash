//
//  DeckTableViewCell.swift
//  FlashStash
//
//  Created by Adam on 28/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class DeckTableViewCell: UITableViewCell {

    @IBOutlet weak var numberOfCardsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
