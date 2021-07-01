//
//  ProveTableViewCell.swift
//  Farmacias
//
//  Created by Mac2 on 25/06/21.
//

import UIKit

class ProveTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var proveidoTxt: UILabel!
    @IBOutlet weak var telTxt: UILabel!
    @IBOutlet weak var correoTxt: UILabel!
    @IBOutlet weak var nombreTxt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
