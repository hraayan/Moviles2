//
//  ChatTableViewCell.swift
//  Login
//
//  Created by Mac2 on 12/06/21.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var imageContact: UIImageView!
    @IBOutlet weak var MensajeTxt: UITextField!
    @IBOutlet weak var DestinatLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageContact.layer.cornerRadius = imageContact.bounds.size.width / 1.2
        imageContact.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
