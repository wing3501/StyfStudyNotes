//
//  CreateNoteViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/16.
//

import UIKit
import CoreData

class CreateNoteViewController: UIViewController,UsesCoreDataObjects {

    var managedObjectContext: NSManagedObjectContext?
    lazy var note: Note? = {
        guard let context = self.managedObjectContext else { return nil }
        return Note(context: context)
    }()
    
    var finishBlock: (() -> Void)?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var bodyField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "create", style: .plain, target: self, action: #selector(saveNote(_:)))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleField.becomeFirstResponder()
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
    }
}
