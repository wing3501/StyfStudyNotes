//
//  二叉树.swift
//  StyfStudyNotes
//
//  Created by styf on 2021/2/26.
//

import Foundation

public class TreeNode {
     public var val: Int
     public var left: TreeNode?
     public var right: TreeNode?
     public init(_ val: Int) {
         self.val = val
         self.left = nil
         self.right = nil
     }
}

@objcMembers class TreeTest: NSObject {
    class func test() {
        let node = deserialize("[1,2,3,null,null,4,5,null,null,null,null]")
        let str = serialize(node)
        print(str)
    }
    
    class func serialize(_ root: TreeNode?) -> String {
        if root == nil {
            return ""
        }
        var queue: [TreeNode?] = [root]
        var result = "["
        while queue.count > 0 {
            let node = queue.remove(at: 0)
            if node == nil {
                result.append("null,")
                continue
            }
            result.append("\(node!.val),")
            queue.append(node?.left)
            queue.append(node?.right)
        }
        result.removeLast()
        result += "]"
        return result
    }
        
    class func deserialize(_ data: String) -> TreeNode? {
        var string = data
        if string.count > 0 {
            string.removeFirst()
            string.removeLast()
        }
        if string.count > 0 {
            let array = string.split(separator: ",")
            let root = TreeNode(Int(array[0])!)
            var parentArray: [TreeNode?] = [root]
            var i = 1
            while i < array.count {
                let parent = parentArray.remove(at: 0)
                let leftStr = array[i]
                i += 1
                if leftStr != "null" {
                    let leftNode = TreeNode(Int(leftStr)!)
                    parent?.left = leftNode
                    parentArray.append(leftNode)
                }
                
                if i < array.count {
                    let rightStr = array[i]
                    i += 1
                    if rightStr != "null" {
                        let rightNode = TreeNode(Int(rightStr)!)
                        parent?.right = rightNode
                        parentArray.append(rightNode)
                    }
                }
            }
            return root
        }
        return nil
    }
}
