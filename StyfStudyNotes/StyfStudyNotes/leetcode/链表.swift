//
//  链表.swift
//  StyfStudyNotes
//
//  Created by styf on 2021/8/27.
//

import Foundation

public class LinkedList<E: Comparable> {
    private class LinkedListNode {
        var val: E;
        var next: LinkedListNode?
        var prev: LinkedListNode?
        init(_ val: E) {
            self.val = val
        }
    }
    private var head: LinkedListNode?
    private var tail: LinkedListNode?
    public var count: Int = 0
    var top: E? {
        head?.val
    }
    var last: E? {
        tail?.val
    }
    
    func push(_ val: E) {
        let node = LinkedListNode(val)
        if let tailNode = tail {
            tailNode.next = node
            node.prev = tailNode
            tail = node
        }else {
            head = node
            tail = node
        }
        count += 1
    }
    
    func removeLast() -> E? {
        let val = tail?.val
        if count == 1 {
            head = nil
            tail = nil
            return val
        }else {
            let prev = tail?.prev
            tail?.prev?.next = nil
            tail?.prev = nil
            tail = prev
        }
        count -= 1
        return val
    }
    
    func removeTop() -> E? {
        let val = head?.val
        if count == 1 {
            head = nil
            tail = nil
        }else {
            let next = head?.next
            head?.next?.prev = nil
            head?.next = nil
            head = next
        }
        count -= 1
        return val
    }
}

@objcMembers class LinkListTest: NSObject {
    class func test() {
//        25. K 个一组翻转链表
//        printNode(reverseKGroup(createList([1,2,3,4,5]), 2))//[2,1,4,3,5]
//        printNode(reverseKGroup(createList([1,2,3,4,5]), 3))//[3,2,1,4,5]
//        printNode(reverseKGroup(createList([1,2,3,4,5]), 1))//[1,2,3,4,5]
//        printNode(reverseKGroup(createList([1]), 1))//[1]
//
//        剑指 Offer II 027. 回文链表
        print(isPalindrome(createList([1,2,3,3,2,1])))
        print(isPalindrome(createList([1,2])))
    }
    
    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init() { self.val = 0; self.next = nil; }
        public init(_ val: Int) { self.val = val; self.next = nil; }
        public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    }
    
    //    剑指 Offer II 027. 回文链表
    //    给定一个链表的 头节点 head ，请判断其是否为回文链表。
    //    如果一个链表是回文，那么链表节点序列从前往后看和从后往前看是相同的。
    //    示例 1：
    //    输入: head = [1,2,3,3,2,1]
    //    输出: true
    //    示例 2：
    //    输入: head = [1,2]
    //    输出: fasle
    //    提示：
    //    链表 L 的长度范围为 [1, 105]
    //    0 <= node.val <= 9
    //    进阶：能否用 O(n) 时间复杂度和 O(1) 空间复杂度解决此题？
    //    注意：本题与主站 234 题相同：https://leetcode-cn.com/problems/palindrome-linked-list/
    //    https://leetcode-cn.com/problems/aMhZSa/
    static var left: ListNode? = nil
    class func isPalindrome(_ head: ListNode?) -> Bool {
        left = head
        return isPalindromeHelper(head?.next)
    }
    class func isPalindromeHelper(_ rightNode: ListNode?) -> Bool {
        guard let right = rightNode else { return true }
        let res = isPalindromeHelper(right.next)
        
        if res && left?.val == right.val {
            left = left?.next
            return true
        }
        return false
    }
    
    
    class func printNode(_ head: ListNode?) {
        var node = head
        var array: [Int] = []
        while node != nil {
            array.append(node!.val)
            node = node?.next
        }
        print(array)
    }
    
    class func createList(_ array: [Int]) -> ListNode? {
        var head: ListNode? = nil
        var node: ListNode? = nil
        var i = 0
        while i < array.count {
            let val = array[i]
            if i == 0 {
                head = ListNode(val)
                node = head
            }else {
                node?.next = ListNode(val)
                node = node?.next
            }
            i += 1
        }
        return head
    }
    
    
//    25. K 个一组翻转链表
//    给你一个链表，每 k 个节点一组进行翻转，请你返回翻转后的链表。
//    k 是一个正整数，它的值小于或等于链表的长度。
//    如果节点总数不是 k 的整数倍，那么请将最后剩余的节点保持原有顺序。
//    进阶：
//    你可以设计一个只使用常数额外空间的算法来解决此问题吗？
//    你不能只是单纯的改变节点内部的值，而是需要实际进行节点交换。
//    示例 1：
//    输入：head = [1,2,3,4,5], k = 2
//    输出：[2,1,4,3,5]
//    示例 2：
//    输入：head = [1,2,3,4,5], k = 3
//    输出：[3,2,1,4,5]
//    示例 3：
//    输入：head = [1,2,3,4,5], k = 1
//    输出：[1,2,3,4,5]
//    示例 4：
//    输入：head = [1], k = 1
//    输出：[1]
//    提示：
//    列表中节点的数量在范围 sz 内
//    1 <= sz <= 5000
//    0 <= Node.val <= 1000
//    1 <= k <= sz
//    链接：https://leetcode-cn.com/problems/reverse-nodes-in-k-group
    class func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        if k == 1 || head == nil {
            return head
        }
        //先反转第一波，头节点变更
        var newHead: ListNode? = head
        if canReverse(head, k) {
            newHead = reverseN(head, k)
            var tail = head
            var nextReverseHead = tail?.next
            while canReverse(nextReverseHead, k) {
                tail?.next = reverseN(nextReverseHead, k)
                tail = nextReverseHead
                nextReverseHead = nextReverseHead?.next
            }
        }
        return newHead
    }
    
    class func canReverse(_ head: ListNode?,_ k: Int) -> Bool {
        var kk = k
        var node = head
        while node != nil {
            node =  node?.next
            kk -= 1
            if kk == 0 {
                return true
            }
        }
        return false
    }
    
//    92. 反转链表 II
//    给你单链表的头指针 head 和两个整数 left 和 right ，其中 left <= right 。请你反转从位置 left 到位置 right 的链表节点，返回 反转后的链表 。
//    示例 1：
//    输入：head = [1,2,3,4,5], left = 2, right = 4
//    输出：[1,4,3,2,5]
//    示例 2：
//    输入：head = [5], left = 1, right = 1
//    输出：[5]
//    提示：
//    链表中节点数目为 n
//    1 <= n <= 500
//    -500 <= Node.val <= 500
//    1 <= left <= right <= n
//    进阶： 你可以使用一趟扫描完成反转吗？
//    https://leetcode-cn.com/problems/reverse-linked-list-ii/submissions/
    class func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
        guard let headNode = head else { return nil }
        if left == 1 {
            return reverseN(headNode, right)
        }
        headNode.next = reverseBetween(head?.next, left - 1, right - 1)
        return headNode
    }
    //反转以head开头的n个节点，并返回反转后的头节点
    static var lastNextNode :ListNode? = nil
    class func reverseN(_ head: ListNode?,_ n:Int) -> ListNode? {
        guard let headNode = head else { return nil }
        if n == 1 {
            lastNextNode = headNode.next
            return headNode
        }
        let last = reverseN(headNode.next, n - 1)
        headNode.next?.next = headNode
        headNode.next = lastNextNode
        return last
    }
}
