//
//  NoteImageTableViewCell.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/16.
//

import UIKit

class NoteImageTableViewCell: NoteTableViewCell {

    @IBOutlet weak var noteImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension NoteImageTableViewCell {
    override func updateNoteInfo(note: Note) {
        super.updateNoteInfo(note: note)
    }
}
