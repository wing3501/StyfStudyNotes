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
//        53 - I. 在排序数组中查找数字 I
//        print(search([5,7,7,8,8,10], 8))
//        print(search([5,7,7,8,8,10], 6))
//        53 - II. 0～n-1中缺失的数字
//        print(missingNumber([0,1,3]))
//        print(missingNumber([0,1,2,3,4,5,6,7,9]))
//        print(missingNumber([0,1]))
//        print(missingNumber([1,2]))
        
//        54. 二叉搜索树的第k大节点
//        let node = TreeTest.deserialize("[41,37,44,24,39,42,48,1,35,38,40,null,43,46,49,0,2,30,36,null,null,null,null,null,null,45,47,null,null,null,null,null,4,29,32,null,null,null,null,null,null,3,9,26,null,31,34,null,null,7,11,25,27,null,null,33,null,6,8,10,16,null,null,null,28,null,null,5,null,null,null,null,null,15,19,null,null,null,null,12,null,18,20,null,13,17,null,null,22,null,14,null,null,21,23]")
//        print(kthLargest(node, 25))//25
        
//        56 - I. 数组中数字出现的次数
        print(singleNumbers([4,1,4,6]))//[1,6]
        print(singleNumbers([1,2,10,4,1,4,3,3]))//[2,10]
    }
//    56 - I. 数组中数字出现的次数
//    一个整型数组 nums 里除两个数字之外，其他数字都出现了两次。请写程序找出这两个只出现一次的数字。要求时间复杂度是O(n)，空间复杂度是O(1)。
//    示例 1：
//    输入：nums = [4,1,4,6]
//    输出：[1,6] 或 [6,1]
//    示例 2：
//    输入：nums = [1,2,10,4,1,4,3,3]
//    输出：[2,10] 或 [10,2]
//    限制：
//    2 <= nums.length <= 10000
//    链接：https://leetcode-cn.com/problems/shu-zu-zhong-shu-zi-chu-xian-de-ci-shu-lcof
    class func singleNumbers(_ nums: [Int]) -> [Int] {
//        先对所有数字进行一次异或，得到两个出现一次的数字的异或值。
//        在异或结果中找到任意为 1 的位。
//        根据这一位对所有的数字进行分组。
//        在每个组内进行异或操作，得到两个数字。
        var x = nums[0]
        var i = 1
        while i < nums.count {
            x ^= nums[i]
            i += 1
        }
        var wei = 1
        while x & wei == 0 {
            wei = wei << 1
        }
        var x0 = 0
        var x1 = 0
        i = 0
        while i < nums.count {
            if nums[i] & wei == 0 {
                x0 ^= nums[i]
            }else {
                x1 ^= nums[i]
            }
            i += 1
        }
        return [x0,x1]
    }
//    55 - II. 平衡二叉树
//    输入一棵二叉树的根节点，判断该树是不是平衡二叉树。如果某二叉树中任意节点的左右子树的深度相差不超过1，那么它就是一棵平衡二叉树。
//    示例 1:
//    给定二叉树 [3,9,20,null,null,15,7]
//        3
//       / \
//      9  20
//        /  \
//       15   7
//    返回 true 。
//    示例 2:
//    给定二叉树 [1,2,2,3,3,null,null,4,4]
//           1
//          / \
//         2   2
//        / \
//       3   3
//      / \
//     4   4
//    返回 false 。
//    限制：
//    0 <= 树的结点个数 <= 10000
//    注意：本题与主站 110 题相同：https://leetcode-cn.com/problems/balanced-binary-tree/
//    链接：https://leetcode-cn.com/problems/ping-heng-er-cha-shu-lcof
    class func isBalanced(_ root: TreeNode?) -> Bool {
        return isBalancedHelper(root).1
    }
    class func isBalancedHelper(_ node: TreeNode?) -> (Int,Bool) {
        if node == nil {
            return (0, true)
        }
        if node?.left == nil && node?.right == nil {
            return (1, true)
        }
        let left = isBalancedHelper(node?.left)
        let right = isBalancedHelper(node?.right)
        if !left.1 || !right.1  {
            return (max(left.0, right.0) + 1, false)
        }
        return (max(left.0, right.0) + 1, fabs(Double(left.0 - right.0)) <= 1.0)
    }
//    I. 二叉树的深度
//    输入一棵二叉树的根节点，求该树的深度。从根节点到叶节点依次经过的节点（含根、叶节点）形成树的一条路径，最长路径的长度为树的深度。
//    例如：
//    给定二叉树 [3,9,20,null,null,15,7]，
//
//        3
//       / \
//      9  20
//        /  \
//       15   7
//    返回它的最大深度 3 。
//    提示：
//    节点总数 <= 10000
//    注意：本题与主站 104 题相同：https://leetcode-cn.com/problems/maximum-depth-of-binary-tree/
//    链接：https://leetcode-cn.com/problems/er-cha-shu-de-shen-du-lcof
    class func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        if root?.left == nil && root?.right == nil {
            return 1
        }
        return max(maxDepth(root?.left), maxDepth(root?.right)) + 1
    }
    
//    54. 二叉搜索树的第k大节点
//    给定一棵二叉搜索树，请找出其中第k大的节点。
//    示例 1:
//    输入: root = [3,1,4,null,2], k = 1
//       3
//      / \
//     1   4
//      \
//       2
//    输出: 4
//    示例 2:
//    输入: root = [5,3,6,2,4,null,null,1], k = 3
//           5
//          / \
//         3   6
//        / \
//       2   4
//      /
//     1
//    输出: 4
//    链接：https://leetcode-cn.com/problems/er-cha-sou-suo-shu-de-di-kda-jie-dian-lcof。
    class func kthLargest(_ root: TreeNode?, _ k: Int) -> Int {
        //中序遍历
        var stack: [TreeNode?] = []
        var node: TreeNode? = root
        var kk = 0
        while true {
            if node != nil {
                stack.append(node)
                node = node?.right
            }else {
                if stack.count == 0 {
                    break
                }else {
                    node = stack.removeLast()
                    print("\(node!.val),")
                    kk += 1
                    if kk == k {
                        return node!.val
                    }
                    node = node?.left
                }
            }
        }
        return 0
    }
    
    class func fanzhuan(_ node: TreeNode?) {
        if let left = node?.left {
            fanzhuan(left)
        }
        if let right = node?.right {
            fanzhuan(right)
        }
        let left = node?.left
        node?.left = node?.right
        node?.right = left
    }
    
//    53 - II. 0～n-1中缺失的数字
//    一个长度为n-1的递增排序数组中的所有数字都是唯一的，并且每个数字都在范围0～n-1之内。在范围0～n-1内的n个数字中有且只有一个数字不在该数组中，请找出这个数字。
//    示例 1:
//    输入: [0,1,3]
//    输出: 2
//    示例 2:
//    输入: [0,1,2,3,4,5,6,7,9]
//    输出: 8
//    限制：
//    1 <= 数组长度 <= 10000
//    链接：https://leetcode-cn.com/problems/que-shi-de-shu-zi-lcof
    class func missingNumber(_ nums: [Int]) -> Int {
        if nums[0] != 0 {
            return 0
        }
        var left = 0
        var right = nums.count - 1
        while left < right - 1 {
            let mid = left + (right - left) / 2
            let num = nums[mid]
            if num > mid {
                right = mid
            }else {
                left = mid
            }
        }
        if nums[left] + 1 == nums[right] {
            return right + 1
        }
        return left + 1
    }
    
//    53 - I. 在排序数组中查找数字 I
//    统计一个数字在排序数组中出现的次数。
//    示例 1:
//    输入: nums = [5,7,7,8,8,10], target = 8
//    输出: 2
//    示例 2:
//    输入: nums = [5,7,7,8,8,10], target = 6
//    输出: 0
//    限制：
//    0 <= 数组长度 <= 50000
//    注意：本题与主站 34 题相同（仅返回值不同）：https://leetcode-cn.com/problems/find-first-and-last-position-of-element-in-sorted-array/
//    链接：https://leetcode-cn.com/problems/zai-pai-xu-shu-zu-zhong-cha-zhao-shu-zi-lcof
    class func search(_ nums: [Int], _ target: Int) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        var left = 0
        var right = nums.count - 1
        while left <= right {
            let mid = left + (right - left) / 2
            let num = nums[mid]
            if num > target {
                right = mid - 1
            }else if num < target {
                left = mid + 1
            }else if num == target {
                right = mid - 1
            }
        }
        if left >= nums.count || nums[left] != target {
            return 0
        }
        let leftBound = left
        
        left = 0
        right = nums.count - 1
        while left <= right {
            let mid = left + (right - left) / 2
            let num = nums[mid]
            if num > target {
                right = mid - 1
            }else if num < target {
                left = mid + 1
            }else if num == target {
                left = mid + 1
            }
        }
        if right < 0 || nums[right] != target {
            return 0
        }
        let rightBound = right
        
        return rightBound - leftBound + 1
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

