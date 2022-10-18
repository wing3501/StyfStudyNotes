//
//  MoveCollectionViewCell.swift
//  SwiftApp
//
//  Created by styf on 2022/10/18.
//

import UIKit

class MyMoveCell: UICollectionViewCell {
    
    lazy var label: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.center = CGPoint(x: frame.width * 0.5, y: frame.height * 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MoveCollectionViewCell: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var dataArray = [8,3,10,7,2,1,9,6,4,5]
    
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 50)
        var view = UICollectionView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 100), collectionViewLayout: layout)
        view.backgroundColor = .yellow
        view.delegate = self
        view.dataSource = self
        view.register(MyMoveCell.self, forCellWithReuseIdentifier: "MyMoveCell")
        view.clipsToBounds = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        
        collectionView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handlelongGesture(_:))))
    }
    
    @objc func handlelongGesture(_ longPress: UILongPressGestureRecognizer) {
        
        switch longPress.state {
        case .began: //手势开始
            //判断手势落点位置是否在row上
            if let indexPath = collectionView.indexPathForItem(at: longPress.location(in: collectionView))
                {
                collectionView.beginInteractiveMovementForItem(at: indexPath)
            }
        case .changed:
            //移动过程中随时更新cell位置
            collectionView.updateInteractiveMovementTargetPosition(longPress.location(in: collectionView))
            
        case .ended:
            //移动结束后关闭cell移动
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyMoveCell", for: indexPath)
        cell.backgroundColor = .red
        if let cell = cell as? MyMoveCell {
            cell.label.text = "\(dataArray[indexPath.row])"
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        true
    }

    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("移动到-----\(destinationIndexPath.row)")
        dataArray.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
}
