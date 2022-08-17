//
//  CreateImageNoteViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/17.
//

import UIKit
import CoreData

class CreateImageNoteViewController: UIViewController,UsesCoreDataObjects {

    var managedObjectContext: NSManagedObjectContext?
    lazy var note: Note? = {
        guard let context = self.managedObjectContext else { return nil }
        return Note(context: context)
    }()
    
    var finishBlock: (() -> Void)?
    
    @IBOutlet weak var attachedPhoto: UIImageView!
    @IBOutlet weak var attachPhotoButton: UIButton!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var bodyField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "create", style: .plain, target: self, action: #selector(saveNote(_:)))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let image = note?.image else {
            titleField.becomeFirstResponder()
            return
        }
        
        attachedPhoto.image = image
        view.endEditing(true)
    }
    
    @IBAction func attachPhoto(_ sender: UIButton) {
        let vc = AttachPhotoViewController()
        vc.note = note
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc public func saveNote(_ sender: UIBarButtonItem) {
        guard let note = note,
              let managedObjectContext = managedObjectContext else {
                return
        }
        note.title = titleField.text ?? ""
        note.body = bodyField.text ?? ""
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Error saving \(error)", terminator: "")
        }
        
        if let finishBlock {
            finishBlock()
        }
        
        navigationController?.popViewController(animated: true)
    }
}
