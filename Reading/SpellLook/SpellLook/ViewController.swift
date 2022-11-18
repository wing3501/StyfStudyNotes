/// Copyright (c) 2020 Razeware LLC
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
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import QuickLook

class ViewController: UICollectionViewController {
  let files = File.loadFiles()
    
  weak var tappedCell: FileCell?


  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    files.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: FileCell.reuseIdentifier,
      for: indexPath) as? FileCell
      else {
        return UICollectionViewCell()
    }
    cell.update(with: files[indexPath.row])
      
      
    return cell
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
      
      // 1
      let quickLookViewController = QLPreviewController()
      // 2 ✅ 数据源有多个文件时，左上角有列表按钮。切预览支持左右滑动切换
      quickLookViewController.dataSource = self
      tappedCell = collectionView.cellForItem(at: indexPath) as? FileCell
      quickLookViewController.delegate = self

      // 3
      quickLookViewController.currentPreviewItemIndex = indexPath.row
      // 4
      present(quickLookViewController, animated: true)

  }
}

// MARK: - QLPreviewControllerDataSource
extension ViewController: QLPreviewControllerDataSource {
  func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
    files.count
  }

  func previewController(
    _ controller: QLPreviewController,
    previewItemAt index: Int
  ) -> QLPreviewItem {
      // ✅ NSURL 已经实现了 QLPreviewItem，所以可以直接使用
//    files[index].url as NSURL
      
      files[index]
  }
}

// MARK: - QLPreviewControllerDelegate
extension ViewController: QLPreviewControllerDelegate {
  func previewController(
    _ controller: QLPreviewController,
    transitionViewFor item: QLPreviewItem
  ) -> UIView? {
      // ✅ 自动提供转场动画
    tappedCell?.thumbnailImageView
  }
    
    func previewController(
      _ controller: QLPreviewController,
      editingModeFor previewItem: QLPreviewItem
    ) -> QLPreviewItemEditingMode {
        // ✅ 对编辑的支持  .updateContent  .createCopy  .disabled
      .updateContents
    }
    func previewController(
      _ controller: QLPreviewController,
      didUpdateContentsOf previewItem: QLPreviewItem
    ) {
        // ✅ 编辑成功后，更新缩略图
      guard let file = previewItem as? File else { return }
      DispatchQueue.main.async {
        self.tappedCell?.update(with: file)
      }
    }
    // ✅ 创建拷贝的回调
//    previewController(_:didSaveEditedCopyOf:at:)
}
