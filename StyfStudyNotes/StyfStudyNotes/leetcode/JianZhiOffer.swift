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
//        print(singleNumbers([4,1,4,6]))//[1,6]
//        print(singleNumbers([1,2,10,4,1,4,3,3]))//[2,10]
        
//        57 - II. 和为s的连续正数序列
//        print(findContinuousSequence(9))
        
//        59 - I. 滑动窗口的最大值
//        print(maxSlidingWindow([1,3,1,2,0,5], 3))
        
//        59 - II. 队列的最大值
//        let maxQueue = MaxQueue()
//        maxQueue.push_back(1)
//        maxQueue.push_back(2)
//        print(maxQueue.max_value())
//        print(maxQueue.pop_front())
//        print(maxQueue.max_value())
        
//        let maxQueue = MaxQueue()
//        print(maxQueue.pop_front())
//        print(maxQueue.max_value())
        
//        60. n个骰子的点数
//        print(dicesProbability(1))
//        print(dicesProbability(2))
        
//        61. 扑克牌中的顺子
//        print(isStraight([0,0,2,2,5]))
        
//        62. 圆圈中最后剩下的数字
//        print(lastRemaining(5, 3))//3
//        print(lastRemaining(10, 17))//2
//        print(lastRemaining(70866, 116922))
        
//        63. 股票的最大利润
//        print(maxProfit([7,1,5,3,6,4]))
//        print(maxProfit([7,6,4,3,1]))
        
//        64. 求1+2+…+n
//        print(sumNums(3))//6
//        print(sumNums(9))//45
        
//        65. 不用加减乘除做加法
//        print(add(1, 2))//3
//        print(add(111, 899))//1010
//        print(add(1, -2))//-1
        
//        66. 构建乘积数组
//        print(constructArr([1,2,3,4,5]))//[120,60,40,30,24]
//        print(constructArr([7, 2, 2, 4, 2, 1, 8, 8, 9, 6, 8, 9, 6, 3, 2, 1]))//
        
//        67. 把字符串转换成整数
//        print(strToInt("42"))//42
//        print(strToInt("   -42"))//-42
//        print(strToInt("4193 with words"))//4193
//        print(strToInt("words and 987"))//0
//        print(strToInt("-91283472332"))//-2147483648
//        print(strToInt("20000000000000000000"))//-2147483648
        
        //    剑指 Offer II 001. 整数除法
//        print(divide(7, -3))
        
        //    剑指 Offer II 081. 允许重复选择元素的组合
//        print(combinationSum([2,3,6,7], 7))//[[7],[2,2,3]]
//        print(combinationSum([2,3,5], 8))//[[2,2,2,2],[2,3,3],[3,5]]
//        print(combinationSum([2], 1))//[]
//        print(combinationSum([1], 1))//[[1]]
//        print(combinationSum([1], 2))//[[1,1]]
        
        //    剑指 Offer II 003. 前 n 个数字二进制中 1 的个数
//        print(countBits(5))//[0,1,1,2,1,2]
        
        //    剑指 Offer II 002. 二进制加法
//        print(addBinary("11", "10"))//"101"
//        print(addBinary("1010", "1011"))//"10101"
        
        //    剑指 Offer II 082. 含有重复元素集合的组合
//        print(combinationSum2([10,1,2,7,6,1,5], 8))
//        print(combinationSum2([2,5,2,1,2], 5))
//        print(combinationSum2([1], 1))
//        print(combinationSum2([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1], 27))
        
        //    剑指 Offer II 004. 只出现一次的数字
//        print(singleNumbers2([2,2,3,2]))//3
//        print(singleNumbers2([0,1,0,1,0,1,100]))//100
//        print(singleNumbers2([-2,-2,1,1,4,1,4,4,-4,-2]))//-4
        
        //    剑指 Offer II 083. 没有重复元素集合的全排列
//        print(permute([1,2,3]))
        
        //    剑指 Offer II 084. 含有重复元素集合的全排列
//        print(permuteUnique([1,1,2]))
//        print(permuteUnique([1,2,3]))
        
        //    剑指 Offer II 005. 单词长度的最大乘积
//        print(maxProduct(["abcw","baz","foo","bar","fxyz","abcdef"]))
//        print(maxProduct(["a","aa","aaa","aaaa"]))
        
        //    剑指 Offer II 085. 生成匹配的括号
//        print(generateParenthesis(3))
        
        //    剑指 Offer II 007. 数组中和为 0 的三个数
//        print(threeSum123([-1,0,1,2,-1,-4]))
//        print(threeSum123([]))
//        print(threeSum123([0]))
//        print(threeSum123([-2,0,1,1,2]))//[[-2,0,2],[-2,1,1]]
        
        //    剑指 Offer II 086. 分割回文子字符串
//        print(partition("google"))
//        print(partition("aab"))
//        print(partition("a"))
//        print(partition("fff"))
        
        //    剑指 Offer II 087. 复原 IP
//        print(restoreIpAddresses("25525511135"))
//        print(restoreIpAddresses("0000"))
//        print(restoreIpAddresses("1111"))
//        print(restoreIpAddresses("010010"))
//        print(restoreIpAddresses("10203040"))
        
        //    剑指 Offer II 008. 和大于等于 target 的最短子数组
//        print(minSubArrayLen(7, [2,3,1,2,4,3]))//2
//        print(minSubArrayLen(4, [1,4,4]))//1
//        print(minSubArrayLen(11, [1,1,1,1,1,1,1,1]))//0
        
        //    剑指 Offer II 088. 爬楼梯的最少成本
//        print(minCostClimbingStairs([10, 15, 20]))//15
//        print(minCostClimbingStairs([1, 100, 1, 1, 1, 100, 1, 1, 100, 1]))//6
        
        //    剑指 Offer II 009. 乘积小于 K 的子数组
//        print(numSubarrayProductLessThanK([10,5,2,6], 100))
//        print(numSubarrayProductLessThanK([1,2,3], 0))
        //    剑指 Offer II 089. 房屋偷盗
//        print(rob([1,2,3,1]))
//        print(rob([2,7,9,3,1]))
        
        //    剑指 Offer II 010. 和为 k 的子数组
//        print(subarraySum([1,1,1], 2))
//        print(subarraySum([1,2,3], 3))
//        print(subarraySum([1], 0))
        
        //    剑指 Offer II 011. 0 和 1 个数相同的子数组
//        print(findMaxLength([0,1]))//2
//        print(findMaxLength([0,1,0]))//2
//        print(findMaxLength([0,0,1]))//1
//        print(findMaxLength([0,0,1,0,0,0,1,1]))//6
        
        //    剑指 Offer II 012. 左右两边子数组的和相等
//        print(pivotIndex([1,7,3,6,5,6]))//3
//        print(pivotIndex([1, 2, 3]))//-1
//        print(pivotIndex([2, 1, -1]))//0
//        print(pivotIndex([-1,-1,-1,-1,-1,0]))//2
        
        //    剑指 Offer II 013. 二维子矩阵的和
//        let numMatrix = NumMatrix([[3,0,1,4,2],[5,6,3,2,1],[1,2,0,1,5],[4,1,0,1,7],[1,0,3,0,5]])
//        print(numMatrix.sumRegion(2, 1, 4, 3))//8
//        print(numMatrix.sumRegion(1, 1, 2, 2))//11
//        print(numMatrix.sumRegion(1, 2, 2, 4))//12
        
        //    剑指 Offer II 014. 字符串中的变位词
//        print(checkInclusion("ab", "eidbaooo"))
//        print(checkInclusion("ab", "eidboaoo"))
    }
//    剑指 Offer II 015. 字符串中的所有变位词
//    给定两个字符串 s 和 p，找到 s 中所有 p 的 变位词 的子串，返回这些子串的起始索引。不考虑答案输出的顺序。
//    变位词 指字母相同，但排列不同的字符串。
//    示例 1:
//    输入: s = "cbaebabacd", p = "abc"
//    输出: [0,6]
//    解释:
//    起始索引等于 0 的子串是 "cba", 它是 "abc" 的变位词。
//    起始索引等于 6 的子串是 "bac", 它是 "abc" 的变位词。
//     示例 2:
//    输入: s = "abab", p = "ab"
//    输出: [0,1,2]
//    解释:
//    起始索引等于 0 的子串是 "ab", 它是 "ab" 的变位词。
//    起始索引等于 1 的子串是 "ba", 它是 "ab" 的变位词。
//    起始索引等于 2 的子串是 "ab", 它是 "ab" 的变位词。
//    提示:
//    1 <= s.length, p.length <= 3 * 104
//    s 和 p 仅包含小写字母
//    注意：本题与主站 438 题相同： https://leetcode-cn.com/problems/find-all-anagrams-in-a-string/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/VabMRr
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func findAnagrams(_ s: String, _ p: String) -> [Int] {

    }
//    剑指 Offer II 014. 字符串中的变位词
//    给定两个字符串 s1 和 s2，写一个函数来判断 s2 是否包含 s1 的某个变位词。
//    换句话说，第一个字符串的排列之一是第二个字符串的 子串 。
//    示例 1：
//    输入: s1 = "ab" s2 = "eidbaooo"
//    输出: True
//    解释: s2 包含 s1 的排列之一 ("ba").
//    示例 2：
//    输入: s1= "ab" s2 = "eidboaoo"
//    输出: False
//    提示：
//    1 <= s1.length, s2.length <= 104
//    s1 和 s2 仅包含小写字母
//    注意：本题与主站 567 题相同： https://leetcode-cn.com/problems/permutation-in-string/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/MPnaiL
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func checkInclusion(_ s1: String, _ s2: String) -> Bool {
        let ss1 = Array(s1)
        let ss2 = Array(s2)
        var needCount = ss1.count
        var need: [Character:Int] = [:]
        for item in ss1 {
            need[item,default: 0] += 1
        }
        var l = 0
        var r = 0
//        var win: [Character:Int] = [:]
        while r < ss2.count {
            let rightCh = ss2[r]
            r += 1
            
//            win[rightCh,default: 0] += 1
            if let chCount = need[rightCh] {
                need[rightCh] = chCount - 1
                if chCount > 0 {
                    needCount -= 1
                }
            }
            
            //缩减窗口
            while r - l > ss1.count {
                let leftCh = ss2[l]
                if let chCount = need[leftCh] {
                    need[leftCh] = chCount + 1
                    if need[leftCh]! > 0 {
                        needCount += 1
                    }
                }
                l += 1
            }
            if r - l == ss1.count && needCount == 0 {
                return true
            }
        }
        return false
    }
//    剑指 Offer II 013. 二维子矩阵的和
//    给定一个二维矩阵 matrix，以下类型的多个请求：
//    计算其子矩形范围内元素的总和，该子矩阵的左上角为 (row1, col1) ，右下角为 (row2, col2) 。
//    实现 NumMatrix 类：
//    NumMatrix(int[][] matrix) 给定整数矩阵 matrix 进行初始化
//    int sumRegion(int row1, int col1, int row2, int col2) 返回左上角 (row1, col1) 、右下角 (row2, col2) 的子矩阵的元素总和。
//    示例 1：
//    输入:
//    ["NumMatrix","sumRegion","sumRegion","sumRegion"]
//    [[[ [3,0,1,4,2],
//        [5,6,3,2,1],
//        [1,2,0,1,5],
//        [4,1,0,1,7],
//        [1,0,3,0,5]
//
//    ]],[2,1,4,3],[1,1,2,2],[1,2,2,4]]
//    输出:
//    [null, 8, 11, 12]
//    解释:
//    NumMatrix numMatrix = new NumMatrix([[3,0,1,4,2],[5,6,3,2,1],[1,2,0,1,5],[4,1,0,1,7],[1,0,3,0,5]]]);
//    numMatrix.sumRegion(2, 1, 4, 3); // return 8 (红色矩形框的元素总和)
//    numMatrix.sumRegion(1, 1, 2, 2); // return 11 (绿色矩形框的元素总和)
//    numMatrix.sumRegion(1, 2, 2, 4); // return 12 (蓝色矩形框的元素总和)
//    提示：
//    m == matrix.length
//    n == matrix[i].length
//    1 <= m, n <= 200
//    -105 <= matrix[i][j] <= 105
//    0 <= row1 <= row2 < m
//    0 <= col1 <= col2 < n
//    最多调用 104 次 sumRegion 方法
//    注意：本题与主站 304 题相同： https://leetcode-cn.com/problems/range-sum-query-2d-immutable/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/O4NDxx
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class NumMatrix {
        var sum: [[Int]] = []  //保存[0,0]到[i,j]的累加和
        init(_ matrix: [[Int]]) {
            guard matrix.count > 0,matrix[0].count > 0 else { return }
            sum = Array(repeating: Array(repeating: 0, count: matrix[0].count), count: matrix.count)
            var row = 0
            while row < matrix.count {
                var col = 0
                var rowSum = 0
                while col < matrix[0].count {
                    if row == 0 {
                        sum[row][col] = col == 0 ? matrix[row][col] : sum[row][col - 1] + matrix[row][col]
                    }else {
                        rowSum += matrix[row][col]
                        sum[row][col] = sum[row - 1][col] + rowSum
                    }
                    col += 1
                }
                row += 1
            }
        }
        
        func sumRegion(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
            let total = sum[row2][col2]
            let leftTop = (row1 > 0 && col1 > 0) ? sum[row1 - 1][col1 - 1] : 0
            let top = row1 > 0 ? sum[row1 - 1][col2] - leftTop : 0
            let left = col1 > 0 ? sum[row2][col1 - 1] - leftTop : 0
            return total - leftTop - top - left
        }
    }
//    剑指 Offer II 012. 左右两边子数组的和相等
//    给你一个整数数组 nums ，请计算数组的 中心下标 。
//    数组 中心下标 是数组的一个下标，其左侧所有元素相加的和等于右侧所有元素相加的和。
//    如果中心下标位于数组最左端，那么左侧数之和视为 0 ，因为在下标的左侧不存在元素。这一点对于中心下标位于数组最右端同样适用。
//    如果数组有多个中心下标，应该返回 最靠近左边 的那一个。如果数组不存在中心下标，返回 -1 。
//    示例 1：
//    输入：nums = [1,7,3,6,5,6]
//    输出：3
//    解释：
//    中心下标是 3 。
//    左侧数之和 sum = nums[0] + nums[1] + nums[2] = 1 + 7 + 3 = 11 ，
//    右侧数之和 sum = nums[4] + nums[5] = 5 + 6 = 11 ，二者相等。
//    示例 2：
//    输入：nums = [1, 2, 3]
//    输出：-1
//    解释：
//    数组中不存在满足此条件的中心下标。
//    示例 3：
//    输入：nums = [2, 1, -1]
//    输出：0
//    解释：
//    中心下标是 0 。
//    左侧数之和 sum = 0 ，（下标 0 左侧不存在元素），
//    右侧数之和 sum = nums[1] + nums[2] = 1 + -1 = 0 。
//    提示：
//    1 <= nums.length <= 104
//    -1000 <= nums[i] <= 1000
//    注意：本题与主站 724 题相同： https://leetcode-cn.com/problems/find-pivot-index/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/tvdfij
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func pivotIndex(_ nums: [Int]) -> Int {
        var sum = 0
        for item in nums {
            sum += item
        }
        var i = 0
        var left = 0
        var right = sum
        while i < nums.count {
            let num = nums[i]
            if left == right - num {
                return i
            }else {
                left += num
                right -= num
            }
            i += 1
        }
        return -1
    }
//    剑指 Offer II 011. 0 和 1 个数相同的子数组
//    给定一个二进制数组 nums , 找到含有相同数量的 0 和 1 的最长连续子数组，并返回该子数组的长度。
//    示例 1:
//    输入: nums = [0,1]
//    输出: 2
//    说明: [0, 1] 是具有相同数量 0 和 1 的最长连续子数组。
//    示例 2:
//    输入: nums = [0,1,0]
//    输出: 2
//    说明: [0, 1] (或 [1, 0]) 是具有相同数量 0 和 1 的最长连续子数组。
//    提示：
//    1 <= nums.length <= 105
//    nums[i] 不是 0 就是 1
//    注意：本题与主站 525 题相同： https://leetcode-cn.com/problems/contiguous-array/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/A1NYOS
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func findMaxLength(_ nums: [Int]) -> Int {
//        由于「0 和 1 的数量相同」等价于「1 的数量减去 0 的数量等于 0」，我们可以将数组中的 0 视作 −1，则原问题转换成「求最长的连续子数组，其元素和为 0」。
        var dic:[Int:Int] = [0:0]//前缀和：下标
        var sum = 0
        var len = 0
        var i = 0
        while i < nums.count {
            let item = nums[i] == 0 ? -1 : 1
            sum += item
            if dic.keys.contains(sum) {//sum-k
                len = max(len, (i + 1) - dic[sum]!)
            }
            if !dic.keys.contains(sum) {
                dic[sum] = i + 1//前缀和下标比原数组多1
            }
            i += 1
        }
       
        return len
    }
//    剑指 Offer II 010. 和为 k 的子数组
//    给定一个整数数组和一个整数 k ，请找到该数组中和为 k 的连续子数组的个数。
//    示例 1 :
//    输入:nums = [1,1,1], k = 2
//    输出: 2
//    解释: 此题 [1,1] 与 [1,1] 为两种不同的情况
//    示例 2 :
//    输入:nums = [1,2,3], k = 3
//    输出: 2
//    提示:
//    1 <= nums.length <= 2 * 104
//    -1000 <= nums[i] <= 1000
//    -107 <= k <= 107
//    注意：本题与主站 560 题相同： https://leetcode-cn.com/problems/subarray-sum-equals-k/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/QTMn0o
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        var dic:[Int:Int] = [0:1] //前缀和：出现次数
        var sum = 0
        var i = 0
        var count = 0
        while i < nums.count {
            sum += nums[i]
            if dic.keys.contains(sum - k) {
                count += dic[sum - k]! //前面出现了多少次(sum - k),就有多少个子数组和是k
            }
            dic[sum,default: 0] += 1
            i += 1
        }
        return count
    }
//    剑指 Offer II 089. 房屋偷盗
//    一个专业的小偷，计划偷窃沿街的房屋。每间房内都藏有一定的现金，影响小偷偷窃的唯一制约因素就是相邻的房屋装有相互连通的防盗系统，如果两间相邻的房屋在同一晚上被小偷闯入，系统会自动报警。
//    给定一个代表每个房屋存放金额的非负整数数组 nums ，请计算 不触动警报装置的情况下 ，一夜之内能够偷窃到的最高金额。
//    示例 1：
//    输入：nums = [1,2,3,1]
//    输出：4
//    解释：偷窃 1 号房屋 (金额 = 1) ，然后偷窃 3 号房屋 (金额 = 3)。
//         偷窃到的最高金额 = 1 + 3 = 4 。
//    示例 2：
//    输入：nums = [2,7,9,3,1]
//    输出：12
//    解释：偷窃 1 号房屋 (金额 = 2), 偷窃 3 号房屋 (金额 = 9)，接着偷窃 5 号房屋 (金额 = 1)。
//         偷窃到的最高金额 = 2 + 9 + 1 = 12 。
//    提示：
//    1 <= nums.length <= 100
//    0 <= nums[i] <= 400
//    注意：本题与主站 198 题相同： https://leetcode-cn.com/problems/house-robber/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/Gu0c2T
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func rob(_ nums: [Int]) -> Int {
        //dp[i] = max(dp[i-1],dp[i-2] + nums[i])
        //dp[0] = nums[i]
        //dp[1] = max(nums[0],nums[1])
        guard nums.count > 1 else { return nums[0] }
        var dp0 = nums[0]
        var dp1 = max(nums[0], nums[1])
        var i = 2
        while i < nums.count {
            let dp2 = max(dp1,dp0 + nums[i])
            dp0 = dp1
            dp1 = dp2
            i += 1
        }
        return dp1
    }
//    剑指 Offer II 009. 乘积小于 K 的子数组
//    给定一个正整数数组 nums和整数 k ，请找出该数组内乘积小于 k 的连续的子数组的个数。
//    示例 1:
//    输入: nums = [10,5,2,6], k = 100
//    输出: 8
//    解释: 8 个乘积小于 100 的子数组分别为: [10], [5], [2], [6], [10,5], [5,2], [2,6], [5,2,6]。
//    需要注意的是 [10,5,2] 并不是乘积小于100的子数组。
//    示例 2:
//    输入: nums = [1,2,3], k = 0
//    输出: 0
//    提示:
//    1 <= nums.length <= 3 * 104
//    1 <= nums[i] <= 1000
//    0 <= k <= 106
//    注意：本题与主站 713 题相同：https://leetcode-cn.com/problems/subarray-product-less-than-k/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/ZVAVXX
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func numSubarrayProductLessThanK(_ nums: [Int], _ k: Int) -> Int {
        var left = 0
        var right = 0
        var ji = 1
        var count = 0
//        10,5,2,6
        while left < nums.count {
            while right < nums.count && ji * nums[right] < k {
                ji *= nums[right]
                right += 1
            }
            if right > left {
                count += (right - left)
                ji /= nums[left]
                left += 1
            }else {
                left += 1
                right += 1
            }
        }
        return count
        
        
        //溢出了
        //10 50 100 600  array[i] = array[i - 1] * nums[i]
        // i..j = array[j] / array[i - 1]
        // i = 0, array[j]
//        var sum = 1
//        var i = 0
//        var array: [Int] = []
//        while i < nums.count {
//            sum *= nums[i]
//            array.append(sum)
//            i += 1
//        }
//        var count = 0
//        i = 0
//        while i < nums.count {
//            var left = i
//            var right = array.count - 1
//            while left <= right {
//                let j = left + (right - left) / 2
//                let IToJ = i == 0 ? array[j] : (array[j]/array[i - 1])//子数组i...j的乘积
//                if IToJ >= k {
//                    right = j - 1
//                }else {
//                    left = j + 1
//                }
//            }
//            if right >= 0  {
//                count += (right - i + 1)
//            }
//            i += 1
//        }
//        return count
    }
    
//    剑指 Offer II 088. 爬楼梯的最少成本
//    数组的每个下标作为一个阶梯，第 i 个阶梯对应着一个非负数的体力花费值 cost[i]（下标从 0 开始）。
//    每当爬上一个阶梯都要花费对应的体力值，一旦支付了相应的体力值，就可以选择向上爬一个阶梯或者爬两个阶梯。
//    请找出达到楼层顶部的最低花费。在开始时，你可以选择从下标为 0 或 1 的元素作为初始阶梯。
//    示例 1：
//    输入：cost = [10, 15, 20]
//    输出：15
//    解释：最低花费是从 cost[1] 开始，然后走两步即可到阶梯顶，一共花费 15 。
//     示例 2：
//    输入：cost = [1, 100, 1, 1, 1, 100, 1, 1, 100, 1]
//    输出：6
//    解释：最低花费方式是从 cost[0] 开始，逐个经过那些 1 ，跳过 cost[3] ，一共花费 6 。
//    提示：
//    2 <= cost.length <= 1000
//    0 <= cost[i] <= 999
//    注意：本题与主站 746 题相同： https://leetcode-cn.com/problems/min-cost-climbing-stairs/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/GzCJIP
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func minCostClimbingStairs(_ cost: [Int]) -> Int {
        //dp[n] 到达下标n需要的最少成本
        //dp[n] = min(dp[n-1] + cost[n-1],dp[n-2] + cost[n-2])
        //base case dp[0] = 0 dp[1] = 0
        var dp0 = 0
        var dp1 = 0
        var i = 2
        while i <= cost.count {
            let dp2 = min(dp0 + cost[i - 2], dp1 + cost[i - 1])
            dp0 = dp1
            dp1 = dp2
            i += 1
        }
        return dp1
    }
//    剑指 Offer II 008. 和大于等于 target 的最短子数组
//    给定一个含有 n 个正整数的数组和一个正整数 target 。
//    找出该数组中满足其和 ≥ target 的长度最小的 连续子数组 [numsl, numsl+1, ..., numsr-1, numsr] ，并返回其长度。如果不存在符合条件的子数组，返回 0 。
//    示例 1：
//    输入：target = 7, nums = [2,3,1,2,4,3]
//    输出：2
//    解释：子数组 [4,3] 是该条件下的长度最小的子数组。
//    示例 2：
//    输入：target = 4, nums = [1,4,4]
//    输出：1
//    示例 3：
//    输入：target = 11, nums = [1,1,1,1,1,1,1,1]
//    输出：0
//    提示：
//    1 <= target <= 109
//    1 <= nums.length <= 105
//    1 <= nums[i] <= 105
//    进阶：
//    如果你已经实现 O(n) 时间复杂度的解法, 请尝试设计一个 O(n log(n)) 时间复杂度的解法。
//    注意：本题与主站 209 题相同：https://leetcode-cn.com/problems/minimum-size-subarray-sum/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/2VG8Kg
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
        //O(n log(n))的思路是 ：前缀和，然后二分搜索每个下标开始的满足target的右边界
        var sum = 0
        var left = 0
        var right = 0
        var len = Int.max
        while right < nums.count {
            let rNum = nums[right]
            sum += rNum
            
            while sum - nums[left] >= target {
                sum -= nums[left]
                left += 1
            }
            if sum >= target {
                len = min(len, right - left + 1)
            }
            right += 1
        }
        return len == Int.max ? 0 : len
    }
//    剑指 Offer II 087. 复原 IP
//    给定一个只包含数字的字符串 s ，用以表示一个 IP 地址，返回所有可能从 s 获得的 有效 IP 地址 。你可以按任何顺序返回答案。
//    有效 IP 地址 正好由四个整数（每个整数位于 0 到 255 之间组成，且不能含有前导 0），整数之间用 '.' 分隔。
//    例如："0.1.2.201" 和 "192.168.1.1" 是 有效 IP 地址，但是 "0.011.255.245"、"192.168.1.312" 和 "192.168@1.1" 是 无效 IP 地址。
//    示例 1：
//    输入：s = "25525511135"
//    输出：["255.255.11.135","255.255.111.35"]
//    示例 2：
//    输入：s = "0000"
//    输出：["0.0.0.0"]
//    示例 3：
//    输入：s = "1111"
//    输出：["1.1.1.1"]
//    示例 4：
//    输入：s = "010010"
//    输出：["0.10.0.10","0.100.1.0"]
//    示例 5：
//    输入：s = "10203040"
//    输出：["10.20.30.40","102.0.30.40","10.203.0.40"]
//    提示：
//    0 <= s.length <= 3000
//    s 仅由数字组成
//    注意：本题与主站 93 题相同：https://leetcode-cn.com/problems/restore-ip-addresses/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/0on3uN
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func restoreIpAddresses(_ s: String) -> [String] {
        let ss = Array(s)
        var path: [Int] = []
        var tempNum: Int = 0
        var res:[String] = []
        restoreIpAddressesBacktrace(ss, 0, &path, &tempNum, &res)
        return res
    }
    
    class func restoreIpAddressesBacktrace(_ s:[Character],_ index: Int,_ path: inout [Int],_ tempNum: inout Int,_ res: inout [String]) {
        if index == s.count {
            if path.count == 4 {
                res.append("\(path[0]).\(path[1]).\(path[2]).\(path[3])")
            }
            return
        }
        if path.count == 4 {
            return
        }
        
        let ch = s[index]
        if ch == "0" && tempNum == 0 {//只能单独成一组
            path.append(0)
            restoreIpAddressesBacktrace(s, index + 1, &path, &tempNum, &res)
            path.removeLast()
        }else {
            //加上本次的
            let num = ch.wholeNumberValue!
            let temp = tempNum
            tempNum = tempNum * 10 + num
            if tempNum <= 255 {
                restoreIpAddressesBacktrace(s, index + 1, &path, &tempNum, &res)
                
                path.append(tempNum)
                tempNum = 0
                restoreIpAddressesBacktrace(s, index + 1, &path, &tempNum, &res)
                path.removeLast()
            }
            tempNum = temp
        }
    }
    
//    剑指 Offer II 086. 分割回文子字符串
//    给定一个字符串 s ，请将 s 分割成一些子串，使每个子串都是 回文串 ，返回 s 所有可能的分割方案。
//    回文串 是正着读和反着读都一样的字符串。
//    示例 1：
//    输入：s = "google"
//    输出：[["g","o","o","g","l","e"],["g","oo","g","l","e"],["goog","l","e"]]
//    示例 2：
//    输入：s = "aab"
//    输出：[["a","a","b"],["aa","b"]]
//    示例 3：
//    输入：s = "a"
//    输出：[["a"]]
//    提示：
//    1 <= s.length <= 16
//    s 仅由小写英文字母组成
//    注意：本题与主站 131 题相同： https://leetcode-cn.com/problems/palindrome-partitioning/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/M99OJA
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func partition(_ s: String) -> [[String]] {
        //思路：先收集回文位置，再回溯选择
        let ss = Array(s)
        var huiwens:[Int:[Int]] = [:]//收集所有回文位置
        var i = 0
        while i < ss.count {
            partitionLen(ss, i, i, &huiwens)
            partitionLen(ss, i, i + 1, &huiwens)
            i += 1
        }
        var path: [String] = []
        var res: [[String]] = []
        partitionBacktrace(ss, 0, huiwens, &path, &res)
        return res
    }
    
    class func partitionBacktrace(_ ss: [Character],_ index: Int,_ huiwens:[Int:[Int]],_ path: inout [String] ,_ res: inout [[String]]) {
        if index == ss.count {
            res.append(path)
            return
        }
        
        //选回文或者不选
        if let arr = huiwens[index] {
            for right in arr {
                path.append(String(ss[index...right]))
                partitionBacktrace(ss, right + 1, huiwens, &path, &res)
                path.removeLast()
            }
        }
        
        path.append(String(ss[index]))
        partitionBacktrace(ss, index + 1, huiwens, &path, &res)
        path.removeLast()
    }
    
    class func partitionLen(_ s:[Character],_ left: Int,_ right: Int,_ huiwens: inout [Int:[Int]]) {
        var l = left
        var r = right
        if l >= 0 && r < s.count && s[l] == s[r] {
            while l >= 0 && r < s.count && s[l] == s[r] {
                if r > l {
                    var arr = huiwens[l,default: []]
                    arr.append(r)
                    huiwens[l] = arr
                }
                l -= 1
                r += 1
            }
        }
    }
    
//    剑指 Offer II 007. 数组中和为 0 的三个数
//    给定一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a ，b ，c ，使得 a + b + c = 0 ？请找出所有和为 0 且 不重复 的三元组。
//    示例 1：
//    输入：nums = [-1,0,1,2,-1,-4]
//    输出：[[-1,-1,2],[-1,0,1]]
//    示例 2：
//    输入：nums = []
//    输出：[]
//    示例 3：
//    输入：nums = [0]
//    输出：[]
//    提示：
//    0 <= nums.length <= 3000
//    -105 <= nums[i] <= 105
//    注意：本题与主站 15 题相同：https://leetcode-cn.com/problems/3sum/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/1fGaJU
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func threeSum123(_ nums: [Int]) -> [[Int]] {
        guard nums.count > 2 else {return []}
        let array = nums.sorted { a, b in
            a < b
        }
        var res: Set<[Int]> = []
        var i = 0
        while i < array.count {
            let a = array[i]
            var left = i + 1
            var right = array.count - 1
            while left < right {
                let num = array[left] + array[right]
                if num == -a {
                    res.insert([a,array[left],array[right]])
                    left += 1
                    right -= 1
                }else if num < -a {
                    left += 1
                }else {
                    right -= 1
                }
            }
            i += 1
        }
        return Array(res)
    }
//    剑指 Offer II 085. 生成匹配的括号
//    正整数 n 代表生成括号的对数，请设计一个函数，用于能够生成所有可能的并且 有效的 括号组合。
//    示例 1：
//    输入：n = 3
//    输出：["((()))","(()())","(())()","()(())","()()()"]
//    示例 2：
//    输入：n = 1
//    输出：["()"]
//    提示：
//    1 <= n <= 8
//    注意：本题与主站 22 题相同： https://leetcode-cn.com/problems/generate-parentheses/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/IDBivT
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func generateParenthesis(_ n: Int) -> [String] {
        var left = n
        var right = n
        var path: [Character] = []
        var res: [String] = []
        generateParenthesisBacktrace(&left, &right, &path, &res)
        return res
    }
    
    class func generateParenthesisBacktrace(_ left: inout Int,_ right: inout Int,_ path: inout [Character],_ res: inout [String]) {
        if left == 0 && right == 0 {
            res.append(String(path))
            return
        }
        if right == 0 {
            return
        }
        if left == right {
            left -= 1
            path.append("(")
            generateParenthesisBacktrace(&left, &right, &path, &res)
            left += 1
            path.removeLast()
        }else {
            if left > 0 {
                left -= 1
                path.append("(")
                generateParenthesisBacktrace(&left, &right, &path, &res)
                left += 1
                path.removeLast()
            }
            
            if right > 0 {
                right -= 1
                path.append(")")
                generateParenthesisBacktrace(&left, &right, &path, &res)
                right += 1
                path.removeLast()
            }
        }
    }
    
//    剑指 Offer II 006. 排序数组中两个数字之和
//    给定一个已按照 升序排列  的整数数组 numbers ，请你从数组中找出两个数满足相加之和等于目标数 target 。
//    函数应该以长度为 2 的整数数组的形式返回这两个数的下标值。numbers 的下标 从 0 开始计数 ，所以答案数组应当满足 0 <= answer[0] < answer[1] < numbers.length 。
//    假设数组中存在且只存在一对符合条件的数字，同时一个数字不能使用两次。
//    示例 1：
//    输入：numbers = [1,2,4,6,10], target = 8
//    输出：[1,3]
//    解释：2 与 6 之和等于目标数 8 。因此 index1 = 1, index2 = 3 。
//    示例 2：
//    输入：numbers = [2,3,4], target = 6
//    输出：[0,2]
//    示例 3：
//    输入：numbers = [-1,0], target = -1
//    输出：[0,1]
//    提示：
//    2 <= numbers.length <= 3 * 104
//    -1000 <= numbers[i] <= 1000
//    numbers 按 递增顺序 排列
//    -1000 <= target <= 1000
//    仅存在一个有效答案
//    注意：本题与主站 167 题相似（下标起点不同）：https://leetcode-cn.com/problems/two-sum-ii-input-array-is-sorted/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/kLl5u1
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func twoSum11(_ numbers: [Int], _ target: Int) -> [Int] {
        var left = 0
        var right = numbers.count - 1
        while left < right {
            let num = numbers[left] + numbers[right]
            if num == target {
                return [left,right]
            }else if num < target {
                left += 1
            }else {
                right -= 1
            }
        }
        return []
    }
//    剑指 Offer II 005. 单词长度的最大乘积
//    给定一个字符串数组 words，请计算当两个字符串 words[i] 和 words[j] 不包含相同字符时，它们长度的乘积的最大值。假设字符串中只包含英语的小写字母。如果没有不包含相同字符的一对字符串，返回 0。
//    示例 1:
//    输入: words = ["abcw","baz","foo","bar","fxyz","abcdef"]
//    输出: 16
//    解释: 这两个单词为 "abcw", "fxyz"。它们不包含相同字符，且长度的乘积最大。
//    示例 2:
//    输入: words = ["a","ab","abc","d","cd","bcd","abcd"]
//    输出: 4
//    解释: 这两个单词为 "ab", "cd"。
//    示例 3:
//    输入: words = ["a","aa","aaa","aaaa"]
//    输出: 0
//    解释: 不存在这样的两个单词。
//    提示：
//    2 <= words.length <= 1000
//    1 <= words[i].length <= 1000
//    words[i] 仅包含小写字母
//    注意：本题与主站 318 题相同：https://leetcode-cn.com/problems/maximum-product-of-word-lengths/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/aseY1I
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func maxProduct(_ words: [String]) -> Int {
        //计算每个单词的掩码
        var wordDic: [Int:Int] = [:] //掩码：长度
        for item in words {
            let array = Array(item)
            var mask = 0
            let base = Character("a").asciiValue!
            for ch in array {
                mask |= (1 << (ch.asciiValue! - base))
            }
            // 掩码相同的，只保留长度最长的字符串
            if let workLen = wordDic[mask] {
                if workLen < array.count {
                    wordDic[mask] = array.count
                }
            }else {
                wordDic[mask] = array.count
            }
        }
        var res = 0
        for (mask1,len1) in wordDic {
            for (mask2,len2) in wordDic {
                if mask1 & mask2 == 0 {//核心： 没有相同字符的
                    res = max(res, len1 * len2)
                }
            }
        }
        return res
    }
    
//    剑指 Offer II 084. 含有重复元素集合的全排列
//    给定一个可包含重复数字的整数集合 nums ，按任意顺序 返回它所有不重复的全排列。
//    示例 1：
//    输入：nums = [1,1,2]
//    输出：
//    [[1,1,2],
//     [1,2,1],
//     [2,1,1]]
//    示例 2：
//    输入：nums = [1,2,3]
//    输出：[[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
//    提示：
//    1 <= nums.length <= 8
//    -10 <= nums[i] <= 10
//    注意：本题与主站 47 题相同： https://leetcode-cn.com/problems/permutations-ii/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/7p8L0Z
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func permuteUnique(_ nums: [Int]) -> [[Int]] {
        //考虑同层相同元素剪枝
        let array = nums.sorted { a, b in
            a < b
        }
        var res:[[Int]] = []
        var path: [Int] = []
        var choosed: [Bool] = Array(repeating: false, count: nums.count)
        permuteUniqueBacktrace(array, &choosed, &path, &res)
        return res
    }
    
    class func permuteUniqueBacktrace(_ nums: [Int],_ choosed: inout [Bool],_ path: inout [Int],_ res: inout [[Int]]) {
        if path.count == nums.count {
            res.append(path)
            return
        }
        var i = 0
        var cur: Int?
        while i < nums.count {
            if choosed[i] {
                i += 1
                continue
            }
            
            let num = nums[i]
            if cur == nil {
                cur = num
            }else {
                if cur! == num {
                    i += 1
                    continue//同层剪枝
                }else {
                    cur = num
                }
            }
            
            choosed[i] = true
            path.append(num)
            permuteUniqueBacktrace(nums, &choosed, &path, &res)
            
            choosed[i] = false
            path.removeLast()
            
            i += 1
        }
    }
//    剑指 Offer II 083. 没有重复元素集合的全排列
//    给定一个不含重复数字的整数数组 nums ，返回其 所有可能的全排列 。可以 按任意顺序 返回答案。
//    示例 1：
//    输入：nums = [1,2,3]
//    输出：[[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
//    示例 2：
//    输入：nums = [0,1]
//    输出：[[0,1],[1,0]]
//    示例 3：
//    输入：nums = [1]
//    输出：[[1]]
//    提示：
//    1 <= nums.length <= 6
//    -10 <= nums[i] <= 10
//    nums 中的所有整数 互不相同
//    注意：本题与主站 46 题相同：https://leetcode-cn.com/problems/permutations/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/VvJkup
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func permute(_ nums: [Int]) -> [[Int]] {
        var res:[[Int]] = []
        var path: [Int] = []
        var choosed: [Bool] = Array(repeating: false, count: nums.count)
        permuteBacktrace(nums, &choosed, &path, &res)
        return res
    }
    
    class func permuteBacktrace(_ nums: [Int],_ choosed: inout [Bool],_ path: inout [Int],_ res: inout [[Int]])  {
        if path.count == nums.count {
            res.append(path)
            return
        }
        
        var i = 0
        while i < nums.count {
            if !choosed[i] {
                choosed[i] = true
                path.append(nums[i])
                permuteBacktrace(nums, &choosed, &path, &res)
                choosed[i] = false
                path.removeLast()
            }
            i += 1
        }
        
    }
//    剑指 Offer II 004. 只出现一次的数字
//    给你一个整数数组 nums ，除某个元素仅出现 一次 外，其余每个元素都恰出现 三次 。请你找出并返回那个只出现了一次的元素。
//    示例 1：
//    输入：nums = [2,2,3,2]
//    输出：3
//    示例 2：
//    输入：nums = [0,1,0,1,0,1,100]
//    输出：100
//    提示：
//    1 <= nums.length <= 3 * 104
//    -231 <= nums[i] <= 231 - 1
//    nums 中，除某个元素仅出现 一次 外，其余每个元素都恰出现 三次
//    进阶：你的算法应该具有线性时间复杂度。 你可以不使用额外空间来实现吗？
//    注意：本题与主站 137 题相同：https://leetcode-cn.com/problems/single-number-ii/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/WGki4K
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func singleNumbers2(_ nums: [Int]) -> Int {
//        01 10 11
        //考虑每一个二进制位
        var shu:Int32 = 0
        var i = 0
        while i < 32 {
            var total = 0
            for num in nums {
                total += (num >> i) & 1
            }
            
            if total % 3 != 0 {
                shu |= (1 << i)
            }
            i += 1
        }

        return Int(shu)
    }
    
//    剑指 Offer II 082. 含有重复元素集合的组合
//    给定一个可能有重复数字的整数数组 candidates 和一个目标数 target ，找出 candidates 中所有可以使数字和为 target 的组合。
//    candidates 中的每个数字在每个组合中只能使用一次，解集不能包含重复的组合。
//    示例 1:
//    输入: candidates = [10,1,2,7,6,1,5], target = 8,
//    输出:
//    [
//    [1,1,6],
//    [1,2,5],
//    [1,7],
//    [2,6]
//    ]
//    示例 2:
//    输入: candidates = [2,5,2,1,2], target = 5,
//    输出:
//    [
//    [1,2,2],
//    [5]
//    ]
//    提示:
//    1 <= candidates.length <= 100
//    1 <= candidates[i] <= 50
//    1 <= target <= 30
//    注意：本题与主站 40 题相同： https://leetcode-cn.com/problems/combination-sum-ii/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/4sjJUc
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        // 回溯
        let array = candidates.sorted { a, b in
            a < b
        }
        
        var res: [[Int]] = []
        var path: [Int] = []
        combinationSum2Backtrace(array, &res, &path, 0,target)
        return res
        
        //超时
        //dp[i][j] = 当容量为j时，只使用前i件时，有多少种方式
//        dp[i][j] = dp[i - 1][j] + dp[i - 1][j - num]
//        var dp: [[[[Int]]]] = Array(repeating: Array(repeating: [], count: target + 1), count: candidates.count + 1)
//        dp[0][0] = [[]]
//        // base case
//        // dp[0][j] = 0
//        // dp[i][0] = 1
//
//        var i = 1
//        while i <= candidates.count {
//            let num = candidates[i - 1]
//            var j = 0
//            while j <= target {
//                if j == 0 {
//                    dp[i][j] = [[]]
//                }else {
//                    if j - num < 0 {
//                        dp[i][j] = dp[i - 1][j]
//                    }else {
//                        var array = dp[i - 1][j - num]
//                        var k = 0
//                        while k < array.count {
//                            var arr = array[k]
//                            arr.append(num)
//                            array[k] = arr
//                            k += 1
//                        }
//                        dp[i][j] = dp[i - 1][j] + array
//                    }
//                }
//                j += 1
//            }
//            i += 1
//        }
//        var set: Set<[Int]> = []
//        let res = dp[candidates.count][target]
//        for var arr in res {
//            arr.sort { a, b in
//                a < b
//            }
//            set.insert(arr)
//        }
//        return Array(set)
    }
    
    class func combinationSum2Backtrace(_ array: [Int],_ res: inout [[Int]],_ path: inout [Int],_ begin: Int,_ rest: Int) {
        if rest == 0 {
            //找到一个结果
            res.append(path)
            return
        }
        var i = begin
        while i < array.count {
            let num = array[i]
            if num > rest {
                break
            }
            if i > begin && num == array[i - 1] {//核心 剪枝  去掉同层重复
                i += 1
                continue
            }
            path.append(num)
            combinationSum2Backtrace(array, &res, &path, i + 1, rest - num)
            path.removeLast()
            i += 1
        }
    }
    
//    剑指 Offer II 002. 二进制加法
//    给定两个 01 字符串 a 和 b ，请计算它们的和，并以二进制字符串的形式输出。
//    输入为 非空 字符串且只包含数字 1 和 0。
//    示例 1:
//    输入: a = "11", b = "10"
//    输出: "101"
//    示例 2:
//    输入: a = "1010", b = "1011"
//    输出: "10101"
//    提示：
//    每个字符串仅由字符 '0' 或 '1' 组成。
//    1 <= a.length, b.length <= 10^4
//    字符串如果不是 "0" ，就都不含前导零。
//    注意：本题与主站 67 题相同：https://leetcode-cn.com/problems/add-binary/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/JFETK5
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func addBinary(_ a: String, _ b: String) -> String {
        let aa = Array(a)
        let bb = Array(b)
        var res: [Character] = []
        var jin = 0
        var p1 = aa.count - 1
        var p2 = bb.count - 1
        while p1 >= 0 || p2 >= 0 {
            if p1 == -1 {
                var num = bb[p2].wholeNumberValue! + jin
                jin = 0
                if num == 2 {
                    num = 0
                    jin = 1
                }
                res.append(num == 0 ? "0" : "1")
                p2 -= 1
            }else if p2 == -1 {
                var num = aa[p1].wholeNumberValue! + jin
                jin = 0
                if num == 2 {
                    num = 0
                    jin = 1
                }
                res.append(num == 0 ? "0" : "1")
                p1 -= 1
            }else {
                var num = aa[p1].wholeNumberValue! + bb[p2].wholeNumberValue! + jin
                jin = 0
                if num >= 2 {
                    num -= 2
                    jin = 1
                }
                res.append(num == 0 ? "0" : "1")
                p1 -= 1
                p2 -= 1
            }
        }
        if jin > 0 {
            res.append("1")
        }
        return String(res.reversed())
    }
//    剑指 Offer II 003. 前 n 个数字二进制中 1 的个数
//    给定一个非负整数 n ，请计算 0 到 n 之间的每个数字的二进制表示中 1 的个数，并输出一个数组。
//    示例 1:
//    输入: n = 2
//    输出: [0,1,1]
//    解释:
//    0 --> 0
//    1 --> 1
//    2 --> 10
//    示例 2:
//    输入: n = 5
//    输出: [0,1,1,2,1,2]
//    解释:
//    0 --> 0
//    1 --> 1
//    2 --> 10
//    3 --> 11
//    4 --> 100
//    5 --> 101
//    说明 :
//    0 <= n <= 105
//    进阶:
//    给出时间复杂度为 O(n*sizeof(integer)) 的解答非常容易。但你可以在线性时间 O(n) 内用一趟扫描做到吗？
//    要求算法的空间复杂度为 O(n) 。
//    你能进一步完善解法吗？要求在C++或任何其他语言中不使用任何内置函数（如 C++ 中的 __builtin_popcount ）来执行此操作。
//    注意：本题与主站 338 题相同：https://leetcode-cn.com/problems/counting-bits/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/w3tCBm
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func countBits(_ n: Int) -> [Int] {
        var array: [Int] = []
        for var num in 0...n {
            var count = 0
            while num != 0 {
                num = num & (num - 1)
                count += 1
            }
            array.append(count)
        }
        return array
    }
    
//    剑指 Offer II 081. 允许重复选择元素的组合
//    给定一个无重复元素的正整数数组 candidates 和一个正整数 target ，找出 candidates 中所有可以使数字和为目标数 target 的唯一组合。
//    candidates 中的数字可以无限制重复被选取。如果至少一个所选数字数量不同，则两种组合是唯一的。
//    对于给定的输入，保证和为 target 的唯一组合数少于 150 个。
//    示例 1：
//    输入: candidates = [2,3,6,7], target = 7
//    输出: [[7],[2,2,3]]
//    示例 2：
//    输入: candidates = [2,3,5], target = 8
//    输出: [[2,2,2,2],[2,3,3],[3,5]]
//    示例 3：
//    输入: candidates = [2], target = 1
//    输出: []
//    示例 4：
//    输入: candidates = [1], target = 1
//    输出: [[1]]
//    示例 5：
//    输入: candidates = [1], target = 2
//    输出: [[1,1]]
//    提示：
//    1 <= candidates.length <= 30
//    1 <= candidates[i] <= 200
//    candidate 中的每个元素都是独一无二的。
//    1 <= target <= 500
//    注意：本题与主站 39 题相同： https://leetcode-cn.com/problems/combination-sum/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/Ygoe9J
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        
        //转化为0-1背包问题
        
        //dp[i][j] = 当容量为j时，只使用前i件时，有多少种方式
        //不放入i  dp[i][j] = dp[i - 1][j]
        //放入i   dp[i][j] = dp[i - 1][j] + dp[i][j - num]
        var dp: [[[[Int]]]] = Array(repeating: Array(repeating: [], count: target + 1), count: candidates.count + 1)
        // base case
        // dp[0][j] = 0
        // dp[i][0] = 1
        
        var i = 1
        while i <= candidates.count {
            let num = candidates[i - 1]
            var j = 0
            while j <= target {
                if j == 0 {
                    dp[i][j] = [[]]
                }else {
                    if j - num < 0 {
                        dp[i][j] = dp[i - 1][j]
                    }else {
                        var array = dp[i][j - num]
                        var k = 0
                        while k < array.count {
                            var arr = array[k]
                            arr.append(num)
                            array[k] = arr
                            k += 1
                        }
                        dp[i][j] = dp[i - 1][j] + array
                    }
                }
                j += 1
            }
            i += 1
        }
        return dp[candidates.count][target]
    }
//    剑指 Offer II 001. 整数除法
//    给定两个整数 a 和 b ，求它们的除法的商 a/b ，要求不得使用乘号 '*'、除号 '/' 以及求余符号 '%' 。
//    注意：
//    整数除法的结果应当截去（truncate）其小数部分，例如：truncate(8.345) = 8 以及 truncate(-2.7335) = -2
//    假设我们的环境只能存储 32 位有符号整数，其数值范围是 [−231, 231−1]。本题中，如果除法结果溢出，则返回 231 − 1
//    示例 1：
//    输入：a = 15, b = 2
//    输出：7
//    解释：15/2 = truncate(7.5) = 7
//    示例 2：
//    输入：a = 7, b = -3
//    输出：-2
//    解释：7/-3 = truncate(-2.33333..) = -2
//    示例 3：
//    输入：a = 0, b = 1
//    输出：0
//    示例 4：
//    输入：a = 1, b = 1
//    输出：1
//    提示:
//    -231 <= a, b <= 231 - 1
//    b != 0
//    注意：本题与主站 29 题相同：https://leetcode-cn.com/problems/divide-two-integers/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/xoh6Oh
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func divide(_ a: Int, _ b: Int) -> Int {
//        -2147483648
//        -1
        if a == -2147483648 && b == -1 {//溢出问题
            return 2147483647
        }
        
        var count = 0
        let f = ((a^b) < 0)
//        -2147483648
//        1
        
        var aa = fabs(Double(a))
        let bb = fabs(Double(b))
        
        if bb == 1 {//超时问题
            return f ? -Int(aa) : Int(aa)
        }
        
        while aa >= bb {
            aa -= bb
            count += 1
        }
        return f ? -count : count
    }
    
//    67. 把字符串转换成整数
//    写一个函数 StrToInt，实现把字符串转换成整数这个功能。不能使用 atoi 或者其他类似的库函数。
//    首先，该函数会根据需要丢弃无用的开头空格字符，直到寻找到第一个非空格的字符为止。
//    当我们寻找到的第一个非空字符为正或者负号时，则将该符号与之后面尽可能多的连续数字组合起来，作为该整数的正负号；假如第一个非空字符是数字，则直接将其与之后连续的数字字符组合起来，形成整数。
//    该字符串除了有效的整数部分之后也可能会存在多余的字符，这些字符可以被忽略，它们对于函数不应该造成影响。
//    注意：假如该字符串中的第一个非空格字符不是一个有效整数字符、字符串为空或字符串仅包含空白字符时，则你的函数不需要进行转换。
//    在任何情况下，若函数不能进行有效的转换时，请返回 0。
//    说明：
//    假设我们的环境只能存储 32 位大小的有符号整数，那么其数值范围为 [−231,  231 − 1]。如果数值超过这个范围，请返回  INT_MAX (231 − 1) 或 INT_MIN (−231) 。
//    示例 1:
//    输入: "42"
//    输出: 42
//    示例 2:
//    输入: "   -42"
//    输出: -42
//    解释: 第一个非空白字符为 '-', 它是一个负号。
//         我们尽可能将负号与后面所有连续出现的数字组合起来，最后得到 -42 。
//    示例 3
//    输入: "4193 with words"
//    输出: 4193
//    解释: 转换截止于数字 '3' ，因为它的下一个字符不为数字。
//    示例 4
//    输入: "words and 987"
//    输出: 0
//    解释: 第一个非空字符是 'w', 但它不是数字或正、负号。
//         因此无法执行有效的转换。
//    示例 5:
//    输入: "-91283472332"
//    输出: -2147483648
//    解释: 数字 "-91283472332" 超过 32 位有符号整数范围。
//         因此返回 INT_MIN (−231) 。
//    注意：本题与主站 8 题相同：https://leetcode-cn.com/problems/string-to-integer-atoi/
//    链接：https://leetcode-cn.com/problems/ba-zi-fu-chuan-zhuan-huan-cheng-zheng-shu-lcof
    class func strToInt(_ str: String) -> Int {
        let maxVal = 2147483647
        let array = Array(str)
        var result = [Character]()
        strToInt(array, 0, &result)
        if result.count > 0 {
            var index = 0
            var fu = false
            while index < result.count {
                if result[index] == "+" || result[index] == "0" {
                    index += 1
                }else if result[index] == "-" {
                    index += 1
                    fu = true
                }else {
                    break
                }
            }
            
            var i = result.count - 1
            var count = 1
            var num = 0
            while i >= index {
                let ch = result[i]
                if !fu && num + Int(String(ch))! * count > maxVal {
                    return Int(maxVal)
                }
                if fu && num + Int(String(ch))! * count - 1 > maxVal {
                    return -Int(maxVal)-1
                }
                num += Int(String(ch))! * count
                
                if count * 10 > maxVal {
                    if i > index {
                        return fu ? -Int(maxVal)-1 : Int(maxVal)
                    }
                    break
                }
                count *= 10
                i -= 1
            }
            
            return fu ? -num : num
        }
        return 0
    }
    class func strToInt(_ array: [Character],_ index: Int,_ result: inout [Character]) {
        if index == array.count {
            return
        }
        let ch = array[index]
        if result.count > 0 {
            if let _ = Int(String(ch)) {
                result.append(ch)
                strToInt(array, index + 1, &result)
            }
            return
        }else {
            if ch == "+" || ch == "-" || Int(String(ch)) != nil {
                result.append(ch)
                strToInt(array, index + 1, &result)
            }else if ch == " " {
                strToInt(array, index + 1, &result)
            }
            return
        }
    }
    
//    66. 构建乘积数组
//    给定一个数组 A[0,1,…,n-1]，请构建一个数组 B[0,1,…,n-1]，其中 B[i] 的值是数组 A 中除了下标 i 以外的元素的积, 即 B[i]=A[0]×A[1]×…×A[i-1]×A[i+1]×…×A[n-1]。不能使用除法。
//    示例:
//    输入: [1,2,3,4,5]
//    输出: [120,60,40,30,24]
//    提示：
//    所有元素乘积之和不会溢出 32 位整数
//    a.length <= 100000
//    链接：https://leetcode-cn.com/problems/gou-jian-cheng-ji-shu-zu-lcof
    class func constructArr(_ a: [Int]) -> [Int] {
        guard a.count > 1 else {
            return []
        }
        var dic: [String : Int] = [:]
        var i = 0
        var sum = 0
        while i <= a.count - 1 {
            if i == 0 {
                sum = a[i]
                dic["0_0"] = sum
            }else {
                sum *= a[i]
                dic["0_\(i)"] = sum
            }
            i += 1
        }
        i -= 1
        dic["\(i)_\(i)"] = a[i]
        var resultArray = [Int]()
        while i >= 0 {
            var leftSum = 1
            if i - 1 >= 0 {
                leftSum = dic["0_\(i - 1)"]!
            }
            var rightSum = 1
            if i < a.count - 1 {
                let key = "\(i + 1)_\(a.count - 1)"
                rightSum = dic[key]!
                dic["\(i)_\(a.count - 1)"] = rightSum * a[i]
            }
            resultArray.append(leftSum * rightSum)
            i -= 1
        }
        
        return resultArray.reversed()
    }
    
//    65. 不用加减乘除做加法
//    写一个函数，求两个整数之和，要求在函数体内不得使用 “+”、“-”、“*”、“/” 四则运算符号。
//    示例:
//    输入: a = 1, b = 1
//    输出: 2
//    提示：
//    a, b 均可能是负数或 0
//    结果不会溢出 32 位整数
//    链接：https://leetcode-cn.com/problems/bu-yong-jia-jian-cheng-chu-zuo-jia-fa-lcof
    class func add(_ a: Int, _ b: Int) -> Int {
        //无进位n = a ^ b
        //进位c = a & b << 1
        //和s = a + b ===> s = n + c
//        public int add(int a, int b) {
//                while(b != 0) { // 当进位为 0 时跳出
//                    int c = (a & b) << 1;  // c = 进位
//                    a ^= b; // a = 非进位和
//                    b = c; // b = 进位
//                }
//                return a;
//            }
        var aa = a
        var bb = b
        while bb != 0 {
            let c = (aa & bb) << 1
            aa ^= bb
            bb = c
        }
        return aa
    }
//    Offer 64. 求1+2+…+n
//    求 1+2+...+n ，要求不能使用乘除法、for、while、if、else、switch、case等关键字及条件判断语句（A?B:C）。
//    示例 1：
//    输入: n = 3
//    输出: 6
//    示例 2：
//    输入: n = 9
//    输出: 45
//    限制：
//    1 <= n <= 10000
//    链接：https://leetcode-cn.com/problems/qiu-12n-lcof
    class func sumNums(_ n: Int) -> Int {
        var sum = 0
        var _ = n > 0 && sumNumsHelper(n, &sum)
        return sum
    }
    class func sumNumsHelper(_ n: Int,_ sum: inout Int) -> Bool {
        sum = n + (sumNums(n - 1))
        return true
    }
    
//    63. 股票的最大利润
//    假设把某股票的价格按照时间先后顺序存储在数组中，请问买卖该股票一次可能获得的最大利润是多少？
//    示例 1:
//    输入: [7,1,5,3,6,4]
//    输出: 5
//    解释: 在第 2 天（股票价格 = 1）的时候买入，在第 5 天（股票价格 = 6）的时候卖出，最大利润 = 6-1 = 5 。
//         注意利润不能是 7-1 = 6, 因为卖出价格需要大于买入价格。
//    示例 2:
//    输入: [7,6,4,3,1]
//    输出: 0
//    解释: 在这种情况下, 没有交易完成, 所以最大利润为 0。
//    限制：
//    0 <= 数组长度 <= 10^5
//    注意：本题与主站 121 题相同：https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock/
//    链接：https://leetcode-cn.com/problems/gu-piao-de-zui-da-li-run-lcof
    class func maxProfit(_ prices: [Int]) -> Int {
//        dp[i][0] = max(dp[i-1][0],dp[i-1][1] + prices[i])
//        dp[i][1] = max(dp[i-1][1],-prices[i])
        if prices.count < 2{
            return 0
        }
        var i0 = 0
        var i1 = -prices[0]
        var i = 1
        while i < prices.count {
            i0 = max(i0, i1 + prices[i])
            i1 = max(i1, -prices[i])
            i += 1
        }
        return i0
    }
    
//    62. 圆圈中最后剩下的数字
//    0,1,···,n-1这n个数字排成一个圆圈，从数字0开始，每次从这个圆圈里删除第m个数字（删除后从下一个数字开始计数）。求出这个圆圈里剩下的最后一个数字。
//    例如，0、1、2、3、4这5个数字组成一个圆圈，从数字0开始每次删除第3个数字，则删除的前4个数字依次是2、0、4、1，因此最后剩下的数字是3。
//    示例 1：
//    输入: n = 5, m = 3
//    输出: 3
//    示例 2：
//    输入: n = 10, m = 17
//    输出: 2
//    限制：
//    1 <= n <= 10^5
//    1 <= m <= 10^6
//    链接：https://leetcode-cn.com/problems/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-lcof
    class MyNode {
        var val: Int
        var next: MyNode?
        var prev: MyNode?
        init(_ value: Int) {
            val = value
        }
    }
    class MyNodeList {
        var size = 0
        var head: MyNode?
        var tail: MyNode?
        
        func append(_ val: Int) {
            let node = MyNode(val)
            if size == 0 {
                head = node
                tail = node
                
            }else {
                tail?.next = node
                node.prev = tail
                node.next = head
                tail = node
            }
            size += 1
        }
        
        func delete(_ node: MyNode) {
            if node.val == head?.val {
                head = node.next
                tail?.next = head
            }else if node.val == tail?.val {
                tail = tail?.prev
                tail?.next = head
            }else {
                let prev = node.prev
                let next = node.next
                prev?.next = next
                next?.prev = prev
            }
            size -= 1
        }
        func walk(_ node: MyNode,_ m: Int) -> MyNode {
            var node1 = node
            var i = 1
            while i < m {
                node1 = node1.next!
                i += 1
            }
            let next = node1.next
            delete(node1)
            return next!
        }
    }
    
    class func lastRemaining(_ n: Int, _ m: Int) -> Int {
//        最后剩下的 3 的下标是 0。
//
//        第四轮反推，补上 m 个位置，然后模上当时的数组大小 22，位置是(0 + 3) % 2 = 1。
//
//        第三轮反推，补上 m 个位置，然后模上当时的数组大小 33，位置是(1 + 3) % 3 = 1。
//
//        第二轮反推，补上 m 个位置，然后模上当时的数组大小 44，位置是(1 + 3) % 4 = 0。
//
//        第一轮反推，补上 m 个位置，然后模上当时的数组大小 55，位置是(0 + 3) % 5 = 3。
//
//        所以最终剩下的数字的下标就是3。因为数组是从0开始的，所以最终的答案就是3。
//
//        总结一下反推的过程，就是 (当前index + m) % 上一轮剩余数字的个数。

        var i = 2
        var index = 0
        while i <= n {
            index = (index + m) % i
            i += 1
        }
        
        return index
        //递归
//        public int lastRemaining(int n, int m) {
//               return f(n, m);
//           }
//
//           public int f(int n, int m) {
//               if (n == 1) {
//                   return 0;
//               }
//               int x = f(n - 1, m);
//               return (m + x) % n;
//           }

        //数学
//                int f = 0;
//                for (int i = 2; i != n + 1; ++i) {
//                    f = (m + f) % i;
//                }
//                return f;

        
        
        
//        let list = MyNodeList()
//        var i = 0
//        while i < n {
//            list.append(i)
//            i += 1
//        }
//        var node = list.head
//        while list.size > 1 {
//            node = list.walk(node!, m)
//        }
//        return list.head!.val
        
//        var i = 0
//        var array = [Int]()
//        while i < n {
//            array.append(i)
//            i += 1
//        }
//        //0、1、2、3、4
//        var deadSet = Set<Int>()
//        var index = -1
//        while array.count - deadSet.count > 1 {
//            var k = 0
//            while k < m {
//                index += 1
//                if index == array.count {
//                    index = 0
//                }
//                let cur = array[index]
//                if !deadSet.contains(cur) {
//                    k += 1
//                }
//            }
//            let num = array[index]
//            deadSet.insert(num)
//        }
//        for num in array {
//            if !deadSet.contains(num) {
//                return num
//            }
//        }
//        return 0
    }
    
//    61. 扑克牌中的顺子
//    从扑克牌中随机抽5张牌，判断是不是一个顺子，即这5张牌是不是连续的。2～10为数字本身，A为1，J为11，Q为12，K为13，而大、小王为 0 ，可以看成任意数字。A 不能视为 14。
//    示例 1:
//    输入: [1,2,3,4,5]
//    输出: True
//    示例 2:
//    输入: [0,0,1,2,5]
//    输出: True
//    限制：
//    数组长度为 5
//    数组的数取值为 [0, 13] .
//    链接：https://leetcode-cn.com/problems/bu-ke-pai-zhong-de-shun-zi-lcof
    class func isStraight(_ nums: [Int]) -> Bool {
//                int joker = 0;
//                Arrays.sort(nums); // 数组排序
//                for(int i = 0; i < 4; i++) {
//                    if(nums[i] == 0) joker++; // 统计大小王数量
//                    else if(nums[i] == nums[i + 1]) return false; // 若有重复，提前返回 false
//                }
//                return nums[4] - nums[joker] < 5; // 最大牌 - 最小牌 < 5 则可构成顺子

        
        let array = nums.sorted()
        var zero = 0
        var i = 0
        while i < array.count {
            let num = array[i]
            if num == 0 {
                zero += 1
            }else {
                if i > 0 && array[i - 1] != 0{
                    let dif = num - array[i - 1]
                    if dif == 0 {
                        return false
                    }
                    if dif != 1 {
                        if zero - (dif - 1) >= 0 {
                            zero -= (dif - 1)
                        }else {
                            return false
                        }
                    }
                }
            }
            i += 1
        }
        return true
    }
//    60. n个骰子的点数
//    把n个骰子扔在地上，所有骰子朝上一面的点数之和为s。输入n，打印出s的所有可能的值出现的概率。
//    你需要用一个浮点数数组返回答案，其中第 i 个元素代表这 n 个骰子所能掷出的点数集合中第 i 小的那个的概率。
//    示例 1:
//    输入: 1
//    输出: [0.16667,0.16667,0.16667,0.16667,0.16667,0.16667]
//    示例 2:
//    输入: 2
//    输出: [0.02778,0.05556,0.08333,0.11111,0.13889,0.16667,0.13889,0.11111,0.08333,0.05556,0.02778]
//    限制：
//    1 <= n <= 11
//    链接：https://leetcode-cn.com/problems/nge-tou-zi-de-dian-shu-lcof
    class func dicesProbability(_ n: Int) -> [Double] {
        //动态规划
//        for (第n枚骰子的点数 i = 1; i <= 6; i ++) {
//            dp[n][j] += dp[n-1][j - i]
//        }
        //投掷n个骰子，点数j出现的次数
        var dp: [[Int]] = []
        for _ in 0...n {
            let array = Array(repeating: 0, count: 6 * n + 1)
            dp.append(array)
        }
        for i in 1...6 {
            dp[1][i] = 1
        }
        
        var i = 2
        while i <= n {
            var j = i
            while j <= 6 * i {
                var k = 1
                while k <= 6 && j - k >= 1 {
                    dp[i][j] += dp[i - 1][j - k]
                    k += 1
                }
                j += 1
            }
            i += 1
        }
        
        var result = [Double]()
        var total = 0.0
        var k = 1
        while k <= 6 * n {
            if dp[n][k] > 0 {
                let val = Double(dp[n][k])
                result.append(val)
                total += val
            }
            k += 1
        }
        result = result.map {
            $0 / total
        }
        
        return result
        
        
        //超时
//        var dic: [Int:Int] = [:]
//        dicesProbabilityHelper(&dic, n, 1, 0)
//        var array: [(Int,Int)] = []
//        var totalVal = 0
//        for (key,val) in dic {
//            array.append((key,val))
//            totalVal += val
//        }
//        array.sort { (t1, t2) -> Bool in
//            return t1.0 > t2.0
//        }
//        var result: [Double] = []
//        for item in array {
//            result.append(Double(item.1) / Double(totalVal))
//        }
//        return result
    }
    class func dicesProbabilityHelper(_ dic: inout [Int:Int],_ n: Int,_ cur: Int,_ sum: Int) {
        if cur == n {
            var i = 1
            while i <= 6 {
                if let val = dic[sum + i] {
                    dic[sum + i] = val + 1
                }else {
                    dic[sum + i] = 1
                }
                i += 1
            }
            return
        }
        
        var i = 1
        while i <= 6 {
            dicesProbabilityHelper(&dic, n, cur + 1, sum + i)
            i += 1
        }
    }
    
//    59 - II. 队列的最大值
//    请定义一个队列并实现函数 max_value 得到队列里的最大值，要求函数max_value、push_back 和 pop_front 的均摊时间复杂度都是O(1)。
//    若队列为空，pop_front 和 max_value 需要返回 -1
//    示例 1：
//    输入:
//    ["MaxQueue","push_back","push_back","max_value","pop_front","max_value"]
//    [[],[1],[2],[],[],[]]
//    输出: [null,null,null,2,1,2]
//    示例 2：
//    输入:
//    ["MaxQueue","pop_front","max_value"]
//    [[],[],[]]
//    输出: [null,-1,-1]
//    限制：
//    1 <= push_back,pop_front,max_value的总操作数 <= 10000
//    1 <= value <= 10^5
//    链接：https://leetcode-cn.com/problems/dui-lie-de-zui-da-zhi-lcof
    class MaxQueue {
        class MaxQueueNode {
            var val: Int
            var next: MaxQueueNode?
            init(_ value: Int) {
                val = value
            }
        }
        class MaxQueuelinkedList {
            var head: MaxQueueNode?
            var tail: MaxQueueNode?
            var size = 0
            
            func push(_ val: Int) {
                let node = MaxQueueNode(val)
                if size == 0 {
                    head = node
                    tail = node
                }else {
                    tail?.next = node
                    tail = node
                }
                size += 1
            }
            
            func pop() -> Int {
                if let node = head {
                    if size == 1 {
                        head = nil
                        tail = nil
                    }else {
                        head = head?.next
                    }
                    size -= 1
                    return node.val
                }
                return -1
            }
        }
        
        var queue: MaxQueuelinkedList = MaxQueuelinkedList()
        var dequeue = [Int]()
        init() {

        }
        
        func max_value() -> Int {
            if queue.size > 0 {
                return dequeue[0]
            }
            return -1
        }
        
        func push_back(_ value: Int) {
            queue.push(value)
            while dequeue.count > 0{
                let val = dequeue[dequeue.count - 1]
                if val < value {
                    dequeue.removeLast()
                }else {
                    break
                }
            }
            dequeue.append(value)
        }
        
        func pop_front() -> Int {
            if queue.size > 0 {
                let val = queue.pop()
                if val == dequeue[0] {
                    dequeue.removeFirst()
                }
                return val
            }
            return -1
        }
    }
    
//    59 - I. 滑动窗口的最大值
//    给定一个数组 nums 和滑动窗口的大小 k，请找出所有滑动窗口里的最大值。
//    示例:
//    输入: nums = [1,3,-1,-3,5,3,6,7], 和 k = 3
//    输出: [3,3,5,5,6,7]
//    解释:
//      滑动窗口的位置                最大值
//    ---------------               -----
//    [1  3  -1] -3  5  3  6  7       3
//     1 [3  -1  -3] 5  3  6  7       3
//     1  3 [-1  -3  5] 3  6  7       5
//     1  3  -1 [-3  5  3] 6  7       5
//     1  3  -1  -3 [5  3  6] 7       6
//     1  3  -1  -3  5 [3  6  7]      7
//    提示：
//    你可以假设 k 总是有效的，在输入数组不为空的情况下，1 ≤ k ≤ 输入数组的大小。
//    注意：本题与主站 239 题相同：https://leetcode-cn.com/problems/sliding-window-maximum/
//    链接：https://leetcode-cn.com/problems/hua-dong-chuang-kou-de-zui-da-zhi-lcof
    class func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        var left = 0
        var right = 0
        var result = [Int]()
        var maxVal = Int.min
        while right < nums.count {
            let rightVal = nums[right]
            maxVal = max(maxVal, rightVal)
            right += 1
            if right - left > k {
                let leftVal = nums[left]
                if leftVal == maxVal {
                    maxVal = nums[left + 1]
                    var i = 1
                    while i <= k  {
                        maxVal = max(maxVal, nums[left + i])
                        i += 1
                    }
                }
                left += 1
            }
            if right - left == k {
                result.append(maxVal)
            }
        }
        return result
    }
    
    
    
//    58 - II. 左旋转字符串
//    字符串的左旋转操作是把字符串前面的若干个字符转移到字符串的尾部。请定义一个函数实现字符串左旋转操作的功能。比如，输入字符串"abcdefg"和数字2，该函数将返回左旋转两位得到的结果"cdefgab"。
//    示例 1：
//    输入: s = "abcdefg", k = 2
//    输出: "cdefgab"
//    示例 2：
//    输入: s = "lrloseumgh", k = 6
//    输出: "umghlrlose"
//    限制：
//    1 <= k < s.length <= 10000
//    链接：https://leetcode-cn.com/problems/zuo-xuan-zhuan-zi-fu-chuan-lcof。
    class func reverseLeftWords(_ s: String, _ n: Int) -> String {
        let array = Array(s)
        let array1 = array[0..<n]
        let array2 = array[n..<array.count]
        return String(array2) + String(array1)
    }
    
//    58 - I. 翻转单词顺序
//    输入一个英文句子，翻转句子中单词的顺序，但单词内字符的顺序不变。为简单起见，标点符号和普通字母一样处理。例如输入字符串"I am a student. "，则输出"student. a am I"。
//    示例 1：
//    输入: "the sky is blue"
//    输出: "blue is sky the"
//    示例 2：
//    输入: "  hello world!  "
//    输出: "world! hello"
//    解释: 输入字符串可以在前面或者后面包含多余的空格，但是反转后的字符不能包括。
//    示例 3：
//    输入: "a good   example"
//    输出: "example good a"
//    解释: 如果两个单词间有多余的空格，将反转后单词间的空格减少到只含一个。
//    说明：
//    无空格字符构成一个单词。
//    输入字符串可以在前面或者后面包含多余的空格，但是反转后的字符不能包括。
//    如果两个单词间有多余的空格，将反转后单词间的空格减少到只含一个。
//    注意：本题与主站 151 题相同：https://leetcode-cn.com/problems/reverse-words-in-a-string/
//    链接：https://leetcode-cn.com/problems/fan-zhuan-dan-ci-shun-xu-lcof
    class func reverseWords(_ s: String) -> String {
        let array = Array(s)
        var wordArray = [String]()
        var word = [Character]()
        
        for ch in array {
            if ch == " " {
                if word.count > 0 {
                    wordArray.append(String(word))
                    word.removeAll()
                }
            }else {
                word.append(ch)
            }
        }
        if word.count > 0 {
            wordArray.append(String(word))
        }
        var result = ""
        var i = wordArray.count - 1
        while i >= 0 {
            if i != wordArray.count - 1 {
                result += " "
            }
            result += wordArray[i]
            i -= 1
        }
        return result
    }
    
    
//    57 - II. 和为s的连续正数序列
//    输入一个正整数 target ，输出所有和为 target 的连续正整数序列（至少含有两个数）。
//    序列内的数字由小到大排列，不同序列按照首个数字从小到大排列。
//    示例 1：
//    输入：target = 9
//    输出：[[2,3,4],[4,5]]
//    示例 2：
//    输入：target = 15
//    输出：[[1,2,3,4,5],[4,5,6],[7,8]]
//    限制：
//    1 <= target <= 10^5
//    链接：https://leetcode-cn.com/problems/he-wei-sde-lian-xu-zheng-shu-xu-lie-lcof
    class func findContinuousSequence(_ target: Int) -> [[Int]] {
        var array = [Int]()
        for num in 1..<target {
            array.append(num)
        }
        var left = 0
        var right = 0
        var sum = 0
        var result = [[Int]]()
        while right < array.count {
            sum += array[right]
            right += 1
            
            while sum > target {
                sum -= array[left]
                left += 1
            }
            if sum == target && left != right {
                result.append(Array(array[left..<right]))
            }
        }
        return result
        
//        var i = 1
//        var result = [[Int]]()
//        var temp = [Int]()
//        while i < target {
//            var sum = 0
//            var k = i
//            temp = [Int]()
//            while sum < target {
//                sum += k
//                temp.append(k)
//                k += 1
//            }
//            if sum == target {
//                result.append(temp)
//            }
//            i += 1
//        }
//        return result
    }
    
//    57. 和为s的两个数字
//    输入一个递增排序的数组和一个数字s，在数组中查找两个数，使得它们的和正好是s。如果有多对数字的和等于s，则输出任意一对即可。
//    示例 1：
//    输入：nums = [2,7,11,15], target = 9
//    输出：[2,7] 或者 [7,2]
//    示例 2：
//    输入：nums = [10,26,30,31,47,60], target = 40
//    输出：[10,30] 或者 [30,10]
//    限制：
//    1 <= nums.length <= 10^5
//    1 <= nums[i] <= 10^6
//    链接：https://leetcode-cn.com/problems/he-wei-sde-liang-ge-shu-zi-lcof
    class func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var left = 0
        var right = nums.count - 1
        while left < right {
            if nums[left] + nums[right] < target {
                left += 1
            }else if nums[left] + nums[right] > target {
                right -= 1
            }else {
                return [nums[left],nums[right]]
            }
        }
        return []
        
//        let set = Set(nums);
//        for item in nums {
//            if set.contains(target - item) {
//                return [item,(target - item)]
//            }
//        }
//        return []
    }
    
//    56 - II. 数组中数字出现的次数 II
//    在一个数组 nums 中除一个数字只出现一次之外，其他数字都出现了三次。请找出那个只出现一次的数字。
//    示例 1：
//    输入：nums = [3,4,3,3]
//    输出：4
//    示例 2：
//    输入：nums = [9,1,7,9,7,9,7]
//    输出：1
//    限制：
//    1 <= nums.length <= 10000
//    1 <= nums[i] < 2^31
//    链接：https://leetcode-cn.com/problems/shu-zu-zhong-shu-zi-chu-xian-de-ci-shu-ii-lcof
    class func singleNumber(_ nums: [Int]) -> Int {
        
        //官方思路
//        int[] counts = new int[32];
//                for(int num : nums) {
//                    for(int j = 0; j < 32; j++) {
//                        counts[j] += num & 1;
//                        num >>>= 1;
//                    }
//                }
//                int res = 0, m = 3;
//                for(int i = 0; i < 32; i++) {
//                    res <<= 1;
//                    res |= counts[31 - i] % m;
//                }
//                return res;

        
        var oneSet = Set<Int>()
        var moreSet = Set<Int>()
        for num in nums {
            if !moreSet.contains(num) {
                if oneSet.contains(num) {
                    oneSet.remove(num)
                    moreSet.insert(num)
                }else {
                    oneSet.insert(num)
                }
            }
        }
        return oneSet.randomElement()!
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
    class func singleNumbers1(_ nums: [Int]) -> [Int] {
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

