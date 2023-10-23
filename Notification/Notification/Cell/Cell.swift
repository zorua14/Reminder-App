//
//  Cell.swift
//  Notification
//
//  Created by Karthikeyan Muthu on 23/10/23.
//

import UIKit

class Cell: UITableViewCell {

    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var task: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.systemIndigo.cgColor

        // Add corner radius to the view
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
