//
//  JianZhiOffer.swift
//  StyfStudyNotes
//
//  Created by styf on 2021/2/9.
//

import Foundation

@objcMembers class JianZhiOffer: NSObject {
    class func test()  {
        //47. 礼物的最大价值
//        print(maxValue([[1,3,1],[1,5,1],[4,2,1]]))
//        48. 最长不含重复字符的子字符串
//        print(lengthOfLongestSubstring("abcabcbb"))//3
//        print(lengthOfLongestSubstring("bbbbb"))//1
//        print(lengthOfLongestSubstring("pwwkew"))//3
        //    49. 丑数
//        print(nthUglyNumber(10))
        
//        50. 第一个只出现一次的字符
//        print(firstUniqChar("z"))
//        51. 数组中的逆序对
//        print(reversePairs([7,5,6,4]))//5
//        print(reversePairs([233,2000000001,234,2000000006,235,2000000003,236,2000000007,237,2000000002,2000000005,233,233,233,233,233,2000000004]))//69
        
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
        
        
        
        
        testCache(["put","put","put","put","put","get","put","get","get","put","get","put","put","put","get","put","get","get","get","get","put","put","get","get","get","put","put","get","put","get","put","get","get","get","put","put","put","get","put","get","get","put","put","get","put","put","put","put","get","put","put","get","put","put","get","put","put","put","put","put","get","put","put","get","put","get","get","get","put","get","get","put","put","put","put","get","put","put","put","put","get","get","get","put","put","put","get","put","put","put","get","put","put","put","get","get","get","put","put","put","put","get","put","put","put","put","put","put","put"], [[10,13],[3,17],[6,11],[10,5],[9,10],[13],[2,19],[2],[3],[5,25],[8],[9,22],[5,5],[1,30],[11],[9,12],[7],[5],[8],[9],[4,30],[9,3],[9],[10],[10],[6,14],[3,1],[3],[10,11],[8],[2,14],[1],[5],[4],[11,4],[12,24],[5,18],[13],[7,23],[8],[12],[3,27],[2,12],[5],[2,9],[13,4],[8,18],[1,7],[6],[9,29],[8,21],[5],[6,30],[1,12],[10],[4,15],[7,22],[11,26],[8,17],[9,29],[5],[3,4],[11,30],[12],[4,29],[3],[9],[6],[3,4],[1],[10],[3,29],[10,28],[1,20],[11,13],[3],[3,12],[3,8],[10,9],[3,26],[8],[7],[5],[13,17],[2,27],[11,15],[12],[9,19],[2,15],[3,16],[1],[12,17],[9,1],[6,19],[4],[5],[5],[8,1],[11,7],[5,2],[9,28],[1],[2,2],[7,4],[4,22],[7,24],[9,26],[13,28],[11,26]])
//        [null,null,null,null,null,-1,null,19,17,null,-1,null,null,null,-1,null,-1,5,-1,12,null,null,3,5,5,null,null,1,null,-1,null,30,5,30,null,null,null,-1,null,-1,24,null,null,18,null,null,null,null,14,null,null,18,null,null,11,null,null,null,null,null,18,null,null,24,null,4,29,30,null,12,11,null,null,null,null,29,null,null,null,null,17,22,18,null,null,null,24,null,null,null,20,null,null,null,29,18,18,null,null,null,null,20,null,null,null,null,null,null,null]
//        [null,null,null,null,null,-1,null,19,17,null,-1,null,null,null,-1,null,-1,5,-1,12,null,null,3,5,5,null,null,1,null,-1,null,30,5,30,null,null,null,-1,null,-1,24,null,null,18,null,null,null,null,-1,null,null,18,null,null,-1,null,null,null,null,null,18,null,null,-1,null,4,29,30,null,12,-1,null,null,null,null,29,null,null,null,null,17,22,18,null,null,null,-1,null,null,null,20,null,null,null,-1,18,18,null,null,null,null,20,null,null,null,null,null,null,null]
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
    
//    51. 数组中的逆序对
//    在数组中的两个数字，如果前面一个数字大于后面的数字，则这两个数字组成一个逆序对。输入一个数组，求出这个数组中的逆序对的总数。
//    示例 1:
//    输入: [7,5,6,4]
//    输出: 5
//    限制：
//    0 <= 数组长度 <= 50000
//    链接：https://leetcode-cn.com/problems/shu-zu-zhong-de-ni-xu-dui-lcof
    class func reversePairs(_ nums: [Int]) -> Int {
        guard nums.count > 1 else {
            return 0
        }
        var array = nums
        var result = 0
        reversePairsHelper(&array, &result, 0, array.count)
        return result
    }
    
    class func reversePairsHelper(_ nums: inout [Int],_ result: inout Int,_ begin: Int,_ end: Int) {
        if end - begin < 2{
            return
        }
        let mid = (begin + end) / 2
        reversePairsHelper(&nums, &result, begin, mid)
        reversePairsHelper(&nums, &result, mid, end)
        mergeHelper(&nums, &result, begin, mid, end)
    }
    
    class func mergeHelper(_ nums: inout [Int],_ result: inout Int,_ begin: Int,_ mid: Int,_ end: Int) {
        let leftArray = Array(nums[begin..<mid])
        var left = 0
        var right = mid
        var index = begin
        while left < leftArray.count && right < end {
            if leftArray[left] <= nums[right] {
                nums[index] = leftArray[left]
                left += 1
                result += (right - mid)
            }else {
                nums[index] = nums[right]
                right += 1
            }
            index += 1
        }
        while left < leftArray.count {
            nums[index] = leftArray[left]
            left += 1
            index += 1
            result += (right - mid)
        }
        while right < end  {
            nums[index] = nums[right]
            right += 1
            index += 1
        }
    }
    
    class func reversePairs1(_ nums: [Int]) -> Int {
        //超时
        if nums.count > 1 {
//            [7,5,6,4]
//            [(_,1 + 1 + 1),(6,1),(_,1),(_,0)]   (后面比自己大的最大的数,后面比自己小的数的个数)
            var array = [(Int?,Int)]()
            for _ in nums {
                array.append((nil,0))
            }
            var i = nums.count - 2
            while i >= 0 {
                let num = nums[i]
                let nextNum = nums[i + 1]
                let nextTuple = array[i + 1]
                
                if nextTuple.0 != nil && num > nextTuple.0! {
                    //当前数比下一个数大  比后面所有数都大
                    array[i] = (nil,nums.count - i - 1)
                }else if nextTuple.0 == nil && num > nextNum {
                    array[i] = (nil,1 + nextTuple.1)
                }else {
                    //后面有比当前数更大的
                    var count = 0
                    var j = i + 1
                    var maxNum = num
                    while j < nums.count {
                        let num1 = nums[j]
                        let tuple1 = array[j]
                        if num1 < num {
                            count += 1
                            if tuple1.0 == nil  {
                                //后面不存在更大的数了
                                count += tuple1.1
                                break
                            }else if tuple1.0 != nil && num > tuple1.0! {
                                count += (nums.count - j - 1)
                                break
                            }else {
                                //后面还有比我大的数，继续往后找
                            }
                        }else {
                            maxNum = max(maxNum, num1)
                        }
                        j += 1
                    }
                    array[i] = (maxNum,count)
                }
                i -= 1
            }
            var sum = 0
            for (_,count) in array {
                sum += count
            }
            print(array)
            return sum
        }
        return 0
    }
    
//    50. 第一个只出现一次的字符
//    在字符串 s 中找出第一个只出现一次的字符。如果没有，返回一个单空格。 s 只包含小写字母。
//    示例:
//    s = "abaccdeff"
//    返回 "b"
//    s = ""
//    返回 " "
//    限制：
//    0 <= s 的长度 <= 50000
//    链接：https://leetcode-cn.com/problems/di-yi-ge-zhi-chu-xian-yi-ci-de-zi-fu-lcof
    class func firstUniqChar(_ s: String) -> Character {
        if s.count > 0 {
            var dic = [Character : Int]()
            var notSet = Set<Character>()
            let array = Array(s)
            var i = 0
            while i < array.count {
                let ch = array[i]
                if !notSet.contains(ch) {
                    if dic[ch] == nil {
                        dic[ch] = i
                    }else {
                        dic.removeValue(forKey: ch)
                        notSet.insert(ch)
                    }
                }
                i += 1
            }
            if dic.count > 0 {
                var firstKey: Character = " "
                var firstIndex = array.count
                for (key,value) in dic {
                    if value < firstIndex {
                        firstIndex = value
                        firstKey = key
                    }
                }
                return firstKey
            }
        }
        return " "
    }
    
//    49. 丑数
//    我们把只包含质因子 2、3 和 5 的数称作丑数（Ugly Number）。求按从小到大的顺序的第 n 个丑数。
//    示例:
//    输入: n = 10
//    输出: 12
//    解释: 1, 2, 3, 4, 5, 6, 8, 9, 10, 12 是前 10 个丑数。
//    说明:
//
//    1 是丑数。
//    n 不超过1690。
//    注意：本题与主站 264 题相同：https://leetcode-cn.com/problems/ugly-number-ii/
//    链接：https://leetcode-cn.com/problems/chou-shu-lcof
    class func nthUglyNumber(_ n: Int) -> Int {
        //1--2 3 5
        //2--4 6 10
        //3--6 9 15
        //5--10 15 25
        //4--8 12 20
        //6--12 18 30
        var array = [Int]()
        array.append(1)
        var p2 = 0
        var p3 = 0
        var p5 = 0
        var i = 1
        while i < n {
            let minNum = min(min(array[p3] * 3, array[p5] * 5), array[p2] * 2)
            array.append(minNum)
            i += 1
            if minNum == array[p2] * 2 {
                p2 += 1
            }
            if minNum == array[p3] * 3 {
                p3 += 1
            }
            if minNum == array[p5] * 5 {
                p5 += 1
            }
        }
        return array[n - 1]
    }
    
//    48. 最长不含重复字符的子字符串
//    请从字符串中找出一个最长的不包含重复字符的子字符串，计算该最长子字符串的长度。
//    示例 1:
//    输入: "abcabcbb"
//    输出: 3
//    解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
//    示例 2:
//    输入: "bbbbb"
//    输出: 1
//    解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
//    示例 3:
//    输入: "pwwkew"
//    输出: 3
//    解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
//         请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。
//    提示：
//    s.length <= 40000
//    注意：本题与主站 3 题相同：https://leetcode-cn.com/problems/longest-substring-without-repeating-characters/
//    链接：https://leetcode-cn.com/problems/zui-chang-bu-han-zhong-fu-zi-fu-de-zi-zi-fu-chuan-lcof
    class func lengthOfLongestSubstring(_ s: String) -> Int {
        let array = Array(s)
        if array.count > 0 {
            var maxLen = 0
            var left = 0
            var right = 0
            var set = Set<Character>()
            while right < array.count {
                let ch = array[right]
                while set.contains(ch) {
                    let leftCh = array[left]
                    set.remove(leftCh)
                    left += 1
                }
                set.insert(ch)
                right += 1
                maxLen = max(maxLen, right - left)
            }
            return maxLen
        }
        return 0
    }
    
    //47. 礼物的最大价值
    //在一个 m*n 的棋盘的每一格都放有一个礼物，每个礼物都有一定的价值（价值大于 0）。你可以从棋盘的左上角开始拿格子里的礼物，并每次向右或者向下移动一格、直到到达棋盘的右下角。给定一个棋盘及其上面的礼物的价值，请计算你最多能拿到多少价值的礼物？
    //示例 1:
    //输入:
//    [
//      [1,3,1],
//      [1,5,1],
//      [4,2,1]
//    ]
    //输出: 12
    //解释: 路径 1→3→5→2→1 可以拿到最多价值的礼物
    //提示：
    //0 < grid.length <= 200
    //0 < grid[0].length <= 200
    //链接：https://leetcode-cn.com/problems/li-wu-de-zui-da-jie-zhi-lcof
    class func maxValue(_ grid: [[Int]]) -> Int {
    //    dp[m][n] = max(dp[m][n-1], dp[m-1][n])
    //    dp[0][0] = grid[0][0]
        let M = grid.count
        let N = grid[0].count
        var dp = Array(repeating: 0, count: N)
        var m = 0
        while m < M {
            var n = 0
            while n < N {
                let num = grid[m][n]
                if m == 0 && n == 0 {
                    dp[n] = num
                }else {
                    if m == 0 {
                        dp[n] = dp[n - 1] + num
                    }else if n == 0 {
                        dp[n] = dp[n] + num
                    }else {
                        dp[n] = max(dp[n - 1], dp[n]) + num
                    }
                }
                n += 1
            }
            m += 1
        }
        return dp[N - 1]
    }
}

