//
//  二进制.swift
//  StyfStudyNotes
//
//  Created by styf on 2021/2/26.
//

import Foundation
//移除最后一个 1
//a=n & (n - 1)

//获取最后一个 1
//diff=(n & (n-1)) ^ n

//基本操作
//a=0^a=a^0
//0=a^a
//由上面两个推导出：a=a^b^b

//如果 a ^ b = c 成立，那么a ^ c = b 与 b ^ c = a 均成立。

//交换两个数
//a=a^b
//b=a^b
//a=a^b

//大写转小写
//('a' | ' ') = 'a'
//('A' | ' ') = 'a'

//小写转大写
//('b' & '_') = 'b'
//('B' & '_') = 'b'

//大小写互换
//('d' ^ ' ') = 'D'
//('D' ^ ' ') = 'b'

//判断两个数是否异号
// int x = -1,y = 2
// bool f = ((x^y) < 0) //true

//加一
// int n = 1
// n = -~n

//减一
// int n = 2
// n = ~-n

// 求1-n素数  排除法

@objcMembers class Math : NSObject {
    class func test() {
        //    172. 阶乘后的零
//        print(trailingZeroes(124))
        //    793. 阶乘函数后 K 个零
//        print(preimageSizeFZF(31))
//        print(preimageSizeFZF(5))
//        3 * 3 * 3 * 3 % 5
//        print("\(2147483647 % 1337)")//932
        
        //    372. 超级次方
//        print(superPow(2, [3]))//8
//        print(superPow(2, [1,0]))//1024
//        print(superPow(2147483647, [2,0,0]))//1198
        
        //    645. 错误的集合
//        print(findErrorNums([1,2,2,4]))//[2,3]
//        print(findErrorNums([1,1]))//[1,2]
//        print(findErrorNums([2,2]))//
        
        //    877. 石子游戏
        print(stoneGame([5,3,4,5]))//true
        print(stoneGame([3,7,2,3]))//true
    }
//    877. 石子游戏
//    Alice 和 Bob 用几堆石子在做游戏。一共有偶数堆石子，排成一行；每堆都有 正 整数颗石子，数目为 piles[i] 。
//    游戏以谁手中的石子最多来决出胜负。石子的 总数 是 奇数 ，所以没有平局。
//    Alice 和 Bob 轮流进行，Alice 先开始 。 每回合，玩家从行的 开始 或 结束 处取走整堆石头。 这种情况一直持续到没有更多的石子堆为止，此时手中 石子最多 的玩家 获胜 。
//    假设 Alice 和 Bob 都发挥出最佳水平，当 Alice 赢得比赛时返回 true ，当 Bob 赢得比赛时返回 false 。
//    示例 1：
//    输入：piles = [5,3,4,5]
//    输出：true
//    解释：
//    Alice 先开始，只能拿前 5 颗或后 5 颗石子 。
//    假设他取了前 5 颗，这一行就变成了 [3,4,5] 。
//    如果 Bob 拿走前 3 颗，那么剩下的是 [4,5]，Alice 拿走后 5 颗赢得 10 分。
//    如果 Bob 拿走后 5 颗，那么剩下的是 [3,4]，Alice 拿走后 4 颗赢得 9 分。
//    这表明，取前 5 颗石子对 Alice 来说是一个胜利的举动，所以返回 true 。
//    示例 2：
//    输入：piles = [3,7,2,3]
//    输出：true
//    提示：
//    2 <= piles.length <= 500
//    piles.length 是 偶数
//    1 <= piles[i] <= 500
//    sum(piles[i]) 是 奇数
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/stone-game
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func stoneGame(_ piles: [Int]) -> Bool {
        return true
        
        var sum = piles[0]
        var hand = piles[0]
        var handTotal = 0
        var i = 1
        while i < piles.count {
            let next = piles[i]
            sum += next
            if i % 2 == 1 {
                handTotal += (hand > next) ? hand : next
            }else {
                hand = next
            }
            i += 1
        }
        return handTotal > (sum / 2)
    }
//    292. Nim 游戏
//    你和你的朋友，两个人一起玩 Nim 游戏：
//    桌子上有一堆石头。
//    你们轮流进行自己的回合，你作为先手。
//    每一回合，轮到的人拿掉 1 - 3 块石头。
//    拿掉最后一块石头的人就是获胜者。
//    假设你们每一步都是最优解。请编写一个函数，来判断你是否可以在给定石头数量为 n 的情况下赢得游戏。如果可以赢，返回 true；否则，返回 false 。
//    示例 1：
//    输入：n = 4
//    输出：false
//    解释：如果堆中有 4 块石头，那么你永远不会赢得比赛；
//         因为无论你拿走 1 块、2 块 还是 3 块石头，最后一块石头总是会被你的朋友拿走。
//    示例 2：
//    输入：n = 1
//    输出：true
//    示例 3：
//    输入：n = 2
//    输出：true
//    提示：
//    1 <= n <= 231 - 1
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/nim-game
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func canWinNim(_ n: Int) -> Bool {
        return n % 4 != 0
    }
    
//    398. 随机数索引
//    给定一个可能含有重复元素的整数数组，要求随机输出给定的数字的索引。 您可以假设给定的数字一定存在于数组中。
//    注意：
//    数组大小可能非常大。 使用太多额外空间的解决方案将不会通过测试。
//    示例:
//    int[] nums = new int[] {1,2,3,3,3};
//    Solution solution = new Solution(nums);
//    // pick(3) 应该返回索引 2,3 或者 4。每个索引的返回概率应该相等。
//    solution.pick(3);
//    // pick(1) 应该返回 0。因为只有nums[0]等于1。
//    solution.pick(1);
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/random-pick-index
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class Solution222 {
        var array: [Int]
        init(_ nums: [Int]) {
            array = nums
        }
        
        func pick(_ target: Int) -> Int {
            var count = 0
            var res = 0
            var i = 0
            while i < array.count {
                if array[i] == target {
                    count += 1
                    if Int.random(in: 1...count) == 1 {
                        res = i
                    }
                }
                i += 1
            }
            return res
        }
    }
    
    //    382. 链表随机节点
    //    给定一个单链表，随机选择链表的一个节点，并返回相应的节点值。保证每个节点被选的概率一样。
    //    进阶:
    //    如果链表十分大且长度未知，如何解决这个问题？你能否使用常数级空间复杂度实现？
    //    示例:
    //    // 初始化一个单链表 [1,2,3].
    //    ListNode head = new ListNode(1);
    //    head.next = new ListNode(2);
    //    head.next.next = new ListNode(3);
    //    Solution solution = new Solution(head);
    //    // getRandom()方法应随机返回1,2,3中的一个，保证每个元素被返回的概率相等。
    //    solution.getRandom();
    //    来源：力扣（LeetCode）
    //    链接：https://leetcode-cn.com/problems/linked-list-random-node
    //    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
        class Solution1111 {
            // 核心思想：拿到第i个元素，保留它的概率是 1/i  丢弃它的概率是 1- 1/i
            public class ListNode {
                public var val: Int
                public var next: ListNode?
                public init() { self.val = 0; self.next = nil; }
                public init(_ val: Int) { self.val = val; self.next = nil; }
                public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
            }
            private var head: ListNode?
            init(_ head: ListNode?) {
                self.head = head
            }
            
            func getRandom() -> Int {
                var node = head
                var res: ListNode?
                var i = 1
                while node != nil {
                    if Int.random(in: 1...i) == 1 {
                        res = node
                    }
                    node = node?.next
                    i += 1
                }
                return res!.val
            }
        }
    
//    645. 错误的集合
//    集合 s 包含从 1 到 n 的整数。不幸的是，因为数据错误，导致集合里面某一个数字复制了成了集合里面的另外一个数字的值，导致集合 丢失了一个数字 并且 有一个数字重复 。
//    给定一个数组 nums 代表了集合 S 发生错误后的结果。
//    请你找出重复出现的整数，再找到丢失的整数，将它们以数组的形式返回。
//    示例 1：
//    输入：nums = [1,2,2,4]
//    输出：[2,3]
//    示例 2：
//    输入：nums = [1,1]
//    输出：[1,2]
//    提示：
//    2 <= nums.length <= 104
//    1 <= nums[i] <= 104
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/set-mismatch
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func findErrorNums(_ nums: [Int]) -> [Int] {
        //核心思路
        // 对于每个索引，把对应的位置改负数作为已对应的标记  如果两个数对应同一个位置就是重复
        // 再遍历一遍，看看哪个位置是正数，对应的数就是缺失
        var arr = nums
        var res: [Int] = []
        var i = 0
        while i < arr.count {
            let arrNum = abs(arr[i])
            let numIndex = arrNum - 1
            let num = arr[numIndex]
            if num < 0 {
                res.append(arrNum)
            }else {
                arr[numIndex] = -num
            }
            i += 1
        }
        //再遍历一遍
        i = 0
        while i < arr.count {
            let num = arr[i]
            if num > 0 {
                res.append(i + 1)
                break
            }
            i += 1
        }
        return res
    }
    
//    372. 超级次方
//    你的任务是计算 a^b 对 1337 取模，a 是一个正整数，b 是一个非常大的正整数且会以数组形式给出。
//    示例 1：
//    输入：a = 2, b = [3]
//    输出：8
//    示例 2：
//    输入：a = 2, b = [1,0]
//    输出：1024
//    示例 3：
//    输入：a = 1, b = [4,3,3,8,5,2]
//    输出：1
//    示例 4：
//    输入：a = 2147483647, b = [2,0,0]
//    输出：1198
//    提示：
//    1 <= a <= 231 - 1
//    1 <= b.length <= 2000
//    0 <= b[i] <= 9
//    b 不含前导 0
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/super-pow
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func superPow(_ a: Int, _ b: [Int]) -> Int {
        if a == 1 {
            return 1
        }
        
        var aa = a
        if aa > 1337 {
            aa %= 1337
        }
        // 核心1
        //        a^[123456] = a^6 * a^[123450]
        //                   = a^6 * (a^[12345])^10
        // 核心2
        // (a * b) % c = (a % c)(b % c)%c
        
        
        var bb = b
        let last = bb.removeLast()
        var cheng = myPow(aa, last)
        if bb.count > 0 {
            let hou = superPow(aa, bb)
            cheng *= myPow(hou, 10)
        }
        if cheng > 1337 {
            cheng %= 1337
        }
        return cheng
    }
    
    class func myPow(_ a:Int,_ b: Int) -> Int {
        if b == 0 {
            return 1
        }
        var val = myPow(a, b / 2)
        if val > 1337 {
            val %= 1337
        }
        if (b % 2) == 0 {
//            5^10 =  (5^5)^2
            return val * val
        }
        // 5^9 = 5 * (5^4)^2
        return a * val * val
    }
    
//    793. 阶乘函数后 K 个零
//    f(x) 是 x! 末尾是 0 的数量。（回想一下 x! = 1 * 2 * 3 * ... * x，且 0! = 1 ）
//    例如， f(3) = 0 ，因为 3! = 6 的末尾没有 0 ；而 f(11) = 2 ，因为 11!= 39916800 末端有 2 个 0 。给定 K，找出多少个非负整数 x ，能满足 f(x) = K 。
//    示例 1：
//    输入：K = 0
//    输出：5
//    解释：0!, 1!, 2!, 3!, and 4! 均符合 K = 0 的条件。
//    示例 2：
//    输入：K = 5
//    输出：0
//    解释：没有匹配到这样的 x!，符合 K = 5 的条件。
//    提示：
//    K 是范围在 [0, 10^9] 的整数。
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/preimage-size-of-factorial-zeroes-function
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func preimageSizeFZF(_ k: Int) -> Int {
        // a + b + c = k
        // 25 + 5 + 1 = 31
        // 24 + 4     = 25
        // 6 + 1       = 7
        var left = 0
        var right = Int.max
        while left <= right {
            let mid = left + (right - left) / 2
            let kk = trailingZeroes(mid)
            if kk == k {
                right = mid - 1
            }else if kk < k {
                left = mid + 1
            }else {
                right = mid - 1
            }
        }
        
        let leftBound = left
        left = 0
        right = Int.max
        while left <= right {
            let mid = left + (right - left) / 2
            let kk = trailingZeroes(mid)
            if kk == k {
                left = mid + 1
            }else if kk < k {
                left = mid + 1
            }else {
                right = mid - 1
            }
        }
        let rightBound = right
        
        return rightBound - leftBound + 1
    }
    
//    172. 阶乘后的零
//    给定一个整数 n ，返回 n! 结果中尾随零的数量。
//    提示 n! = n * (n - 1) * (n - 2) * ... * 3 * 2 * 1
//    示例 1：
//    输入：n = 3
//    输出：0
//    解释：3! = 6 ，不含尾随 0
//    示例 2：
//    输入：n = 5
//    输出：1
//    解释：5! = 120 ，有一个尾随 0
//    示例 3：
//    输入：n = 0
//    输出：0
//    提示：
//    0 <= n <= 104
//    进阶：你可以设计并实现对数时间复杂度的算法来解决此问题吗？
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/factorial-trailing-zeroes
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func trailingZeroes(_ n: Int) -> Int {
//        0001 0010 0011 0100 0101 0110 0111 1000 1001 1010
//        1    2    3    4    5    6    7    8    9    10
        // 问题转化为可以分解出多少个5 因为分解出来的2肯定比5多
        
        //一个因子的
        var count = 0
        var lei = 5
        while lei <= n {
            count += (n / lei)
            lei *= 5
        }
        return count
    }
}
