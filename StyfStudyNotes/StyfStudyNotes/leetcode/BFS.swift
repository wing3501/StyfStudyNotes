//
//  BFS.swift
//  StyfStudyNotes
//
//  Created by styf on 2021/2/9.
//

import Foundation

//// 计算从起点 start 到终点 target 的最近距离
//int BFS(Node start, Node target) {
//    Queue<Node> q; // 核心数据结构
//    Set<Node> visited; // 避免走回头路
//
//    q.offer(start); // 将起点加入队列
//    visited.add(start);
//    int step = 0; // 记录扩散的步数
//
//    while (q not empty) {
//        int sz = q.size();
//        /* 将当前队列中的所有节点向四周扩散 */
//        for (int i = 0; i < sz; i++) {
//            Node cur = q.poll();
//            /* 划重点：这里判断是否到达终点 */
//            if (cur is target)
//                return step;
//            /* 将 cur 的相邻节点加入队列 */
//            for (Node x : cur.adj())
//                if (x not in visited) {
//                    q.offer(x);
//                    visited.add(x);
//                }
//        }
//        /* 划重点：更新步数在这里 */
//        step++;
//    }
//}

@objcMembers class BFS: NSObject {
    class func test()  {
//        111. 二叉树的最小深度
//        let node = TreeTest.deserialize("[3,9,20,null,null,15,7]")
//        print(minDepth(node))
//        let node1 = TreeTest.deserialize("[2,null,3,null,4,null,5,null,6]")
//        print(minDepth(node1))
        
//        752. 打开转盘锁
//        print(openLock(["0201","0101","0102","1212","2002"], "0202"))//6
//        print(openLock(["8888"], "0009"))//1
//        print(openLock(["8887","8889","8878","8898","8788","8988","7888","9888"], "8888"))//-1
//        print(openLock(["0000"], "8888"))//-1
    }
    
    
//    752. 打开转盘锁
//    你有一个带有四个圆形拨轮的转盘锁。每个拨轮都有10个数字： '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' 。每个拨轮可以自由旋转：例如把 '9' 变为 '0'，'0' 变为 '9' 。每次旋转都只能旋转一个拨轮的一位数字。
//    锁的初始数字为 '0000' ，一个代表四个拨轮的数字的字符串。
//    列表 deadends 包含了一组死亡数字，一旦拨轮的数字和列表里的任何一个元素相同，这个锁将会被永久锁定，无法再被旋转。
//    字符串 target 代表可以解锁的数字，你需要给出解锁需要的最小旋转次数，如果无论如何不能解锁，返回 -1 。
//    示例 1:
//    输入：deadends = ["0201","0101","0102","1212","2002"], target = "0202"
//    输出：6
//    解释：
//    可能的移动序列为 "0000" -> "1000" -> "1100" -> "1200" -> "1201" -> "1202" -> "0202"。
//    注意 "0000" -> "0001" -> "0002" -> "0102" -> "0202" 这样的序列是不能解锁的，
//    因为当拨动到 "0102" 时这个锁就会被锁定。
//    示例 2:
//    输入: deadends = ["8888"], target = "0009"
//    输出：1
//    解释：
//    把最后一位反向旋转一次即可 "0000" -> "0009"。
//    示例 3:
//    输入: deadends = ["8887","8889","8878","8898","8788","8988","7888","9888"], target = "8888"
//    输出：-1
//    解释：
//    无法旋转到目标数字且不被锁定。
//    示例 4:
//    输入: deadends = ["0000"], target = "8888"
//    输出：-1
    class func openLock(_ deadends: [String], _ target: String) -> Int {
        //可以用双向BFS还提高效率
        
        let deadSet = Set<[Int]>(deadends.map { (str) -> [Int] in
            str.map { (ch) -> Int in
                ch.wholeNumberValue!
            }
        })
        let lock = [0,0,0,0]
        var visitedSet = Set<[Int]>([lock])
        let targetArray = target.map { (ch) -> Int in
            ch.wholeNumberValue!
        }
        var quque = [lock]
        var step = 0;
        while quque.count > 0 {
            var i = 0
            let len = quque.count
            while i < len {
                let cur = quque.remove(at: 0)
                if cur == targetArray {
                    return step
                }
                if !deadSet.contains(cur) {
                    var j = 0
                    while j < lock.count {
                        let newlock1 = walkLock(cur, j, true)
                        let newlock2 = walkLock(cur, j, false)
                        if newlock1 == targetArray || newlock2 == targetArray {
                            return step + 1
                        }
                        if !visitedSet.contains(newlock1) && !deadSet.contains(newlock1) {
                            quque.append(newlock1)
                            visitedSet.insert(newlock1)
                        }
                        if !visitedSet.contains(newlock2) && !deadSet.contains(newlock2) {
                            quque.append(newlock2)
                            visitedSet.insert(newlock2)
                        }
                        j += 1
                    }
                }
                i += 1
            }
            step += 1
        }
        return -1
    }
    
    class func walkLock(_ lock: [Int],_ index: Int,_ up: Bool) -> [Int] {
        let value = lock[index] + (up ? 1 : -1)
        var newLock = lock
        if value > 9 {
            newLock[index] = 0
        }else if value < 0 {
            newLock[index] = 9
        }else {
            newLock[index] = value
        }
        return newLock
    }
    
//    111. 二叉树的最小深度
//    给定一个二叉树，找出其最小深度。
//    最小深度是从根节点到最近叶子节点的最短路径上的节点数量。
//    说明：叶子节点是指没有子节点的节点。
//    示例 1：
//    输入：root = [3,9,20,null,null,15,7]
//    输出：2
//    示例 2：
//    输入：root = [2,null,3,null,4,null,5,null,6]
//    输出：5
    class func minDepth(_ root: TreeNode?) -> Int {
        guard let node = root else { return 0 }
        var quque = [node]
        var deep = 1
        while quque.count > 0 {
            let len = quque.count
            var i = 0
            while i < len {
                let cur = quque.remove(at: 0)
                if cur.left == nil && cur.right == nil {
                    return deep
                }
                if let left = cur.left {
                    quque.append(left)
                }
                if let right = cur.right {
                    quque.append(right)
                }
                i += 1
            }
            deep += 1
        }
        return deep
    }
}
