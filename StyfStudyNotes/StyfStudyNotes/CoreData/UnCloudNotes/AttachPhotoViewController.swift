//
//  AttachPhotoViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/17.
//

import UIKit

class AttachPhotoViewController: UIViewController {

    // MARK: - Properties
    var note : Note?
    lazy var imagePicker : UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.addChild(picker)
        return picker
    }()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(imagePicker)
        view.addSubview(imagePicker.view)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        imagePicker.view.frame = view.bounds
    }
}

// MARK: - UIImagePickerControllerDelegate
extension AttachPhotoViewController: UIImagePickerControllerDelegate {

  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
      guard let note = note,
            let context = note.managedObjectContext else { return }

//      note.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
      
      // 升级为一对多
//      let attachment = Attachment(context: context)
      // 升级为子类
      let attachment = ImageAttachment(context: context)
      attachment.caption = "New Photo"
      attachment.dateCreated = Date()
      attachment.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
      attachment.note = note

      _ = navigationController?.popViewController(animated: true)
  }
}

// MARK: - UINavigationControllerDelegate
extension AttachPhotoViewController: UINavigationControllerDelegate {
}

// MARK: - NoteDisplayable
//extension AttachPhotoViewController: NoteDisplayable {
//}
