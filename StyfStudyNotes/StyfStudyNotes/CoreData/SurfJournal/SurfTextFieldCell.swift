//
//  SurfTextFieldCell.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/22.
//

import UIKit

class SurfTextFieldCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
