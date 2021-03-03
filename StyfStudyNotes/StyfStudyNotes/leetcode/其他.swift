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

        //    460. LFU 缓存
        //    ["LFUCache", "put", "put", "get", "put", "get", "get", "put", "get", "get", "get"]
        //    [[2], [1, 1], [2, 2], [1], [3, 3], [2], [3], [4, 4], [1], [3], [4]]
        //    输出：
        //    [null, null, null, 1, null, -1, 3, null, -1, 3, 4]
//        testLFU(["put", "put", "get", "put", "get", "get", "put", "get", "get", "get"], [ [1, 1], [2, 2], [1], [3, 3], [2], [3], [4, 4], [1], [3], [4]])
        
        testLFU(["put","get"], [[0,0],[0]])
        
    }
    
    class func testLFU(_ array: [String],_ array1: [[Int]]) {
        let lFUCache = LFUCache(0)
        var i = 0
        var result = ""
        while i < array.count {
            let str = array[i]
            let tuple = array1[i]
            
            if str == "put" {
                print("操作---\(i + 1) put[\(tuple[0]),\(tuple[1])]")
                lFUCache.put(tuple[0], tuple[1])
                result.append("null,")
            }else {
                print("操作---\(i + 1) get[\(tuple[0])]")
                result.append("\(lFUCache.get(tuple[0])),")
            }
            i += 1
        }
        print("结果：" + result)
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
//    460. LFU 缓存
//    请你为 最不经常使用（LFU）缓存算法设计并实现数据结构。
//    实现 LFUCache 类：
//    LFUCache(int capacity) - 用数据结构的容量 capacity 初始化对象
//    int get(int key) - 如果键存在于缓存中，则获取键的值，否则返回 -1。
//    void put(int key, int value) - 如果键已存在，则变更其值；如果键不存在，请插入键值对。当缓存达到其容量时，则应该在插入新项之前，使最不经常使用的项无效。在此问题中，当存在平局（即两个或更多个键具有相同使用频率）时，应该去除 最久未使用 的键。
//    注意「项的使用次数」就是自插入该项以来对其调用 get 和 put 函数的次数之和。使用次数会在对应项被移除后置为 0 。
//    为了确定最不常使用的键，可以为缓存中的每个键维护一个 使用计数器 。使用计数最小的键是最久未使用的键。
//    当一个键首次插入到缓存中时，它的使用计数器被设置为 1 (由于 put 操作)。对缓存中的键执行 get 或 put 操作，使用计数器的值将会递增。
//    示例：
//    输入：
//    ["LFUCache", "put", "put", "get", "put", "get", "get", "put", "get", "get", "get"]
//    [[2], [1, 1], [2, 2], [1], [3, 3], [2], [3], [4, 4], [1], [3], [4]]
//    输出：
//    [null, null, null, 1, null, -1, 3, null, -1, 3, 4]
//    解释：
//    // cnt(x) = 键 x 的使用计数
//    // cache=[] 将显示最后一次使用的顺序（最左边的元素是最近的）
//    LFUCache lFUCache = new LFUCache(2);
//    lFUCache.put(1, 1);   // cache=[1,_], cnt(1)=1
//    lFUCache.put(2, 2);   // cache=[2,1], cnt(2)=1, cnt(1)=1
//    lFUCache.get(1);      // 返回 1
//                          // cache=[1,2], cnt(2)=1, cnt(1)=2
//    lFUCache.put(3, 3);   // 去除键 2 ，因为 cnt(2)=1 ，使用计数最小
//                          // cache=[3,1], cnt(3)=1, cnt(1)=2
//    lFUCache.get(2);      // 返回 -1（未找到）
//    lFUCache.get(3);      // 返回 3
//                          // cache=[3,1], cnt(3)=2, cnt(1)=2
//    lFUCache.put(4, 4);   // 去除键 1 ，1 和 3 的 cnt 相同，但 1 最久未使用
//                          // cache=[4,3], cnt(4)=1, cnt(3)=2
//    lFUCache.get(1);      // 返回 -1（未找到）
//    lFUCache.get(3);      // 返回 3
//                          // cache=[3,4], cnt(4)=1, cnt(3)=3
//    lFUCache.get(4);      // 返回 4
//                          // cache=[3,4], cnt(4)=2, cnt(3)=3
//    提示：
//    0 <= capacity, key, value <= 104
//    最多调用 105 次 get 和 put 方法
//    进阶：你可以为这两种操作设计时间复杂度为 O(1) 的实现吗？
//    链接：https://leetcode-cn.com/problems/lfu-cache
    class LFUCache {
        class LFUNode {
            var key: Int
            var val: Int
            var prev: LFUNode?
            var next: LFUNode?
            init(_ key: Int, _ value: Int) {
                self.key = key
                self.val = value
            }
        }
        
        class LFULinkedHashMap {
            var hashmap: [Int: LFUNode] = [:]
            var head: LFUNode?
            var tail: LFUNode?
            var size = 0
            
            func put(key: Int,value: Int) {
                if let node = hashmap[key] {
                    node.val = value
                }else {
                    let node = LFUNode(key, value)
                    if size == 0 {
                        head = node
                        tail = node
                    }else {
                        tail?.next = node
                        node.prev = tail
                        tail = node
                    }
                    hashmap[key] = node
                    size += 1
                }
            }
            
            func remove(key: Int) {
                if let node = hashmap[key] {
                    if size == 1 {
                        head = nil
                        tail = nil
                    }else if node.key == head?.key {
                        head = node.next
                        head?.prev = nil
                    }else if node.key == tail?.key {
                        tail = node.prev
                        tail?.next = nil
                    }else {
                        node.prev?.next = node.next
                        node.next?.prev = node.prev
                    }
                    hashmap.removeValue(forKey: key)
                    size -= 1
                }
            }
        }
        var KeyToValue: [Int: Int] = [:]
        var KeyToCount: [Int: Int] = [:]
        var CountToKey: [Int: LFULinkedHashMap] = [:]
        var minCount = 0
        var capacity: Int

        init(_ capacity: Int) {
            self.capacity = capacity
        }
        
        func get(_ key: Int) -> Int {
            if let val = KeyToValue[key] {
                increaseCount(key)//更新节点的次数
                return val
            }
            return -1
        }
        
        func put(_ key: Int, _ value: Int) {
            guard capacity > 0 else {
                return
            }
            if let count = KeyToCount[key] {
                //已经存在，更新节点的值
                KeyToValue[key] = value
                let linkedHashMap = CountToKey[count]
                linkedHashMap?.put(key: key, value: value)
                increaseCount(key)//更新节点的次数
                return
            }
            //不存在
            //已经满了
            if KeyToValue.count == capacity {
                //删除不常使用的节点
                removeMinKey()
            }
            KeyToValue[key] = value
            KeyToCount[key] = 1
            var linkedHashMap: LFULinkedHashMap?
            if CountToKey[1] == nil {
                linkedHashMap = LFULinkedHashMap()
            }else {
                linkedHashMap = CountToKey[1]
            }
            linkedHashMap?.put(key: key, value: value)
            CountToKey[1] = linkedHashMap
            minCount = 1
        }
        //增加一个节点的使用次数
        func increaseCount(_ key: Int) {
            let count = KeyToCount[key]!//原来的次数
            let value = KeyToValue[key]!
            KeyToCount[key] = count + 1
            //从原来的链表移除
            var linkedHashMap = CountToKey[count]
            linkedHashMap?.remove(key: key)
            if linkedHashMap?.size == 0 {
                CountToKey.removeValue(forKey: count)
                if self.minCount == count {
                    self.minCount += 1
                }
            }
            //加入新的链表
            linkedHashMap = CountToKey[count + 1]
            if linkedHashMap == nil {
                linkedHashMap = LFULinkedHashMap()
            }
            linkedHashMap?.put(key: key, value: value)
            CountToKey[count + 1] = linkedHashMap
        }
        //删除不常使用的节点
        func removeMinKey() {
            let linkedHashMap = CountToKey[self.minCount]!
            let key = linkedHashMap.head!.key
            linkedHashMap.remove(key: key)
            if linkedHashMap.size == 0 {
                CountToKey.removeValue(forKey: self.minCount)
            }
            KeyToCount.removeValue(forKey: key)
            KeyToValue.removeValue(forKey: key)
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
