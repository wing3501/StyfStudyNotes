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
//        let node = deserialize("[1,2,3,null,null,4,5,null,null,null,null]")
//        let str = serialize(node)
//        print(str)
        
        //    114. 二叉树展开为链表
//        let node = deserialize("[1,2,5,3,4,null,6]")
//        flatten(node)
//        print("")
        
//        654. 最大二叉树
//        let node = constructMaximumBinaryTree([3,2,1,6,0,5])
//        let str = serialize(node)
//        print(str)
        
//        105. 从前序与中序遍历序列构造二叉树
//        let node = buildTree([3,9,20,15,7], [9,3,15,20,7])
//        let str = serialize(node)
//        print(str)
        
//        106. 从中序与后序遍历序列构造二叉树
//        let node = buildTree1([9,3,15,20,7], [9,15,7,20,3])
//        let str = serialize(node)
//        print(str)
        
//        652. 寻找重复的子树
//        let node = deserialize("[1,2,3,4,null,2,4,null,null,4,null,null,null]")
////        let node = deserialize("[0,0,0,0,null,null,0,null,null,null,0]")
//        let array = findDuplicateSubtrees(node)
//        for n in array {
//            let str = serialize(n)
//            print(str)
//        }
        
        //    230. 二叉搜索树中第K小的元素
//        let node = deserialize("[3,1,4,null,2]")
//        print(kthSmallest(node, 1))
        
        
//        450. 删除二叉搜索树中的节点
//        var node = deserialize("[5,3,6,2,4,null,7]")
        var node = deserialize("[3,1,4,null,2]")
        node = deleteNode(node, 1)
        print("")
        
    }
//    98. 验证二叉搜索树
//    给你一个二叉树的根节点 root ，判断其是否是一个有效的二叉搜索树。
//    有效 二叉搜索树定义如下：
//    节点的左子树只包含 小于 当前节点的数。
//    节点的右子树只包含 大于 当前节点的数。
//    所有左子树和右子树自身必须也是二叉搜索树。
//    示例 1：
//    输入：root = [2,1,3]
//    输出：true
//    示例 2：
//    输入：root = [5,1,4,null,null,3,6]
//    输出：false
//    解释：根节点的值是 5 ，但是右子节点的值是 4 。
//    提示：
//    树中节点数目范围在[1, 104] 内
//    -231 <= Node.val <= 231 - 1
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/validate-binary-search-tree
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
//            5
//           4  6
//         _ _  3 7
    class func isValidBST(_ root: TreeNode?) -> Bool {
        guard let node = root else { return true }
        let t = isValidBSTHelper(node)
        return t.0
    }
    
    class func isValidBSTHelper(_ root: TreeNode) -> (Bool,Int,Int) {
        var tuple = (true,root.val,root.val)
        if let left = root.left {
            let leftT = isValidBSTHelper(left)
            if !leftT.0 || root.val <= leftT.2 {
                return (false,0,0)
            }
            tuple.1 = leftT.1
        }
        if let right = root.right {
            let rightT = isValidBSTHelper(right)
            if !rightT.0 || root.val >= rightT.1 {
                return (false,0,0)
            }
            tuple.2 = rightT.2
        }
        return tuple
    }
    
//    700. 二叉搜索树中的搜索
//    给定二叉搜索树（BST）的根节点和一个值。 你需要在BST中找到节点值等于给定值的节点。 返回以该节点为根的子树。 如果节点不存在，则返回 NULL。
//
//    例如，
//
//    给定二叉搜索树:
//
//            4
//           / \
//          2   7
//         / \
//        1   3
//
//    和值: 2
//    你应该返回如下子树:
//
//          2
//         / \
//        1   3
//    在上述示例中，如果要找的值是 5，但因为没有节点值为 5，我们应该返回 NULL。
//
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/search-in-a-binary-search-tree
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        var node = root
        while node != nil {
            if node!.val == val {
                return node
            }else if node!.val > val {
                if let left = node?.left {
                    node = left
                }else {
                    break
                }
            }else {
                if let right = node?.right {
                    node = right
                }else {
                    break
                }
            }
        }
        return nil
    }
    
//    701. 二叉搜索树中的插入操作
//    给定二叉搜索树（BST）的根节点和要插入树中的值，将值插入二叉搜索树。 返回插入后二叉搜索树的根节点。 输入数据 保证 ，新值和原始二叉搜索树中的任意节点值都不同。
//
//    注意，可能存在多种有效的插入方式，只要树在插入后仍保持为二叉搜索树即可。 你可以返回 任意有效的结果 。
//    示例 1：
//    输入：root = [4,2,7,1,3], val = 5
//    输出：[4,2,7,1,3,5]
//    解释：另一个满足题目要求可以通过的树是：
//    示例 2：
//    输入：root = [40,20,60,10,30,50,70], val = 25
//    输出：[40,20,60,10,30,50,70,null,null,25]
//    示例 3：
//    输入：root = [4,2,7,1,3,null,null,null,null,null,null], val = 5
//    输出：[4,2,7,1,3,5]
//    提示：
//    给定的树上的节点数介于 0 和 10^4 之间
//    每个节点都有一个唯一整数值，取值范围从 0 到 10^8
//    -10^8 <= val <= 10^8
//    新值和原始二叉搜索树中的任意节点值都不同
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/insert-into-a-binary-search-tree
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        let node = TreeNode(val)
        
        if var cur = root {
            while true {
                if val > cur.val {
                    if let right = cur.right {
                        cur = right
                    }else {
                        cur.right = node
                        break
                    }
                }else {
                    if let left = cur.left {
                        cur = left
                    }else {
                        cur.left = node
                        break
                    }
                }
            }
        }else {
            return node
        }
        return root
    }
    
//    450. 删除二叉搜索树中的节点
//    给定一个二叉搜索树的根节点 root 和一个值 key，删除二叉搜索树中的 key 对应的节点，并保证二叉搜索树的性质不变。返回二叉搜索树（有可能被更新）的根节点的引用。
//
//    一般来说，删除节点可分为两个步骤：
//
//    首先找到需要删除的节点；
//    如果找到了，删除它。
//    说明： 要求算法时间复杂度为 O(h)，h 为树的高度。
//
//    示例:
//
//    root = [5,3,6,2,4,null,7]
//    key = 3
//
//        5
//       / \
//      3   6
//     / \   \
//    2   4   7
//
//    给定需要删除的节点值是 3，所以我们首先找到 3 这个节点，然后删除它。
//
//    一个正确的答案是 [5,4,6,2,null,null,7], 如下图所示。
//
//        5
//       / \
//      4   6
//     /     \
//    2       7
//
//    另一个正确答案是 [5,2,6,null,4,null,7]。
//
//        5
//       / \
//      2   6
//       \   \
//        4   7
//
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/delete-node-in-a-bst
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func deleteNode(_ root: TreeNode?, _ key: Int) -> TreeNode? {
        guard var node = root else { return nil }
        var parent: TreeNode? = nil
        var isLeftChild = false
        while node.val != key {
            parent = node
            if node.val > key {
                if let left = node.left {
                    node = left
                    isLeftChild = true
                }else {
                    return root
                }
            }else if node.val < key {
                if let right = node.right {
                    node = right
                    isLeftChild = false
                }else {
                    return root
                }
            }
        }
        //是否叶子节点
        if node.left == nil && node.right == nil {
            if let p = parent {
                if isLeftChild {
                    p.left = nil
                }else {
                    p.right = nil
                }
            }else {
                return nil
            }
        }else {
            //找前续
            var preNode: TreeNode? = nil
            if let left = node.left {
                preNode = left
                while preNode?.right != nil {
                    preNode = preNode?.right
                }
            }else if let right = node.right {
                preNode = right
                while preNode?.left != nil {
                    preNode = preNode?.left
                }
            }
            
            if preNode == nil {
                if parent != nil {
                    preNode = parent
                }
            }
            
            if let pre = preNode {
                let val = pre.val
                _ = deleteNode(root, val)
                node.val = val
            }
        }
        return root
    }
    
//    538. 把二叉搜索树转换为累加树
//    给出二叉 搜索 树的根节点，该树的节点值各不相同，请你将其转换为累加树（Greater Sum Tree），使每个节点 node 的新值等于原树中大于或等于 node.val 的值之和。
//    提醒一下，二叉搜索树满足下列约束条件：
//
//    节点的左子树仅包含键 小于 节点键的节点。
//    节点的右子树仅包含键 大于 节点键的节点。
//    左右子树也必须是二叉搜索树。
//    注意：本题和 1038: https://leetcode-cn.com/problems/binary-search-tree-to-greater-sum-tree/ 相同
//    示例 1：
//    输入：[4,1,6,0,2,5,7,null,null,null,3,null,null,null,8]
//    输出：[30,36,21,36,35,26,15,null,null,null,33,null,null,null,8]
//    示例 2：
//    输入：root = [0,null,1]
//    输出：[1,null,1]
//    示例 3：
//    输入：root = [1,0,2]
//    输出：[3,3,2]
//    示例 4：
//    输入：root = [3,2,4,1]
//    输出：[7,9,4,10]
//    提示：
//    树中的节点数介于 0 和 104 之间。
//    每个节点的值介于 -104 和 104 之间。
//    树中的所有值 互不相同 。
//    给定的树为二叉搜索树。
//    https://leetcode-cn.com/problems/convert-bst-to-greater-tree/
    class func convertBST(_ root: TreeNode?) -> TreeNode? {
        var sum = 0
        convertBSTHelper(root,&sum)
        return root
    }
    class func convertBSTHelper(_ node: TreeNode?, _ sum: inout Int) {
        guard let root = node else { return }
        
        if let right = root.right {
            convertBSTHelper(right,&sum)
        }
        sum += root.val
        root.val = sum
        if let left = root.left {
            convertBSTHelper(left, &sum)
        }
    }
    
//    230. 二叉搜索树中第K小的元素
//    给定一个二叉搜索树的根节点 root ，和一个整数 k ，请你设计一个算法查找其中第 k 个最小元素（从 1 开始计数）。
//    示例 1：
//    输入：root = [3,1,4,null,2], k = 1
//    输出：1
//    示例 2：
//    输入：root = [5,3,6,2,4,null,null,1], k = 3
//    输出：3
//    提示：
//    树中的节点数为 n 。
//    1 <= k <= n <= 104
//    0 <= Node.val <= 104
//    进阶：如果二叉搜索树经常被修改（插入/删除操作）并且你需要频繁地查找第 k 小的值，你将如何优化算法？
//    https://leetcode-cn.com/problems/kth-smallest-element-in-a-bst/
    class func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        var kk = k
        var res: Int?
        
        kthSmallestHelper(root, &kk, &res)
        
        return res!
    }
    class func kthSmallestHelper(_ root: TreeNode?, _ k: inout Int,_ res: inout Int?) {
        if let _ = res {
            return
        }
        if let left = root?.left {
            kthSmallestHelper(left, &k, &res)
        }
        if let _ = res {
            return
        }
        if k == 1 {
            res = root?.val
            return
        }
        k -= 1
        if let right = root?.right {
            kthSmallestHelper(right, &k, &res)
        }
    }
    
//    652. 寻找重复的子树
//    给定一棵二叉树，返回所有重复的子树。对于同一类的重复子树，你只需要返回其中任意一棵的根结点即可。
//    两棵树重复是指它们具有相同的结构以及相同的结点值。
//    示例 1：
//            1
//           / \
//          2   3
//         /   / \
//        4   2   4
//           /
//          4
//    下面是两个重复的子树：
//
//          2
//         /
//        4
//    和
//
//        4
//    因此，你需要以列表的形式返回上述重复子树的根结点。
//https://leetcode-cn.com/problems/find-duplicate-subtrees/
    class func findDuplicateSubtrees(_ root: TreeNode?) -> [TreeNode?] {
        guard let node = root else { return [] }
        var arraySet: Set<String> = []
        var resultSet: Set<String> = []
        var resultArray: [TreeNode?] = []
        _ = houxu(node, &arraySet,&resultSet, &resultArray)
        return resultArray
    }
    
    class func houxu(_ root: TreeNode?,_ arraySet: inout Set<String>,_ resultSet: inout Set<String>,_ resultArray: inout [TreeNode?]) -> String {
        var leftStr = "null"
        if let left = root?.left {
            leftStr = houxu(left, &arraySet,&resultSet, &resultArray)
        }
        var rightStr = "null"
        if let right = root?.right {
            rightStr = houxu(right, &arraySet,&resultSet, &resultArray)
        }
        var str = ""
        str += "\(leftStr)-"
        str += "\(rightStr)-"
        str += "\(root!.val)"
        if arraySet.contains(str) {
            if !resultSet.contains(str) {
                resultSet.insert(str)
                resultArray.append(root)
            }
        }else {
            arraySet.insert(str)
        }
        return str
    }
    
//    106. 从中序与后序遍历序列构造二叉树
//    根据一棵树的中序遍历与后序遍历构造二叉树。
//    注意:
//    你可以假设树中没有重复的元素。
//    例如，给出
//    中序遍历 inorder = [9,3,15,20,7]
//    后序遍历 postorder = [9,15,7,20,3]
//    返回如下的二叉树：
//        3
//       / \
//      9  20
//        /  \
//       15   7
//    https://leetcode-cn.com/problems/construct-binary-tree-from-inorder-and-postorder-traversal/
    class func buildTree1(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        var dic: [Int:Int] = [:]
        for (index,val) in inorder.enumerated() {
            dic[val] = index
        }
        var postorderIndex = postorder.count - 1
        return buildTree1Helper(inorder, postorder,0,inorder.count - 1, &postorderIndex,dic)
    }
    class func buildTree1Helper(_ inorder: [Int], _ postorder: [Int],_ start: Int,_ end: Int, _ postorderIndex: inout Int,_ inorderDic: [Int:Int]) -> TreeNode? {
        let val = postorder[postorderIndex]
        postorderIndex -= 1
        let root = TreeNode(val)
        let inorderIndex = inorderDic[val]!
        if inorderIndex != inorder.count - 1 && inorderIndex + 1 <= end {
            let right = buildTree1Helper(inorder, postorder,inorderIndex + 1,end, &postorderIndex, inorderDic)
            root.right = right
        }
        
        if inorderIndex != 0 && inorderIndex - 1 >= start {
            let left = buildTree1Helper(inorder, postorder,start,inorderIndex - 1, &postorderIndex, inorderDic)
            root.left = left
        }
        return root
    }
    
    
//    105. 从前序与中序遍历序列构造二叉树
//    给定一棵树的前序遍历 preorder 与中序遍历  inorder。请构造二叉树并返回其根节点。
//    示例 1:
//    Input: preorder = [3,9,20,15,7], inorder = [9,3,15,20,7]
//    Output: [3,9,20,null,null,15,7]
//    3
//   / \
//  9  20
//    /  \
//   15   7
//    示例 2:
//    Input: preorder = [-1], inorder = [-1]
//    Output: [-1]
//    提示:
//    1 <= preorder.length <= 3000
//    inorder.length == preorder.length
//    -3000 <= preorder[i], inorder[i] <= 3000
//    preorder 和 inorder 均无重复元素
//    inorder 均出现在 preorder
//    preorder 保证为二叉树的前序遍历序列
//    inorder 保证为二叉树的中序遍历序列
//    https://leetcode-cn.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/
    class func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        var pstart = 0
        return buildTreeHelper(preorder, inorder, &pstart, preorder.count - 1, 0, inorder.count - 1)
    }
    class func buildTreeHelper(_ preorder: [Int], _ inorder: [Int],_ pstart: inout Int,_ pend: Int,_ istart: Int,_ iend: Int) -> TreeNode? {
        let rootVal = preorder[pstart]
        let root = TreeNode(rootVal)
        var rootIndex = -1
        for (index,val) in inorder.enumerated() {
            if rootVal == val {
                rootIndex = index
                break
            }
        }
        pstart += 1
        if rootIndex > istart {
            root.left = buildTreeHelper(preorder, inorder, &pstart, pend, istart,  rootIndex - 1)
        }
        if rootIndex < iend {
            root.right = buildTreeHelper(preorder, inorder, &pstart, pend, rootIndex + 1,  iend)
        }
        return root
    }
    
//    654. 最大二叉树
//    给定一个不含重复元素的整数数组 nums 。一个以此数组直接递归构建的 最大二叉树 定义如下：
//    二叉树的根是数组 nums 中的最大元素。
//    左子树是通过数组中 最大值左边部分 递归构造出的最大二叉树。
//    右子树是通过数组中 最大值右边部分 递归构造出的最大二叉树。
//    返回有给定数组 nums 构建的 最大二叉树 。
//    示例 1：
//    输入：nums = [3,2,1,6,0,5]
//    输出：[6,3,5,null,2,0,null,null,1]
//    解释：递归调用如下所示：
//    - [3,2,1,6,0,5] 中的最大值是 6 ，左边部分是 [3,2,1] ，右边部分是 [0,5] 。
//        - [3,2,1] 中的最大值是 3 ，左边部分是 [] ，右边部分是 [2,1] 。
//            - 空数组，无子节点。
//            - [2,1] 中的最大值是 2 ，左边部分是 [] ，右边部分是 [1] 。
//                - 空数组，无子节点。
//                - 只有一个元素，所以子节点是一个值为 1 的节点。
//        - [0,5] 中的最大值是 5 ，左边部分是 [0] ，右边部分是 [] 。
//            - 只有一个元素，所以子节点是一个值为 0 的节点。
//            - 空数组，无子节点。
//    示例 2：
//    输入：nums = [3,2,1]
//    输出：[3,null,2,null,1]
//    提示：
//    1 <= nums.length <= 1000
//    0 <= nums[i] <= 1000
//    nums 中的所有整数 互不相同
//    https://leetcode-cn.com/problems/maximum-binary-tree/
    class func constructMaximumBinaryTree(_ nums: [Int]) -> TreeNode? {
        let sortArray = nums.enumerated().sorted { (e1, e2) -> Bool in
            return e2.element > e1.element
        }
        var array: [(Int,Int)] = []
        for (index,val) in sortArray {
            array.append((index,val))
        }
        
        return constructMaximumBinaryTreeHelper(0, nums.count - 1,array,nums.count - 1)
    }
    class func constructMaximumBinaryTreeHelper(_ start: Int,_ end: Int,_ array: [(Int,Int)],_ findIndex: Int) -> TreeNode? {
        var index = findIndex
        while index >= 0 {
            if array[index].0 >= start && array[index].0 <= end {
                break
            }
            index -= 1
        }
        if index >= 0 {
            let tuple = array[index]
            let root = TreeNode(tuple.1)
            if tuple.0 > start {
                root.left = constructMaximumBinaryTreeHelper(start, tuple.0 - 1, array, index - 1)
            }
            if tuple.0 < end {
                root.right = constructMaximumBinaryTreeHelper(tuple.0 + 1, end, array, index - 1)
            }
            return root
        }
        return nil
    }
    
//    114. 二叉树展开为链表
//    给你二叉树的根结点 root ，请你将它展开为一个单链表：
//    展开后的单链表应该同样使用 TreeNode ，其中 right 子指针指向链表中下一个结点，而左子指针始终为 null 。
//    展开后的单链表应该与二叉树 先序遍历 顺序相同。
//    示例 1：
//    输入：root = [1,2,5,3,4,null,6]
//    输出：[1,null,2,null,3,null,4,null,5,null,6]
//    示例 2：
//    输入：root = []
//    输出：[]
//    示例 3：
//    输入：root = [0]
//    输出：[0]
//    提示：
//    树中结点数在范围 [0, 2000] 内
//    -100 <= Node.val <= 100
//    进阶：你可以使用原地算法（O(1) 额外空间）展开这棵树吗？
//    https://leetcode-cn.com/problems/flatten-binary-tree-to-linked-list/
    class func flatten(_ root: TreeNode?) {
        _ = flatten1(root)
    }
    //展开一个节点，返回展开后的最后一个节点
    class func flatten1(_ root: TreeNode?) -> TreeNode? {
        guard let node = root else { return nil}
        let lastleft = flatten1(node.left)
        let lastright = flatten1(node.right)
        lastleft?.right = node.right
        let left = node.left
        node.left = nil
        node.right = left ?? node.right
        return (lastright ?? lastleft) ?? node
    }
//    116. 填充每个节点的下一个右侧节点指针
//    给定一个 完美二叉树 ，其所有叶子节点都在同一层，每个父节点都有两个子节点。二叉树定义如下：
//    struct Node {
//      int val;
//      Node *left;
//      Node *right;
//      Node *next;
//    }
//    填充它的每个 next 指针，让这个指针指向其下一个右侧节点。如果找不到下一个右侧节点，则将 next 指针设置为 NULL。
//    初始状态下，所有 next 指针都被设置为 NULL。
//    进阶：
//    你只能使用常量级额外空间。
//    使用递归解题也符合要求，本题中递归程序占用的栈空间不算做额外的空间复杂度。
//    示例：
//    输入：root = [1,2,3,4,5,6,7]
//    输出：[1,#,2,3,#,4,5,6,7,#]
//    解释：给定二叉树如图 A 所示，你的函数应该填充它的每个 next 指针，以指向其下一个右侧节点，如图 B 所示。序列化的输出按层序遍历排列，同一层节点由 next 指针连接，'#' 标志着每一层的结束。
//    https://leetcode-cn.com/problems/populating-next-right-pointers-in-each-node/
    public class Node {
         public var val: Int
         public var left: Node?
         public var right: Node?
         public var next:Node?
         public init(_ val: Int) {
             self.val = val
             self.left = nil
             self.right = nil
             self.next = nil
         }
    }
    class func connect(_ root: Node?) -> Node? {
        connec1(root, nil)
        return root
    }
    class func connec1(_ root: Node?,_ next: Node?) {
        guard let node = root else { return }
        node.left?.next = node.right
        node.right?.next = next?.left
        connec1(node.left, node.right)
        connec1(node.right, next?.left)
    }
//    226. 翻转二叉树
//    翻转一棵二叉树。
//    示例：
//    输入：
//         4
//       /   \
//      2     7
//     / \   / \
//    1   3 6   9
//    输出：
//         4
//       /   \
//      7     2
//     / \   / \
//    9   6 3   1
//    备注:
//    https://leetcode-cn.com/problems/invert-binary-tree/
    class func invertTree(_ root: TreeNode?) -> TreeNode? {
        guard let node = root else { return nil }
        let left = invertTree(node.left)
        let right = invertTree(node.right)
        node.left = right
        node.right = left
        return node
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
