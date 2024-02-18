//
//  ToDoCell.swift
//  ToDoApp
//
//  Created by Samet Alkan on 17.02.2024.
//

import UIKit

class ToDoCell: UITableViewCell {

    
    
    @IBOutlet weak var labelCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        labelCell.layer.cornerRadius = 10
        labelCell.clipsToBounds = true

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
