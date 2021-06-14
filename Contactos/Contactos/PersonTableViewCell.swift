//
//  PersonTableViewCell.swift
//  Contactos
//
//  Created by Mac2 on 20/05/21.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imgVie: UIImageView!
    @IBOutlet weak var TelefonoL: UILabel!
    @IBOutlet weak var Nombre: UILabel!
    @IBOutlet weak var CorreoL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView?.layer.cornerRadius = 5
        backView?.layer.masksToBounds = false
        backView?.layer.shadowColor = UIColor.black.cgColor
        backView?.layer.shadowOpacity = 0.5
        backView?.layer.shadowOffset = .zero
        backView?.layer.shadowRadius = 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
