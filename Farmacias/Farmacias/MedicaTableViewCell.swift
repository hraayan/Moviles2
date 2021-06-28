//
//  MedicaTableViewCell.swift
//  Farmacias
//
//  Created by Mac2 on 26/06/21.
//

import UIKit

class MedicaTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var LabTxt: UILabel!
    @IBOutlet weak var actTxt: UILabel!
    @IBOutlet weak var nombreTxt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.img.layer.cornerRadius = self.img.frame.size.height / 2
        self.img.layer.borderWidth = 2.0
        
        self.img.layer.borderColor = UIColor .darkGray.cgColor
        self.img.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
