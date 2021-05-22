//
//  PersonTableViewCell.swift
//  Contactos
//
//  Created by Mac2 on 20/05/21.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var imgVie: UIImageView!
    @IBOutlet weak var TelefonoL: UILabel!
    @IBOutlet weak var Nombre: UILabel!
    @IBOutlet weak var CorreoL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
