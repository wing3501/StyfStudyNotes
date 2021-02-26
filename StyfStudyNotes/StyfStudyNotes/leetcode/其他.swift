//
//  其他.swift
//  StyfStudyNotes
//
//  Created by styf on 2021/2/26.
//

import Foundation

@objcMembers class Other : NSObject {
    class func test() {
        
//        146. LRU 缓存机制
//        let lRUCache = LRUCache(2)
//        lRUCache.put(1, 1); // 缓存是 {1=1}
//        lRUCache.put(2, 2); // 缓存是 {1=1, 2=2}
//        print(lRUCache.get(1))   // 返回 1
//        lRUCache.put(3, 3); // 该操作会使得关键字 2 作废，缓存是 {1=1, 3=3}
//        print(lRUCache.get(2))    // 返回 -1 (未找到)
//        lRUCache.put(4, 4); // 该操作会使得关键字 1 作废，缓存是 {4=4, 3=3}
//        print(lRUCache.get(1))    // 返回 -1 (未找到)
//        print(lRUCache.get(3))    // 返回 3
//        print(lRUCache.get(4))    // 返回 4
        
//        let lRUCache = LRUCache(2)
//        print(lRUCache.get(2))//-1
//        lRUCache.put(2, 6) //[2,6]
//        print(lRUCache.get(1))//-1
//        lRUCache.put(1, 5)
//        lRUCache.put(1, 2)//[1,2]
//        print(lRUCache.get(1))//2
//        print(lRUCache.get(2))//6
////        ["LRUCache","get","put","get","put","put","get","get"]
////        [null,-1,null,-1,null,null,2,6]
        
//        testCache(["put","put","put","put","put","get","put","get","get","put","get","put","put","put","get","put","get","get","get","get","put","put","get","get","get","put","put","get","put","get","put","get","get","get","put","put","put","get","put","get","get","put","put","get","put","put","put","put","get","put","put","get","put","put","get","put","put","put","put","put","get","put","put","get","put","get","get","get","put","get","get","put","put","put","put","get","put","put","put","put","get","get","get","put","put","put","get","put","put","put","get","put","put","put","get","get","get","put","put","put","put","get","put","put","put","put","put","put","put"], [[10,13],[3,17],[6,11],[10,5],[9,10],[13],[2,19],[2],[3],[5,25],[8],[9,22],[5,5],[1,30],[11],[9,12],[7],[5],[8],[9],[4,30],[9,3],[9],[10],[10],[6,14],[3,1],[3],[10,11],[8],[2,14],[1],[5],[4],[11,4],[12,24],[5,18],[13],[7,23],[8],[12],[3,27],[2,12],[5],[2,9],[13,4],[8,18],[1,7],[6],[9,29],[8,21],[5],[6,30],[1,12],[10],[4,15],[7,22],[11,26],[8,17],[9,29],[5],[3,4],[11,30],[12],[4,29],[3],[9],[6],[3,4],[1],[10],[3,29],[10,28],[1,20],[11,13],[3],[3,12],[3,8],[10,9],[3,26],[8],[7],[5],[13,17],[2,27],[11,15],[12],[9,19],[2,15],[3,16],[1],[12,17],[9,1],[6,19],[4],[5],[5],[8,1],[11,7],[5,2],[9,28],[1],[2,2],[7,4],[4,22],[7,24],[9,26],[13,28],[11,26]])

        
    }
    
    
    class func testCache(_ array: [String],_ array1: [[Int]]) {
        let lRUCache = LRUCache(10)
        var i = 0
        while i < array.count {
            let str = array[i]
            let tuple = array1[i]
            
            if str == "put" {
                print("操作---\(i + 1) put[\(tuple[0]),\(tuple[1])]")
                lRUCache.put(tuple[0], tuple[1])
            }else {
                print("操作---\(i + 1) get[\(tuple[0])]")
                _ = lRUCache.get(tuple[0])
            }
            i += 1
        }
    }
    
//    146. LRU 缓存机制
//    运用你所掌握的数据结构，设计和实现一个  LRU (最近最少使用) 缓存机制 。
//    实现 LRUCache 类：
//    LRUCache(int capacity) 以正整数作为容量 capacity 初始化 LRU 缓存
//    int get(int key) 如果关键字 key 存在于缓存中，则返回关键字的值，否则返回 -1 。
//    void put(int key, int value) 如果关键字已经存在，则变更其数据值；如果关键字不存在，则插入该组「关键字-值」。当缓存容量达到上限时，它应该在写入新数据之前删除最久未使用的数据值，从而为新的数据值留出空间。
//    进阶：你是否可以在 O(1) 时间复杂度内完成这两种操作？
//    示例：
//    输入
//    ["LRUCache", "put", "put", "get", "put", "get", "put", "get", "get", "get"]
//    [[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]
//    输出
//    [null, null, null, 1, null, -1, null, -1, 3, 4]
//
//    解释
//    LRUCache lRUCache = new LRUCache(2);
//    lRUCache.put(1, 1); // 缓存是 {1=1}
//    lRUCache.put(2, 2); // 缓存是 {1=1, 2=2}
//    lRUCache.get(1);    // 返回 1
//    lRUCache.put(3, 3); // 该操作会使得关键字 2 作废，缓存是 {1=1, 3=3}
//    lRUCache.get(2);    // 返回 -1 (未找到)
//    lRUCache.put(4, 4); // 该操作会使得关键字 1 作废，缓存是 {4=4, 3=3}
//    lRUCache.get(1);    // 返回 -1 (未找到)
//    lRUCache.get(3);    // 返回 3
//    lRUCache.get(4);    // 返回 4
//    提示：
//    1 <= capacity <= 3000
//    0 <= key <= 3000
//    0 <= value <= 104
//    最多调用 3 * 104 次 get 和 put
//    链接：https://leetcode-cn.com/problems/lru-cache
    class LRUCache {
        class LRUNode {
            var key: Int
            var val: Int
            var next: LRUNode?
            var prev: LRUNode?
            init(_ key: Int, _ value: Int) {
                self.key = key
                self.val = value
            }
        }
        class LRULinkedHashMap {
            var hashmap: Dictionary<Int, LRUNode> = [:]
            var head: LRUNode?
            var tail: LRUNode?
            var size: Int = 0
            
            func get(_ key: Int) -> Int {
                if let node = hashmap[key] {
                    return node.val
                }
                return -1
            }
            
            func add(_ key: Int, _ value: Int) {
                if let node = hashmap[key] {
                    //已经存在，更新
                    node.val = value
                    bringToTail(node)
                }else {
                    let node = LRUNode(key, value)
                    if tail == nil {
                        head = node
                        tail = node
                    }else {
                        bringToTail(node)
                    }
                    hashmap[key] = node
                    size += 1
                }
            }
            
            func bringToTail(_ key: Int) {
                if let node = hashmap[key] {
                    bringToTail(node)
                }
            }
            
            func bringToTail(_ node: LRUNode) {
                if node.key != tail?.key {
                    if node.key == head?.key {
                        node.next?.prev = nil
                        head = node.next
                    }
                    node.prev?.next = node.next
                    node.next?.prev = node.prev
                    tail?.next = node
                    node.prev = tail
                    node.next = nil
                    tail = node
                }
            }
            
            func deleteHeadIfNeeded(_ key: Int) {
                guard hashmap[key] == nil else {
                    return
                }
                if let node = head {
                    delete(node.key)
                }
            }
            
            func delete(_ key: Int) {
                if let node = hashmap[key] {
                    if node.key == head?.key {
                        head = node.next
                        if node.key == tail?.key {
                            tail = node.prev
                        }
                    }else {
                        if node.key == tail?.key {
                            tail = node.prev
                        }else {
                            node.prev?.next = node.next
                        }
                    }
                    hashmap.removeValue(forKey: key)
                    size -= 1
                }
            }
            func printNode() {
                var node = head
                var str = ""
                while node != nil {
                    str += "[\(node!.key),\(node!.val)]"
                    node = node?.next
                }
                print(str)
            }
        }
        
        var capacity: Int
        var linkedHashMap: LRULinkedHashMap = LRULinkedHashMap()

        init(_ capacity: Int) {
            self.capacity = capacity
        }
        
        func get(_ key: Int) -> Int {
            let val = linkedHashMap.get(key)
            linkedHashMap.bringToTail(key)
//            linkedHashMap.printNode()
            return val
        }
        
        func put(_ key: Int, _ value: Int) {
            if linkedHashMap.size == capacity {
                //删除最老的
                linkedHashMap.deleteHeadIfNeeded(key)
            }
            linkedHashMap.add(key, value)
//            linkedHashMap.printNode()
        }
    }
}
