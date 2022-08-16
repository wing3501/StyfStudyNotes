//
//  NoteTableViewCell.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/16.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteCreateDate: UILabel!
    
    var note: Note? {
        didSet {
            guard let note = note else { return }
            updateNoteInfo(note: note)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

@objc extension NoteTableViewCell {
    func updateNoteInfo(note: Note) {
        noteTitle.text = note.title
        noteCreateDate.text = note.dateCreated.description
    }
}

