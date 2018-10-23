//
//  CustomTableViewCell.swift
//  Swifty-Companion
//
//  Created by Goodwill TSHEKELA on 2018/10/23.
//  Copyright © 2018 Kuzivakwashe MUVEZWA. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell
{

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var value: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
