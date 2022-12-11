/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class NotesListViewController: UITableViewController {
  
  enum Segue {
    static let noteSelected =  "CellSelected"
    static let newNote =  "AddNewNote"
  }
  
  // some default notes to play with
  var notes = [
    Note(text: "Shopping List\r\r1. Cheese\r2. Biscuits\r3. Sausages\r4. IMPORTANT Cash for going out!\r5. -potatoes-\r6. A copy of iOS8 by Tutorials\r7. A new iPhone\r8. A present for mum"),
    Note(text: "Meeting notes\rA long and drawn out meeting, it lasted hours and hours and hours!"),
    Note(text: "Perfection ... \n\nPerfection is achieved not when there is nothing left to add, but when there is nothing left to take away - Antoine de Saint-Exupery"),
    Note(text: "Notes on Swift\nThis new language from Apple is changing iOS development as we know it!"),
    Note(text: "Meeting notes\rA different meeting, just as long and boring"),
    Note(text: "A collection of thoughts\rWhy do birds sing? Why is the sky blue? Why is it so hard to create good test data?")
  ]
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    // whenever this view controller appears, reload the table. This allows it to reflect any changes
    // made whilst editing notes
    tableView.reloadData()
    navigationController?.navigationBar.barStyle = .black
  }
  
  //MARK: -  Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return notes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
    let note = notes[indexPath.row]
    
    let font = UIFont.preferredFont(forTextStyle: .headline)
    let textColor = UIColor(red: 0.175, green: 0.458, blue: 0.831, alpha: 1)
    let attributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: textColor, .font: font,
      .textEffect: NSAttributedString.TextEffectStyle.letterpressStyle]
    let attributedString = NSAttributedString(string: note.title, attributes: attributes)
    cell.textLabel?.attributedText = attributedString
    return cell
  }
  
  override func viewDidLoad() {
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 44.0
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
    guard let editorVC = segue.destination as? NoteEditorViewController else {
      return
    }
    
    if Segue.noteSelected == segue.identifier {
      if let path = tableView.indexPathForSelectedRow {
        editorVC.note = notes[path.row]
      }
    } else if Segue.newNote == segue.identifier {
      editorVC.note = Note(text: " ")
      notes.append(editorVC.note)
    }
  }
}
