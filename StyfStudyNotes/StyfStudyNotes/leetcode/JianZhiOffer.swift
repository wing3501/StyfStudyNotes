//
//  JianZhiOffer.swift
//  StyfStudyNotes
//
//  Created by styf on 2021/2/9.
//

import Foundation

class PriorityQueue<T> {
    //a < b   then return NSOrderedAscending
    typealias PriorityQueueComparator = (T, T) -> ComparisonResult
    var k: Int//容量
    var comparator: PriorityQueueComparator//比较器
    var array: [T] = []
    var isEmpty: Bool {
        return array.isEmpty
    }
    init(_ k: Int,_ comparator: @escaping PriorityQueueComparator) {
        self.k = k
        self.comparator = comparator
    }
    
    func offer(_ e: T) {
        array.append(e)
        siftUp(array.count - 1)
    }
    
    func poll() -> T {
        let e = array[0]
        if array.count == 1 {
            array.removeFirst()
        }else {
            array[0] = array[array.count - 1]
            array.removeLast()
            siftDown(0)
        }
        return e;
    }
    
    func siftDown(_ i: Int) {
        var index = i
        let element = array[index]
        let size = array.count / 2
        while index < size {
            var childIndex = index * 2 + 1
            var child = array[childIndex]
            let rightChildIndex = childIndex + 1
            if rightChildIndex < array.count,comparator(child, array[rightChildIndex]) == ComparisonResult.orderedAscending {
                childIndex = rightChildIndex
                child = array[rightChildIndex]
            }
            
            if comparator(element, child) == ComparisonResult.orderedDescending {
                break
            }
            array[index] = child
            index = childIndex
        }
        array[index] = element
    }
    
    func siftUp(_ i: Int) {
        var index = i
        let element = array[index]
        while index > 0 {
            let fatherIndex = (index - 1) / 2
            let father = array[fatherIndex]
            if comparator(element, father) == ComparisonResult.orderedAscending {
                break
            }
            array[index] = father
            index = fatherIndex
        }
        array[index] = element
    }
    
}

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
        
        //    剑指 Offer II 015. 字符串中的所有变位词
//        print(findAnagrams("cbaebabacd", "abc"))//[0,6]
//        print(findAnagrams("abab", "ab"))//[0,1,2]
//        print(findAnagrams("dinitrophenylhydrazinetrinitrophenylmethylnitramine", "trinitrophenylmethylnitramine"))//[19,20,21,22]
        
        //    剑指 Offer II 016. 不含重复字符的最长子字符串
//        print(lengthOfLongestSubstring111("abcabcbb"))//3
//        print(lengthOfLongestSubstring111("bbbbb"))//1
//        print(lengthOfLongestSubstring111("pwwkew"))//3
//        print(lengthOfLongestSubstring111(""))//0
        
        //    剑指 Offer II 017. 含有所有字符的最短字符串
//        print(minWindow("ADOBECODEBANC", "ABC"))//"BANC"
//        print(minWindow("a", "a"))//"a"

        //    剑指 Offer II 018. 有效的回文
//        print(isPalindrome("A man, a plan, a canal: Panama"))
//        print(isPalindrome("race a car"))
//        print(isPalindrome("0P"))
        
        //    剑指 Offer II 019. 最多删除一个字符得到回文
//        print(validPalindrome("aba"))
//        print(validPalindrome("abca"))
//        print(validPalindrome("abc"))
        
        //    剑指 Offer II 020. 回文子字符串的个数
//        print(countSubstrings("abc"))
//        print(countSubstrings("aaa"))
        
        //    剑指 Offer II 026. 重排链表
//        print(reorderList(createList([1,2,3,4,5])))
        
        //    剑指 Offer II 090. 环形房屋偷盗
//        print(rob111([2,3,2]))
//        print(rob111([1,2,3,1]))
//        print(rob111([0]))
        
        //    剑指 Offer II 091. 粉刷房子
//        print(minCost([[17,2,17],[16,16,5],[14,3,19]]))//10
        //    剑指 Offer II 092. 翻转字符
//        print(minFlipsMonoIncr("00110"))//1
//        print(minFlipsMonoIncr("010110"))//2
//        print(minFlipsMonoIncr("00011000"))//2
//        print(minFlipsMonoIncr("0101100011"))//3
//        print(minFlipsMonoIncr("10011111110010111011"))//5
//        print(minFlipsMonoIncr("11011"))//1
        
        //    剑指 Offer II 031. 最近最少使用缓存
//        let lRUCache = LRUCache(2);
//        lRUCache.put(1, 1); // 缓存是 {1=1}
//        lRUCache.put(2, 2); // 缓存是 {1=1, 2=2}
//        print(lRUCache.get(1));    // 返回 1
//        lRUCache.put(3, 3); // 该操作会使得关键字 2 作废，缓存是 {1=1, 3=3}
//        print(lRUCache.get(2));    // 返回 -1 (未找到)
//        lRUCache.put(4, 4); // 该操作会使得关键字 1 作废，缓存是 {4=4, 3=3}
//        print(lRUCache.get(1));    // 返回 -1 (未找到)
//        print(lRUCache.get(3));    // 返回 3
//        print(lRUCache.get(4));    // 返回 4
        
        //    剑指 Offer II 093. 最长斐波那契数列
//        print(lenLongestFibSubseq([1,2,3,4,5,6,7,8]))//5
//        print(lenLongestFibSubseq([1,3,7,11,12,14,18]))//3
        
        //    剑指 Offer II 094. 最少回文分割
//        print(minCut("ababa"))//0
//        print(minCut("aab"))//1
//        print(minCut("a"))//0
//        print(minCut("ab"))//1
//        print(minCut("ccaacabacb"))//3  cc aa cabac b
//        print(minCut("ababababababababababababcbabababababababababababa"))
        //    剑指 Offer II 032. 有效的变位词
//        print(isAnagram("anagram", "nagaram"))
//        print(isAnagram("rat", "car"))
//        print(isAnagram("a", "a"))
        //    剑指 Offer II 095. 最长公共子序列
//        print(longestCommonSubsequence("abcde", "ace"))
//        print(longestCommonSubsequence("abc", "abc"))
//        print(longestCommonSubsequence("abc", "def"))
        //    剑指 Offer II 033. 变位词组
//        print(groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"]))
//        print(groupAnagrams([""]))
//        print(groupAnagrams(["a"]))
        //    剑指 Offer II 034. 外星语言是否排序
//        print(isAlienSorted(["hello","leetcode"], "hlabcdefgijkmnopqrstuvwxyz"))
//        print(isAlienSorted(["word","world","row"], "worldabcefghijkmnpqstuvxyz"))
//        print(isAlienSorted(["apple","app"], "abcdefghijklmnopqrstuvwxyz"))
//        print(isAlienSorted(["xpzurqpjimcqjp","cpoymyvqrrkw","jhvxpqgq","escrktgzqpoze","tamdkoyacprfyj","tcgkdjerydm","czhzgfcvrmudxd","qwbegrhcavi","yvluklzflkjq","pwawsolwzognjx"], "xchaiwgovseknjuztmrydflqbp"))//false
        
        //    剑指 Offer II 096. 字符串交织
//        print(isInterleave("aabcc", "dbbca", "aadbbcbcac"))//true
//        print(isInterleave("aabcc", "dbbca", "aadbbbaccc"))//false
//        print(isInterleave("", "", ""))//true
//        print(isInterleave("bbbcc", "bbaccbbbabcacc", "bbbbacbcccbcbabbacc"))//false
//        print(isInterleave("aabcc", "dbbca", "aadbbcbcac"))//true
//        print(isInterleave("abababababababababababababababababababababababababababababababababababababababababababababababababbb", "babababababababababababababababababababababababababababababababababababababababababababababababaaaba", "abababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababbb"))
        //    剑指 Offer II 035. 最小时间差
//        print(findMinDifference(["23:59","00:00"]))//1
//        print(findMinDifference(["00:00","23:59","00:00"]))//0
        
        //    剑指 Offer II 036. 后缀表达式
//        print(evalRPN(["2","1","+","3","*"]))//9
//        print(evalRPN(["4","13","5","/","+"]))//6
//        print(evalRPN(["10","6","9","3","+","-11","*","/","*","17","+","5","+"]))//22
        
        //    剑指 Offer II 097. 子序列的数目
//        print(numDistinct("rabbbit", "rabbit"))//3
//        print(numDistinct("babgbag", "bag"))//5
        
        //    剑指 Offer II 037. 小行星碰撞
//        print(asteroidCollision([5,10,-5]))//[5,10]
//        print(asteroidCollision([8,-8]))//[]
//        print(asteroidCollision([10,2,-5]))//[10]
//        print(asteroidCollision([-2,-1,1,2]))//[-2,-1,1,2]
//        print(asteroidCollision([-2,-2,1,-1]))//[-2,-2]
//        print(asteroidCollision([1,-2,-2,-2]))//[-2,-2,-2]
        
//        print(climbStairs(1))
        
        //    剑指 Offer II 038. 每日温度
//        print(dailyTemperatures([73,74,75,71,69,72,76,73]))//[1, 1, 4, 2, 1, 1, 0, 0]
//        print(dailyTemperatures([30,40,50,60]))//[1,1,1,0]
//        print(dailyTemperatures([30,60,90]))//[1,1,0]
        
        //    剑指 Offer II 039. 直方图最大矩形面积
//        print(largestRectangleArea([2,1,5,6,2,3]))//10
//        print(largestRectangleArea([2,4]))//4
//        print(largestRectangleArea([2,1,2]))//3
        
        //    剑指 Offer II 040. 矩阵中最大的矩形
//        print(maximalRectangle(["10100","10111","11111","10010"]))
        
        //    剑指 Offer II 099. 最小路径之和
//        print(minPathSum([[1,3,1],[1,5,1],[4,2,1]]))
//        print(minPathSum([[1,2,3],[4,5,6]]))
        
        //    剑指 Offer II 100. 三角形中最小路径之和
//        print(minimumTotal([[2],[3,4],[6,5,7],[4,1,8,3]]))
//        print(minimumTotal([[-10]]))
        
        //    剑指 Offer II 101. 分割等和子集
//        print(canPartition([1,5,11,5]))
//        print(canPartition([1,2,3,5]))
//        print(canPartition([1,2,5]))
        //    剑指 Offer II 102. 加减的目标值
//        print(findTargetSumWays([1,1,1,1,1], 3))
//        print(findTargetSumWays([1], 1))
//        print(findTargetSumWays([0,0,0,0,0,0,0,0,1], 1))
        
        //    剑指 Offer II 059. 数据流的第 K 大数值
//        let a = KthLargest(3, [4, 5, 8, 2])
//        print(a.add(3))
//        print(a.add(5))
//        print(a.add(10))
//        print(a.add(9))
//        print(a.add(4))
//        剑指 Offer II 068. 查找插入位置
//        print(searchInsert([1,3,5,6], 5))//2
//        print(searchInsert([1,3,5,6], 2))//1
//        print(searchInsert([1,3,5,6], 7))//4
//        print(searchInsert([1,3,5,6], 0))//0
//        print(searchInsert([1], 0))//0
        
        //    剑指 Offer II 072. 求平方根
//        print(mySqrt(4))//2
//        print(mySqrt(8))//2
//        print(mySqrt(2))//1
//        print(mySqrt(3))//1
        
        //    剑指 Offer II 103. 最少的硬币数目
//        print(coinChange([1, 2, 5], 11))//3
//        print(coinChange([2], 3))//-1
//        print(coinChange([1], 0))//0
//        print(coinChange([1], 1))//1
//        print(coinChange([1], 2))//2
        
        //    剑指 Offer II 104. 排列的数目
//        print(combinationSum4([10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200,210,220,230,240,250,260,270,280,290,300,310,320,330,340,350,360,370,380,390,400,410,420,430,440,450,460,470,480,490,500,510,520,530,540,550,560,570,580,590,600,610,620,630,640,650,660,670,680,690,700,710,720,730,740,750,760,770,780,790,800,810,820,830,840,850,860,870,880,890,900,910,920,930,940,950,960,970,980,990,111], 999))
        
//    剑指 Offer II 105. 岛屿的最大面积
//        print(maxAreaOfIsland([[0,0,1,0,0,0,0,1,0,0,0,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,1,1,0,1,0,0,0,0,0,0,0,0],[0,1,0,0,1,1,0,0,1,0,1,0,0],[0,1,0,0,1,1,0,0,1,1,1,0,0],[0,0,0,0,0,0,0,0,0,0,1,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,0,0,0,0,0,0,1,1,0,0,0,0]]))
//        print(maxAreaOfIsland([[0,0,0,0,0,0,0,0]]))
        
        //    剑指 Offer II 106. 二分图
//        print(isBipartite([[1,2,3],[0,2],[0,1,3],[0,2]]))//false
//        print(isBipartite([[1,3],[0,2],[1,3],[0,2]]))//true
//        print(isBipartite([[3],[2,4],[1],[0,4],[1,3]]))//true
//        print(isBipartite([[2,4],[2,3,4],[0,1],[1],[0,1],[7],[9],[5],[],[6],[12,14],[],[10],[],[10],[19],[18],[],[16],[15],[23],[23],[],[20,21],[],[],[27],[26],[],[],[34],[33,34],[],[31],[30,31],[38,39],[37,38,39],[36],[35,36],[35,36],[43],[],[],[40],[],[49],[47,48,49],[46,48,49],[46,47,49],[45,46,47,48]]))
        
        //    剑指 Offer II 043. 往完全二叉树添加节点
//        let node = TreeTest.deserialize("[1,2,3,4,5,6]")
//        let n = CBTInserter(node)
//        print(n.insert(7))
//        print(n.insert(8))
//
        //    剑指 Offer II 107. 矩阵中的距离
//        print(updateMatrix([[0,0,0],[0,1,0],[1,1,1]]))
        
        //    剑指 Offer II 054. 所有大于等于节点的值之和
//        let node = TreeTest.deserialize("[4,1,6,0,2,5,7,null,null,null,3,null,null,null,8]")
//        convertBST(node)
//        print("")
        
        //    剑指 Offer II 057. 值和下标之差都在给定的范围内
//        print(containsNearbyAlmostDuplicate([1,2,3,1], 3, 0))
//        print(containsNearbyAlmostDuplicate([1,0,1,1], 1, 2))
//        print(containsNearbyAlmostDuplicate([1,5,9,1,5,9], 2, 3))
//        print(containsNearbyAlmostDuplicate([2147483647,-1,2147483647], 1, 2147483647))//false
        
        //    剑指 Offer II 058. 日程表
//        let a = MyCalendar()
//        print(a.book(47, 50))
//        print(a.book(33, 41))
//        print(a.book(39, 45))
//        print(a.book(33, 42))
//        print(a.book(25, 32))
//        print(a.book(26, 35))
//        print(a.book(19, 25))
//        print(a.book(3, 8))
//        print(a.book(8, 13))
//        print(a.book(18, 27))
//        ["MyCalendar","book","book","book","book","book","book","book","book","book","book"]
//        [[],[47,50],[33,41],[39,45],[33,42],[25,32],[26,35],[19,25],[3,8],[8,13],[18,27]]
//        [null,true,true,false,false,true,false,true,true,true,false]
        
        //    剑指 Offer II 060. 出现频率最高的 k 个数字
//        print(topKFrequent([1,1,1,2,2,3], 2))
//        print(topKFrequent([-1,1,4,-4,3,5,4,-2,3,-1], 3))//[-1,3,4]
        //    剑指 Offer II 061. 和最小的 k 个数对
//        print(kSmallestPairs([1,7,11], [2,4,6], 3))
//        print(kSmallestPairs([1,1,2], [1,2,3], 2))
//        print(kSmallestPairs([1,2], [3], 3))
//        print(kSmallestPairs([1,1,2], [1,2,3], 10))
//        print(kSmallestPairs([0,0,0,0,0], [-3,22,35,56,76], 22))
//        [[0,-3],[0,-3],[0,-3],[0,-3],[0,-3],[0,22],[0,22],[0,22],[0,22],[0,22],[0,35],[0,35],[0,35],[0,35],[0,35],[0,56],[0,56],[0,56],[0,56],[0,56],[0,76],[0,76]]
        
        //    剑指 Offer II 062. 实现前缀树
//        let trie = Trie();
//        trie.insert("apple");
//        trie.search("apple");   // 返回 True
//        trie.search("app");     // 返回 False
//        trie.startsWith("app"); // 返回 True
//        trie.insert("app");
//        trie.search("app");     // 返回 True

        //    剑指 Offer II 063. 替换单词
//        print(replaceWords(["cat","bat","rat"], "the cattle was rattled by the battery"))
//        print(replaceWords(["a","b","c"], "aadsfasf absbs bbab cadsfafs"))
//        print(replaceWords(["a", "aa", "aaa", "aaaa"], "a aa a aaaa aaa aaa aaa aaaaaa bbb baba ababa"))
//        print(replaceWords(["catt","cat","bat","rat"], "the cattle was rattled by the battery"))
//        print(replaceWords(["ac","ab"], "it is abnormal that this solution is accepted"))
        
        //    剑指 Offer II 064. 神奇的字典
//        let dic = MagicDictionary()
//        dic.buildDict(["hello", "leetcode"])
//        print(dic.search("hello"))
//        print(dic.search("hhllo"))
//        print(dic.search("hell"))
//        print(dic.search("leetcoded"))
        
//        dic.buildDict(["hello","hallo","leetcode","judge", "judgg"])
//        print(dic.search("judge"))
//        print(dic.search("judgg"))
        
//        dic.buildDict(["hello","leetcode"])
//        print(dic.search("hello"))
        
//        dic.buildDict(["a","b","ab","abc","abcabacbababdbadbfaejfoiawfjaojfaojefaowjfoawjfoawj","abcdefghijawefe","aefawoifjowajfowafjeoawjfaow","cba","cas","aaewfawi","babcda","bcd","awefj"])
//        print(dic.search("a"))
//        print(dic.search("b"))
//        print(dic.search("c"))
//        print(dic.search("a"))
//        print(dic.search("d"))
//        print(dic.search("e"))
//        print(dic.search("f"))
//        print(dic.search("ab"))
//        print(dic.search("ba"))
//        print(dic.search("abc"))
//        print(dic.search("cba"))
//        print(dic.search("abb"))
//        print(dic.search("bb"))
//        print(dic.search("aa"))
//        print(dic.search("bbc"))
//        print(dic.search("abcd"))
        
//        ["MagicDictionary", "buildDict", "search", "search", "search", "search", "search", "search", "search", "search", "search", "search", "search", "search", "search", "search", "search"]
//        [[], [["a","b","ab","abc","abcabacbababdbadbfaejfoiawfjaojfaojefaowjfoawjfoawj","abcdefghijawefe","aefawoifjowajfowafjeoawjfaow","cba","cas","aaewfawi","babcda","bcd","awefj"]], ["a"], ["b"], ["c"], ["d"], ["e"], ["f"], ["ab"], ["ba"], ["abc"], ["cba"], ["abb"], ["bb"], ["aa"], ["bbc"], ["abcd"]]
    
//        剑指 Offer II 065. 最短的单词编码
//        print(minimumLengthEncoding(["time", "me", "bell"]))//10
//        print(minimumLengthEncoding(["t"]))//2
//        print(minimumLengthEncoding(["time","atime","btime"]))//12
        
        //    剑指 Offer II 066. 单词之和
//        let mapSum = MapSum()
//        mapSum.insert("apple", 3)
//        print(mapSum.sum("ap"))
//        mapSum.insert("app", 2)
//        mapSum.insert("apple", 2)
//        print(mapSum.sum("ap"))
//        ["MapSum", "insert", "sum", "insert", "insert", "sum"]
//        [[], ["apple",3], ["ap"], ["app",2], ["apple", 2], ["ap"]]
        
        
        //    剑指 Offer II 067. 最大的异或
//        print(findMaximumXOR([3,10,5,25,2,8]))//28
        
//        剑指 Offer II 069. 山峰数组的顶部
//        print(peakIndexInMountainArray([0,1,0]))//1
//        print(peakIndexInMountainArray([1,3,5,4,2]))//2
//        print(peakIndexInMountainArray([0,10,5,2]))//1
//        print(peakIndexInMountainArray([3,4,5,1]))//2
//        print(peakIndexInMountainArray([24,69,100,99,79,78,67,36,26,19]))//2
        
        //    剑指 Offer II 070. 排序数组中只出现一次的数字
//        print(singleNonDuplicate([1,1,2,3,3,4,4,8,8]))//2
//        print(singleNonDuplicate([3,3,7,7,10,11,11]))//10
//        print(singleNonDuplicate([1,1,2,3,3]))//2
        
//        剑指 Offer II 073. 狒狒吃香蕉
//        print(minEatingSpeed([3,6,7,11], 8))
//        print(minEatingSpeed([30,11,23,4,20], 5))
//        print(minEatingSpeed([30,11,23,4,20], 6))
//        print(minEatingSpeed([312884470], 312884469))
        
        //    剑指 Offer II 074. 合并区间
//        print(merge([[1,3],[2,6],[8,10],[15,18]]))
//        print(merge([[1,4],[4,5]]))
        
//        剑指 Offer II 076. 数组中的第 k 大的数字
//        print(findKthLargest([3,2,1,5,6,4], 2))//5
//        print(findKthLargest([3,2,3,1,2,4,5,5,6], 4))//4
        
        
    }
    
//    剑指 Offer II 077. 链表排序
//    给定链表的头结点 head ，请将其按 升序 排列并返回 排序后的链表 。
//    示例 1：
//    输入：head = [4,2,1,3]
//    输出：[1,2,3,4]
//    示例 2：
//    输入：head = [-1,5,3,4,0]
//    输出：[-1,0,3,4,5]
//    示例 3：
//    输入：head = []
//    输出：[]
//    提示：
//    链表中节点的数目在范围 [0, 5 * 104] 内
//    -105 <= Node.val <= 105
//    进阶：你可以在 O(n log n) 时间复杂度和常数级空间复杂度下，对链表进行排序吗？
//    注意：本题与主站 148 题相同：https://leetcode-cn.com/problems/sort-list/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/7WHec2
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    func sortList(_ head: ListNode?) -> ListNode? {
        return nil
//        class Solution {
//            public ListNode sortList(ListNode head) {
//                if (head == null) {
//                    return head;
//                }
//                int length = 0;
//                ListNode node = head;
//                while (node != null) {
//                    length++;
//                    node = node.next;
//                }
//                ListNode dummyHead = new ListNode(0, head);
//                for (int subLength = 1; subLength < length; subLength <<= 1) {
//                    ListNode prev = dummyHead, curr = dummyHead.next;
//                    while (curr != null) {
//                        ListNode head1 = curr;
//                        for (int i = 1; i < subLength && curr.next != null; i++) {
//                            curr = curr.next;
//                        }
//                        ListNode head2 = curr.next;
//                        curr.next = null;
//                        curr = head2;
//                        for (int i = 1; i < subLength && curr != null && curr.next != null; i++) {
//                            curr = curr.next;
//                        }
//                        ListNode next = null;
//                        if (curr != null) {
//                            next = curr.next;
//                            curr.next = null;
//                        }
//                        ListNode merged = merge(head1, head2);
//                        prev.next = merged;
//                        while (prev.next != null) {
//                            prev = prev.next;
//                        }
//                        curr = next;
//                    }
//                }
//                return dummyHead.next;
//            }
//
//            public ListNode merge(ListNode head1, ListNode head2) {
//                ListNode dummyHead = new ListNode(0);
//                ListNode temp = dummyHead, temp1 = head1, temp2 = head2;
//                while (temp1 != null && temp2 != null) {
//                    if (temp1.val <= temp2.val) {
//                        temp.next = temp1;
//                        temp1 = temp1.next;
//                    } else {
//                        temp.next = temp2;
//                        temp2 = temp2.next;
//                    }
//                    temp = temp.next;
//                }
//                if (temp1 != null) {
//                    temp.next = temp1;
//                } else if (temp2 != null) {
//                    temp.next = temp2;
//                }
//                return dummyHead.next;
//            }
//        }

    }
    
//    剑指 Offer II 076. 数组中的第 k 大的数字
//    给定整数数组 nums 和整数 k，请返回数组中第 k 个最大的元素。
//    请注意，你需要找的是数组排序后的第 k 个最大的元素，而不是第 k 个不同的元素。
//    示例 1:
//    输入: [3,2,1,5,6,4] 和 k = 2
//    输出: 5
//    示例 2:
//    输入: [3,2,3,1,2,4,5,5,6] 和 k = 4
//    输出: 4
//    提示：
//    1 <= k <= nums.length <= 104
//    -104 <= nums[i] <= 104
//    注意：本题与主站 215 题相同： https://leetcode-cn.com/problems/kth-largest-element-in-an-array/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/xx4gT2
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        return findKthLargest(nums, k, 0, nums.count - 1)
    }
    
    class func findKthLargest(_ nums: [Int], _ k: Int,_ start: Int,_ end: Int) -> Int {
        
        var array = nums
        let index = Int.random(in: start...end)
        array.swapAt(start, index)
        let point = array[start]
        var left = start
        var right = end
        while left < right {
            while left < right {
                if array[right] < point {
                    right -= 1
                }else {
                    array[left] = array[right]
                    left += 1
                    break
                }
            }
            while left < right {
                if array[left] > point {
                    left += 1
                }else {
                    array[right] = array[left]
                    right -= 1
                    break
                }
            }
        }
        array[left] = point
        if k == left + 1 {
            return array[left]
        }else if k > left + 1 {
            return findKthLargest(array, k, left + 1, end)
        }else {
            return findKthLargest(array, k, start, left - 1)
        }
    }
//    剑指 Offer II 074. 合并区间
//    以数组 intervals 表示若干个区间的集合，其中单个区间为 intervals[i] = [starti, endi] 。请你合并所有重叠的区间，并返回一个不重叠的区间数组，该数组需恰好覆盖输入中的所有区间。
//    示例 1：
//    输入：intervals = [[1,3],[2,6],[8,10],[15,18]]
//    输出：[[1,6],[8,10],[15,18]]
//    解释：区间 [1,3] 和 [2,6] 重叠, 将它们合并为 [1,6].
//    示例 2：
//    输入：intervals = [[1,4],[4,5]]
//    输出：[[1,5]]
//    解释：区间 [1,4] 和 [4,5] 可被视为重叠区间。
//    提示：
//    1 <= intervals.length <= 104
//    intervals[i].length == 2
//    0 <= starti <= endi <= 104
//    注意：本题与主站 56 题相同： https://leetcode-cn.com/problems/merge-intervals/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/SsGoHC
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func merge(_ intervals: [[Int]]) -> [[Int]] {
        guard intervals.count > 1 else { return intervals }
        let array = intervals.sorted { a, b in
            if a[0] == b[0] {
                return a[1] > b[1]
            }else {
                return a[0] < b[0]
            }
        }
        
        var result: [[Int]] = []
        var cur = array[0]
        var i = 1
        while i < array.count {
            let next = array[i]
            if next[0] <= cur[1] {
                if next[1] >= cur[1] {
                    cur = [cur[0],next[1]]
                }
            }else {
                result.append(cur)
                cur = next
            }
            if i == array.count - 1 {
                result.append(cur)
            }
            i += 1
        }
        return result
    }
//    剑指 Offer II 073. 狒狒吃香蕉
//    狒狒喜欢吃香蕉。这里有 N 堆香蕉，第 i 堆中有 piles[i] 根香蕉。警卫已经离开了，将在 H 小时后回来。
//    狒狒可以决定她吃香蕉的速度 K （单位：根/小时）。每个小时，她将会选择一堆香蕉，从中吃掉 K 根。如果这堆香蕉少于 K 根，她将吃掉这堆的所有香蕉，然后这一小时内不会再吃更多的香蕉，下一个小时才会开始吃另一堆的香蕉。
//    狒狒喜欢慢慢吃，但仍然想在警卫回来前吃掉所有的香蕉。
//    返回她可以在 H 小时内吃掉所有香蕉的最小速度 K（K 为整数）。
//    示例 1：
//    输入: piles = [3,6,7,11], H = 8
//    输出: 4
//    示例 2：
//    输入: piles = [30,11,23,4,20], H = 5
//    输出: 30
//    示例 3：
//    输入: piles = [30,11,23,4,20], H = 6
//    输出: 23
//    提示：
//    1 <= piles.length <= 10^4
//    piles.length <= H <= 10^9
//    1 <= piles[i] <= 10^9
//    注意：本题与主站 875 题相同： https://leetcode-cn.com/problems/koko-eating-bananas/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/nZZqjQ
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func minEatingSpeed(_ piles: [Int], _ h: Int) -> Int {
        var sum = 0
        var right = 0
        for item in piles {
            sum += item
            right = max(right, item)
        }
        var left = Int(ceil(Double(sum) / Double(h)))
        while left <= right {
            let mid = left + (right - left)/2
            if minEatingSpeedCanEat(piles, h, mid) {
                right = mid - 1
            }else {
                left = mid + 1
            }
        }
        return left
    }
    class func minEatingSpeedCanEat(_ piles: [Int],_ h: Int,_ n: Int) -> Bool {
        var hour = 0
        var i = 0
        while i < piles.count {
            var item = piles[i]
            let tempCount = item / n
            item = item - tempCount * n
            hour += item > 0 ? (tempCount + 1) : tempCount
            i += 1
            if hour > h {
                return false
            }
        }
        return true
    }
//    剑指 Offer II 071. 按权重生成随机数
//    给定一个正整数数组 w ，其中 w[i] 代表下标 i 的权重（下标从 0 开始），请写一个函数 pickIndex ，它可以随机地获取下标 i，选取下标 i 的概率与 w[i] 成正比。
//    例如，对于 w = [1, 3]，挑选下标 0 的概率为 1 / (1 + 3) = 0.25 （即，25%），而选取下标 1 的概率为 3 / (1 + 3) = 0.75（即，75%）。
//    也就是说，选取下标 i 的概率为 w[i] / sum(w) 。
//    示例 1：
//    输入：
//    inputs = ["Solution","pickIndex"]
//    inputs = [[[1]],[]]
//    输出：
//    [null,0]
//    解释：
//    Solution solution = new Solution([1]);
//    solution.pickIndex(); // 返回 0，因为数组中只有一个元素，所以唯一的选择是返回下标 0。
//    示例 2：
//    输入：
//    inputs = ["Solution","pickIndex","pickIndex","pickIndex","pickIndex","pickIndex"]
//    inputs = [[[1,3]],[],[],[],[],[]]
//    输出：
//    [null,1,1,1,1,0]
//    解释：
//    Solution solution = new Solution([1, 3]);
//    solution.pickIndex(); // 返回 1，返回下标 1，返回该下标概率为 3/4 。
//    solution.pickIndex(); // 返回 1
//    solution.pickIndex(); // 返回 1
//    solution.pickIndex(); // 返回 1
//    solution.pickIndex(); // 返回 0，返回下标 0，返回该下标概率为 1/4 。
//    由于这是一个随机问题，允许多个答案，因此下列输出都可以被认为是正确的:
//    [null,1,1,1,1,0]
//    [null,1,1,1,1,1]
//    [null,1,1,1,0,0]
//    [null,1,1,1,0,1]
//    [null,1,0,1,0,0]
//    ......
//    诸若此类。
//    提示：
//    1 <= w.length <= 10000
//    1 <= w[i] <= 10^5
//    pickIndex 将被调用不超过 10000 次
//    注意：本题与主站 528 题相同： https://leetcode-cn.com/problems/random-pick-with-weight/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/cuyjEf
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class Solution111 {
        var sum: Int
        var presum: [Int]
        init(_ w: [Int]) {
            sum = 0
            presum = []
            for item in w {
                sum += item
                presum.append(sum)
            }
        }
//        1234
//       1 3 6 10
        func pickIndex() -> Int {
            let val = Int.random(in: 1...sum)
            var left = 0
            var right = presum.count - 1
            while left <= right {
                let mid = left + (right - left)
                if val > presum[mid] {
                    left = mid + 1
                }else if val < presum[mid] {
                    right = mid - 1
                }else {
                    right = mid - 1
                }
            }
            return left >= presum.count ? left - 1: left
        }
    }
//    剑指 Offer II 070. 排序数组中只出现一次的数字
//    给定一个只包含整数的有序数组 nums ，每个元素都会出现两次，唯有一个数只会出现一次，请找出这个唯一的数字。
//    示例 1:
//    输入: nums = [1,1,2,3,3,4,4,8,8]
//    输出: 2
//    示例 2:
//    输入: nums =  [3,3,7,7,10,11,11]
//    输出: 10
//    提示:
//    1 <= nums.length <= 105
//    0 <= nums[i] <= 105
//    进阶: 采用的方案可以在 O(log n) 时间复杂度和 O(1) 空间复杂度中运行吗？
//    注意：本题与主站 540 题相同：https://leetcode-cn.com/problems/single-element-in-a-sorted-array/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/skFtm2
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func singleNonDuplicate(_ nums: [Int]) -> Int {
//        根据 mid 的奇偶性决定和左边或右边的相邻元素比较：
//        如果 mid 是偶数，则比较 nums[mid] 和 nums[mid+1] 是否相等；
//        如果 mid 是奇数，则比较 nums[mid−1] 和 nums[mid] 是否相等。
//        如果上述比较相邻元素的结果是相等，则 mid<x，调整左边界，否则 mid≥x，调整右边界。调整边界之后继续二分查找，直到确定下标 xx 的值。
        guard nums.count > 1 else { return nums[0] }
        var left = 0
        var right = nums.count - 1
        while left < right {
            let mid = left + (right - left) / 2
            if mid % 2 == 0 {//偶数
                if nums[mid] == nums[mid + 1] {
                    left = mid + 1
                }else {
                    right = mid
                }
            }else {
                if nums[mid - 1] == nums[mid] {
                    //在左边
                    left = mid + 1
                }else {
                    right = mid
                }
            }
        }
        return nums[left]
    }
//    剑指 Offer II 069. 山峰数组的顶部
//    符合下列属性的数组 arr 称为 山峰数组（山脉数组） ：
//    arr.length >= 3
//    存在 i（0 < i < arr.length - 1）使得：
//    arr[0] < arr[1] < ... arr[i-1] < arr[i]
//    arr[i] > arr[i+1] > ... > arr[arr.length - 1]
//    给定由整数组成的山峰数组 arr ，返回任何满足 arr[0] < arr[1] < ... arr[i - 1] < arr[i] > arr[i + 1] > ... > arr[arr.length - 1] 的下标 i ，即山峰顶部。
//    示例 1：
//    输入：arr = [0,1,0]
//    输出：1
//    示例 2：
//    输入：arr = [1,3,5,4,2]
//    输出：2
//    示例 3：
//    输入：arr = [0,10,5,2]
//    输出：1
//    示例 4：
//    输入：arr = [3,4,5,1]
//    输出：2
//    示例 5：
//    输入：arr = [24,69,100,99,79,78,67,36,26,19]
//    输出：2
//    提示：
//    3 <= arr.length <= 104
//    0 <= arr[i] <= 106
//    题目数据保证 arr 是一个山脉数组
//    进阶：很容易想到时间复杂度 O(n) 的解决方案，你可以设计一个 O(log(n)) 的解决方案吗？
//    注意：本题与主站 852 题相同：https://leetcode-cn.com/problems/peak-index-in-a-mountain-array/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/B1IidL
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func peakIndexInMountainArray(_ arr: [Int]) -> Int {
        var left = 0
        var right = arr.count - 1
        while left < right {
            let mid = left + (right - left) / 2
            
            if mid == 0,arr[mid] > arr[mid + 1] {
                return mid
            }
            if mid == arr.count - 1,arr[mid] > arr[mid - 1] {
                return mid
            }
            
            if mid > 0,mid < arr.count - 1 {
                if arr[mid] > arr[mid - 1],arr[mid] > arr[mid + 1] {
                    return mid
                }
            }
            
            if mid > 0 {
                if arr[mid] > arr[mid - 1] {
                    //上
                    left = mid
                }else {
                    //下
                    right = mid
                }
            }else if mid < arr.count - 1 {
                if arr[mid] > arr[mid + 1] {
                    //下
                    right = mid
                }else {
                    left = mid
                }
            }
        }
        return left
    }
    
//    剑指 Offer II 067. 最大的异或
//    给定一个整数数组 nums ，返回 nums[i] XOR nums[j] 的最大运算结果，其中 0 ≤ i ≤ j < n 。
//    示例 1：
//    输入：nums = [3,10,5,25,2,8]
//    输出：28
//    解释：最大运算结果是 5 XOR 25 = 28.
//    示例 2：
//    输入：nums = [0]
//    输出：0
//    示例 3：
//    输入：nums = [2,4]
//    输出：6
//    示例 4：
//    输入：nums = [8,10,2]
//    输出：10
//    示例 5：
//    输入：nums = [14,70,53,83,49,91,36,80,92,51,66,70]
//    输出：127
//    提示：
//    1 <= nums.length <= 2 * 104
//    0 <= nums[i] <= 231 - 1
//    进阶：你可以在 O(n) 的时间解决这个问题吗？
//    注意：本题与主站 421 题相同： https://leetcode-cn.com/problems/maximum-xor-of-two-numbers-in-an-array/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/ms70jA
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func findMaximumXOR(_ nums: [Int]) -> Int {
        // 先确定高位，再确定低位（有点贪心算法的意思），才能保证这道题的最大性质
            // 一位接着一位去确定这个数位的大小
            // 利用性质： a ^ b = c ，则 a ^ c = b，且 b ^ c = a
        var res = 0
        var mask = 0
        var i = 30
        while i >= 0 {
            //注意点1：注意保留前缀的方法，mask 是这样得来的
            mask = mask | (1 << i);
            
            var set = Set<Int>()
            for num in nums {
                set.insert(num & mask)
            }
            // 这里先假定第 n 位为 1 ，前 n-1 位 res 为之前迭代求得
            let temp = res | (1 << i)
            for prefixNum in set {
                if set.contains(prefixNum ^ temp) {
                    res = temp;
                    break
                }
            }
            i -= 1
        }
        return res
    }
    
//    剑指 Offer II 066. 单词之和
//    实现一个 MapSum 类，支持两个方法，insert 和 sum：
//    MapSum() 初始化 MapSum 对象
//    void insert(String key, int val) 插入 key-val 键值对，字符串表示键 key ，整数表示值 val 。如果键 key 已经存在，那么原来的键值对将被替代成新的键值对。
//    int sum(string prefix) 返回所有以该前缀 prefix 开头的键 key 的值的总和。
//    示例：
//    输入：
//    inputs = ["MapSum", "insert", "sum", "insert", "sum"]
//    inputs = [[], ["apple", 3], ["ap"], ["app", 2], ["ap"]]
//    输出：
//    [null, null, 3, null, 5]
//    解释：
//    MapSum mapSum = new MapSum();
//    mapSum.insert("apple", 3);
//    mapSum.sum("ap");           // return 3 (apple = 3)
//    mapSum.insert("app", 2);
//    mapSum.sum("ap");           // return 5 (apple + app = 3 + 2 = 5)
//    提示：
//    1 <= key.length, prefix.length <= 50
//    key 和 prefix 仅由小写英文字母组成
//    1 <= val <= 1000
//    最多调用 50 次 insert 和 sum
//    注意：本题与主站 677 题相同： https://leetcode-cn.com/problems/map-sum-pairs/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/z1R5dt
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class MapSum {
        
        class MapSumNode {
            var val: Int = 0
            var children: [Character: MapSumNode] = [:]
        }
        var root: MapSumNode

        /** Initialize your data structure here. */
        init() {
            root = MapSumNode()
        }
        
        func insert(_ key: String, _ val: Int) {
            let array = Array(key)
            var node = root
            var i = 0
            while i < array.count {
                let ch = array[i]
                if let next = node.children[ch] {
                    node = next
                    if i == array.count - 1 {
                        node.val = val
                    }
                }else {
                    let next = MapSumNode()
                    node.children[ch] = next
                    node = next
                    if i == array.count - 1 {
                        node.val = val
                    }
                }
                i += 1
            }
        }
        
        func sum(_ prefix: String) -> Int {
            let array = Array(prefix)
            var node = root
            var i = 0
            while i < array.count {
                let ch = array[i]
                if let next = node.children[ch] {
                    node = next
                    if i == array.count - 1 {
                        var sum = node.val
                        var queue: [MapSumNode] = Array(node.children.values)
                        var temp: [MapSumNode] = []
                        while !queue.isEmpty {
                            let last = queue.removeLast()
                            sum += last.val
                            temp.append(contentsOf: Array(last.children.values))
                            if queue.isEmpty {
                                queue = temp
                                temp.removeAll()
                            }
                        }
                        return sum
                    }
                }else {
                    break
                }
                i += 1
            }
            return 0
        }
    }
//    剑指 Offer II 065. 最短的单词编码
//    单词数组 words 的 有效编码 由任意助记字符串 s 和下标数组 indices 组成，且满足：
//    words.length == indices.length
//    助记字符串 s 以 '#' 字符结尾
//    对于每个下标 indices[i] ，s 的一个从 indices[i] 开始、到下一个 '#' 字符结束（但不包括 '#'）的 子字符串 恰好与 words[i] 相等
//    给定一个单词数组 words ，返回成功对 words 进行编码的最小助记字符串 s 的长度 。
//    示例 1：
//    输入：words = ["time", "me", "bell"]
//    输出：10
//    解释：一组有效编码为 s = "time#bell#" 和 indices = [0, 2, 5] 。
//    words[0] = "time" ，s 开始于 indices[0] = 0 到下一个 '#' 结束的子字符串，如加粗部分所示 "time#bell#"
//    words[1] = "me" ，s 开始于 indices[1] = 2 到下一个 '#' 结束的子字符串，如加粗部分所示 "time#bell#"
//    words[2] = "bell" ，s 开始于 indices[2] = 5 到下一个 '#' 结束的子字符串，如加粗部分所示 "time#bell#"
//    示例 2：
//    输入：words = ["t"]
//    输出：2
//    解释：一组有效编码为 s = "t#" 和 indices = [0] 。
//    提示：
//    1 <= words.length <= 2000
//    1 <= words[i].length <= 7
//    words[i] 仅由小写字母组成
//    注意：本题与主站 820 题相同： https://leetcode-cn.com/problems/short-encoding-of-words/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/iSwD2y
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func minimumLengthEncoding(_ words: [String]) -> Int {
        class TrieNode {
            var children: [Character:TrieNode] = [:]
            var isEnd: Bool = false
        }
        let root: TrieNode = TrieNode()
        
        func insert(_ word: String) {
            let array = Array(word)
            var node = root
            var i = array.count - 1
            while i >= 0 {
                let ch = array[i]
                if let nextNode = node.children[ch] {
                    if i == array.count - 1 {
                        nextNode.isEnd = true
                    }
                    node = nextNode
                }else {
                    let newNode = TrieNode()
                    node.children[ch] = newNode
                    node = newNode
                    if i == array.count - 1 {
                        newNode.isEnd = true
                    }
                }
                i -= 1
            }
        }
        
        for word in words {
            insert(word)
        }
        var queue: [TrieNode] = Array(root.children.values)
        var s = 0
        var temp: [TrieNode] = []
        var deep = 1
        while !queue.isEmpty {
            let node = queue.removeLast()
            if node.children.isEmpty {
                s += deep + 1
            }else {
                temp.append(contentsOf: Array(node.children.values))
            }
            if queue.isEmpty,!temp.isEmpty {
                deep += 1
                queue = temp
                temp.removeAll()
            }
        }
        return s
    }
    
//    剑指 Offer II 064. 神奇的字典
//    设计一个使用单词列表进行初始化的数据结构，单词列表中的单词 互不相同 。 如果给出一个单词，请判定能否只将这个单词中一个字母换成另一个字母，使得所形成的新单词存在于已构建的神奇字典中。
//    实现 MagicDictionary 类：
//    MagicDictionary() 初始化对象
//    void buildDict(String[] dictionary) 使用字符串数组 dictionary 设定该数据结构，dictionary 中的字符串互不相同
//    bool search(String searchWord) 给定一个字符串 searchWord ，判定能否只将字符串中 一个 字母换成另一个字母，使得所形成的新字符串能够与字典中的任一字符串匹配。如果可以，返回 true ；否则，返回 false 。
//    示例：
//    输入
//    inputs = ["MagicDictionary", "buildDict", "search", "search", "search", "search"]
//    inputs = [[], [["hello", "leetcode"]], ["hello"], ["hhllo"], ["hell"], ["leetcoded"]]
//    输出
//    [null, null, false, true, false, false]
//    解释
//    MagicDictionary magicDictionary = new MagicDictionary();
//    magicDictionary.buildDict(["hello", "leetcode"]);
//    magicDictionary.search("hello"); // 返回 False
//    magicDictionary.search("hhllo"); // 将第二个 'h' 替换为 'e' 可以匹配 "hello" ，所以返回 True
//    magicDictionary.search("hell"); // 返回 False
//    magicDictionary.search("leetcoded"); // 返回 False
//    提示：
//    1 <= dictionary.length <= 100
//    1 <= dictionary[i].length <= 100
//    dictionary[i] 仅由小写英文字母组成
//    dictionary 中的所有字符串 互不相同
//    1 <= searchWord.length <= 100
//    searchWord 仅由小写英文字母组成
//    buildDict 仅在 search 之前调用一次
//    最多调用 100 次 search
//    注意：本题与主站 676 题相同： https://leetcode-cn.com/problems/implement-magic-dictionary/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/US1pGT
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class MagicDictionary {
        class TrieNode {
            var children: [Character:TrieNode] = [:]
            var isEnd: Bool = false
        }
        let root: TrieNode = TrieNode()
        
        func insert(_ word: String) {
            let array = Array(word)
            var node = root
            var i = 0
            while i < array.count {
                let ch = array[i]
                if let nextNode = node.children[ch] {
                    if i == array.count - 1 {
                        nextNode.isEnd = true
                    }
                    node = nextNode
                }else {
                    let newNode = TrieNode()
                    node.children[ch] = newNode
                    node = newNode
                    if i == array.count - 1 {
                        newNode.isEnd = true
                    }
                }
                i += 1
            }
        }
        
        /** Initialize your data structure here. */
        init() {

        }
        
        func buildDict(_ dictionary: [String]) {
            for item in dictionary {
                insert(item)
            }
        }
        
        func search(_ searchWord: [Character],_ index: Int,_ node:TrieNode, _ hasSkip: Bool) -> Bool {
            let ch = searchWord[index]
            if let next = node.children[ch] {
                if index == searchWord.count - 1 {
                    if next.isEnd,hasSkip {
                        return true
                    }
                }else {
                    if search(searchWord, index + 1,next , hasSkip) {
                        return true
                    }
                }
            }
            if !hasSkip {
                for (key,val) in node.children {
                    if ch == key {
                        continue
                    }
                    if index == searchWord.count - 1,val.isEnd {
                        return true
                    }
                    if index + 1 < searchWord.count, search(searchWord, index + 1, val, true) {
                        return true
                    }
                }
            }
            return false
        }
        
        func search(_ searchWord: String) -> Bool {
            return search(Array(searchWord), 0,root, false)
        }
    }
//    剑指 Offer II 063. 替换单词
//    在英语中，有一个叫做 词根(root) 的概念，它可以跟着其他一些词组成另一个较长的单词——我们称这个词为 继承词(successor)。例如，词根an，跟随着单词 other(其他)，可以形成新的单词 another(另一个)。
//    现在，给定一个由许多词根组成的词典和一个句子，需要将句子中的所有继承词用词根替换掉。如果继承词有许多可以形成它的词根，则用最短的词根替换它。
//    需要输出替换之后的句子。
//    示例 1：
//    输入：dictionary = ["cat","bat","rat"], sentence = "the cattle was rattled by the battery"
//    输出："the cat was rat by the bat"
//    示例 2：
//    输入：dictionary = ["a","b","c"], sentence = "aadsfasf absbs bbab cadsfafs"
//    输出："a a b c"
//    示例 3：
//    输入：dictionary = ["a", "aa", "aaa", "aaaa"], sentence = "a aa a aaaa aaa aaa aaa aaaaaa bbb baba ababa"
//    输出："a a a a a a a a bbb baba a"
//    示例 4：
//    输入：dictionary = ["catt","cat","bat","rat"], sentence = "the cattle was rattled by the battery"
//    输出："the cat was rat by the bat"
//    示例 5：
//    输入：dictionary = ["ac","ab"], sentence = "it is abnormal that this solution is accepted"
//    输出："it is ab that this solution is ac"
//    提示：
//    1 <= dictionary.length <= 1000
//    1 <= dictionary[i].length <= 100
//    dictionary[i] 仅由小写字母组成。
//    1 <= sentence.length <= 10^6
//    sentence 仅由小写字母和空格组成。
//    sentence 中单词的总量在范围 [1, 1000] 内。
//    sentence 中每个单词的长度在范围 [1, 1000] 内。
//    sentence 中单词之间由一个空格隔开。
//    sentence 没有前导或尾随空格。
//    注意：本题与主站 648 题相同： https://leetcode-cn.com/problems/replace-words/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/UhWRSj
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func replaceWords(_ dictionary: [String], _ sentence: String) -> String {
        class Trie {
            class TrieNode {
                var children: [Character:TrieNode] = [:]
                var isEnd: Bool = false
            }
            let root: TrieNode = TrieNode()
            /** Initialize your data structure here. */
            init() {

            }
            
            /** Inserts a word into the trie. */
            func insert(_ word: String) {
                let array = Array(word)
                var node = root
                var i = 0
                while i < array.count {
                    let ch = array[i]
                    if let nextNode = node.children[ch] {
                        if i == array.count - 1 {
                            nextNode.isEnd = true
                        }
                        node = nextNode
                    }else {
                        let newNode = TrieNode()
                        node.children[ch] = newNode
                        node = newNode
                        if i == array.count - 1 {
                            newNode.isEnd = true
                        }
                    }
                    i += 1
                }
            }
            
            /** Returns if the word is in the trie. */
            func search(_ word: String) -> String {
                let array = Array(word)
                var node = root
                var res: [Character] = []
                var i = 0
                while i < array.count {
                    let ch = array[i]
                    if let nextNode = node.children[ch] {
                        res.append(ch)
                        if nextNode.isEnd {
                            return String(res)
                        }
                        node = nextNode
                    }else {
                        break
                    }
                    i += 1
                }
                return ""
            }
        }
        
        let trie = Trie()
        for item in dictionary {
            trie.insert(item)
        }
        var array: [String] = sentence.split(separator: " ").map {String($0)}
        var i = 0
        while i < array.count {
            let item = array[i]
            let str = trie.search(item)
            if !str.isEmpty {
                array[i] = str
            }
            i += 1
        }
        return array.joined(separator: " ")
    }
//    剑指 Offer II 062. 实现前缀树
//    Trie（发音类似 "try"）或者说 前缀树 是一种树形数据结构，用于高效地存储和检索字符串数据集中的键。这一数据结构有相当多的应用情景，例如自动补完和拼写检查。
//    请你实现 Trie 类：
//    Trie() 初始化前缀树对象。
//    void insert(String word) 向前缀树中插入字符串 word 。
//    boolean search(String word) 如果字符串 word 在前缀树中，返回 true（即，在检索之前已经插入）；否则，返回 false 。
//    boolean startsWith(String prefix) 如果之前已经插入的字符串 word 的前缀之一为 prefix ，返回 true ；否则，返回 false 。
//    示例：
//    输入
//    inputs = ["Trie", "insert", "search", "search", "startsWith", "insert", "search"]
//    inputs = [[], ["apple"], ["apple"], ["app"], ["app"], ["app"], ["app"]]
//    输出
//    [null, null, true, false, true, null, true]
//
//    解释
//    Trie trie = new Trie();
//    trie.insert("apple");
//    trie.search("apple");   // 返回 True
//    trie.search("app");     // 返回 False
//    trie.startsWith("app"); // 返回 True
//    trie.insert("app");
//    trie.search("app");     // 返回 True
//    提示：
//    1 <= word.length, prefix.length <= 2000
//    word 和 prefix 仅由小写英文字母组成
//    insert、search 和 startsWith 调用次数 总计 不超过 3 * 104 次
//    注意：本题与主站 208 题相同：https://leetcode-cn.com/problems/implement-trie-prefix-tree/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/QC3q1f
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class Trie {
        class TrieNode {
            var children: [Character:TrieNode] = [:]
            var isEnd: Bool = false
        }
        let root: TrieNode = TrieNode()
        /** Initialize your data structure here. */
        init() {

        }
        
        /** Inserts a word into the trie. */
        func insert(_ word: String) {
            let array = Array(word)
            var node = root
            var i = 0
            while i < array.count {
                let ch = array[i]
                if let nextNode = node.children[ch] {
                    if i == array.count - 1 {
                        nextNode.isEnd = true
                    }
                    node = nextNode
                }else {
                    let newNode = TrieNode()
                    node.children[ch] = newNode
                    node = newNode
                    if i == array.count - 1 {
                        newNode.isEnd = true
                    }
                }
                i += 1
            }
        }
        
        /** Returns if the word is in the trie. */
        func search(_ word: String) -> Bool {
            let array = Array(word)
            var node = root
            var i = 0
            while i < array.count {
                let ch = array[i]
                if let nextNode = node.children[ch] {
                    if i == array.count - 1,nextNode.isEnd {
                        return true
                    }
                    node = nextNode
                }else {
                    break
                }
                i += 1
            }
            return false
        }
        
        /** Returns if there is any word in the trie that starts with the given prefix. */
        func startsWith(_ prefix: String) -> Bool {
            let array = Array(prefix)
            var node = root
            var i = 0
            while i < array.count {
                let ch = array[i]
                if let nextNode = node.children[ch] {
                    if i == array.count - 1 {
                        return true
                    }
                    node = nextNode
                }else {
                    break
                }
                i += 1
            }
            return false
        }
    }
    
//    剑指 Offer II 061. 和最小的 k 个数对
//    给定两个以升序排列的整数数组 nums1 和 nums2 , 以及一个整数 k 。
//    定义一对值 (u,v)，其中第一个元素来自 nums1，第二个元素来自 nums2 。
//    请找到和最小的 k 个数对 (u1,v1),  (u2,v2)  ...  (uk,vk) 。
//    示例 1:
//    输入: nums1 = [1,7,11], nums2 = [2,4,6], k = 3
//    输出: [1,2],[1,4],[1,6]
//    解释: 返回序列中的前 3 对数：
//        [1,2],[1,4],[1,6],[7,2],[7,4],[11,2],[7,6],[11,4],[11,6]
//    示例 2:
//    输入: nums1 = [1,1,2], nums2 = [1,2,3], k = 2
//    输出: [1,1],[1,1]
//    解释: 返回序列中的前 2 对数：
//         [1,1],[1,1],[1,2],[2,1],[1,2],[2,2],[1,3],[1,3],[2,3]
//    示例 3:
//    输入: nums1 = [1,2], nums2 = [3], k = 3
//    输出: [1,3],[2,3]
//    解释: 也可能序列中所有的数对都被返回:[1,3],[2,3]
//    提示:
//    1 <= nums1.length, nums2.length <= 104
//    -109 <= nums1[i], nums2[i] <= 109
//    nums1, nums2 均为升序排列
//    1 <= k <= 1000
//    注意：本题与主站 373 题相同：https://leetcode-cn.com/problems/find-k-pairs-with-smallest-sums/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/qn8gGX
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func kSmallestPairs(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> [[Int]] {
        
//        首先，利用两个数组都是升序的条件，结果中最小的组合肯定是 nums1[0] + nums2[0]。
//        但是，次小的是什么呢？ 是 nums1[0] + nums2[1] 还是 nums1[1] + nums2[0] 呢？我们不知道。
//        所以，我们需要设计一种比较方式使我们能知道上述比较的结果，使用优先级队列就可以解决。
//        假设，我们以 [0, 1] 表示 nums1[0] + nums2[1] 的结果，整个过程的处理如下：
//        先把所有的 nums1 的索引入队，即入队的元素有 [0, 0]、[1, 0]、[2, 0]、[3, 0]、......
//        首次弹出的肯定是 [0, 0]，再把 [0, 1] 入队；
//        这样就可以通过优先级队列比较 [0, 1] 和 [1, 0] 的结果，再弹出较小者；
//        依次进行，进行 k 轮
        
        
        
        let pq = PriorityQueue<[Int]>(k) { (a,b) in
            let sum1 = nums1[a[0]] + nums2[a[1]]
            let sum2 = nums1[b[0]] + nums2[b[1]]
            if sum1 >= sum2 {
                return ComparisonResult.orderedAscending
            }
            return ComparisonResult.orderedDescending
        }
        var res: [[Int]] = []
        var kk = k
        var i = 0
        let min = min(k, nums1.count)
        while i < min {
            pq.offer([i, 0])
            i += 1
        }
        while kk > 0 && !pq.isEmpty {
            let e = pq.poll()
            res.append([nums1[e[0]],nums2[e[1]]])
            if e[1] + 1 < nums2.count {
                pq.offer([e[0],e[1] + 1])
            }
            kk -= 1
        }
        return res
    }
//    剑指 Offer II 060. 出现频率最高的 k 个数字
//    给定一个整数数组 nums 和一个整数 k ，请返回其中出现频率前 k 高的元素。可以按 任意顺序 返回答案。
//    示例 1:
//    输入: nums = [1,1,1,2,2,3], k = 2
//    输出: [1,2]
//    示例 2:
//    输入: nums = [1], k = 1
//    输出: [1]
//    提示：
//    1 <= nums.length <= 105
//    k 的取值范围是 [1, 数组中不相同的元素的个数]
//    题目数据保证答案唯一，换句话说，数组中前 k 个高频元素的集合是唯一的
//    进阶：所设计算法的时间复杂度 必须 优于 O(n log n) ，其中 n 是数组大小。
//    注意：本题与主站 347 题相同：https://leetcode-cn.com/problems/top-k-frequent-elements/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/g5c51o
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        class LittleHeap {
            class LittleHeapNode {
                var num: Int
                var count: Int
                init(_ num: Int,_ count: Int) {
                    self.num = num
                    self.count = count
                }
            }
            var array: [LittleHeapNode] = []
            var topCount: Int {
                return array[0].count
            }
            var count: Int {
                return array.count
            }
            var result: [Int] {
                var res: [Int] = []
                for item in array {
                    res.append(item.num)
                }
                return res
            }
            func push(_ num: Int,_ numCount: Int) {
                array.append(LittleHeapNode(num, numCount))
                siftUp(array.count - 1)
            }
            func replaceTop(_ num: Int,_ numCount: Int) {
                array[0] = LittleHeapNode(num, numCount)
                siftDown(0)
            }
            func siftDown(_ i: Int) {
                var index = i
                let size = array.count / 2
                let node = array[index]
                while index < size {
                    var childIndex = index * 2 + 1
                    var child = array[childIndex]
                    let rightChildIndex = childIndex + 1
                    if rightChildIndex < array.count,array[rightChildIndex].count < child.count {
                        childIndex = rightChildIndex
                        child = array[rightChildIndex]
                    }
                    if child.count > node.count {
                        break
                    }
                    array[index] = child
                    index = childIndex
                }
                array[index] = node
            }
            func siftUp(_ i: Int) {
                var index = i
                let node = array[index]
                while index > 0 {
                    let parentIndex = (index - 1) / 2
                    let parent = array[parentIndex]
                    if parent.count < node.count {
                        break
                    }
                    array[index] = parent
                    index = parentIndex
                }
                array[index] = node
            }
        }
        
        
        var dic:[Int: Int] = [:]
        for num in nums {
            dic[num,default: 0] += 1
        }
        let heap = LittleHeap()
        for (num,count) in dic {
            if heap.count < k {
                heap.push(num, count)
            }else {
                if count > heap.topCount {
                    heap.replaceTop(num, count)
                }
            }
        }
        return heap.result
    }
//    剑指 Offer II 058. 日程表
//    请实现一个 MyCalendar 类来存放你的日程安排。如果要添加的时间内没有其他安排，则可以存储这个新的日程安排。
//    MyCalendar 有一个 book(int start, int end)方法。它意味着在 start 到 end 时间内增加一个日程安排，注意，这里的时间是半开区间，即 [start, end), 实数 x 的范围为，  start <= x < end。
//    当两个日程安排有一些时间上的交叉时（例如两个日程安排都在同一时间内），就会产生重复预订。
//    每次调用 MyCalendar.book方法时，如果可以将日程安排成功添加到日历中而不会导致重复预订，返回 true。否则，返回 false 并且不要将该日程安排添加到日历中。
//    请按照以下步骤调用 MyCalendar 类: MyCalendar cal = new MyCalendar(); MyCalendar.book(start, end)
//    示例:
//    输入:
//    ["MyCalendar","book","book","book"]
//    [[],[10,20],[15,25],[20,30]]
//    输出: [null,true,false,true]
//    解释:
//    MyCalendar myCalendar = new MyCalendar();
//    MyCalendar.book(10, 20); // returns true
//    MyCalendar.book(15, 25); // returns false ，第二个日程安排不能添加到日历中，因为时间 15 已经被第一个日程安排预定了
//    MyCalendar.book(20, 30); // returns true ，第三个日程安排可以添加到日历中，因为第一个日程安排并不包含时间 20
//    提示：
//    每个测试用例，调用 MyCalendar.book 函数最多不超过 1000次。
//    0 <= start < end <= 109
//    注意：本题与主站 729 题相同： https://leetcode-cn.com/problems/my-calendar-i/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/fi9suh
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class MyCalendar {
        class CalendarBST {
            class CalendarNode {
                var start: Int
                var end: Int
                var left: CalendarNode?
                var right: CalendarNode?
                init(_ start: Int,_ end: Int) {
                    self.start = start
                    self.end = end
                }
            }
            var root: CalendarNode?
            func add(_ start: Int,_ end: Int) -> Bool {
                if root == nil {
                    root = CalendarNode(start, end)
                    return true
                }else {
                    var node = root
                    while node != nil {
                        if start >= node!.end {
                            //右侧找
                            if node?.right == nil {
                                node?.right = CalendarNode(start, end)
                                return true
                            }else {
                                node = node?.right
                            }
                        }else if end <= node!.start{
                            //左侧找
                            if node?.left == nil {
                                node?.left = CalendarNode(start, end)
                                return true
                            }else {
                                node = node?.left
                            }
                        }else {
                            return false
                        }
                    }
                }
                return true
            }
        }
        var bst:CalendarBST = CalendarBST()
        init() {

        }
        
        func book(_ start: Int, _ end: Int) -> Bool {
            return bst.add(start, end)
        }
    }
//    剑指 Offer II 057. 值和下标之差都在给定的范围内
//    给你一个整数数组 nums 和两个整数 k 和 t 。请你判断是否存在 两个不同下标 i 和 j，使得 abs(nums[i] - nums[j]) <= t ，同时又满足 abs(i - j) <= k 。
//    如果存在则返回 true，不存在返回 false。
//    示例 1：
//    输入：nums = [1,2,3,1], k = 3, t = 0
//    输出：true
//    示例 2：
//    输入：nums = [1,0,1,1], k = 1, t = 2
//    输出：true
//    示例 3：
//    输入：nums = [1,5,9,1,5,9], k = 2, t = 3
//    输出：false
//    提示：
//    0 <= nums.length <= 2 * 104
//    -231 <= nums[i] <= 231 - 1
//    0 <= k <= 104
//    0 <= t <= 231 - 1
//    注意：本题与主站 220 题相同： https://leetcode-cn.com/problems/contains-duplicate-iii/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/7WqeDu
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func containsNearbyAlmostDuplicate(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
        //桶排序
//        我们可以设定桶的大小为 t + 1。如果两个元素同属一个桶，那么这两个元素必然符合条件。
//        如果两个元素属于相邻桶，那么我们需要校验这两个元素是否差值不超过 t。
//        如果两个元素既不属于同一个桶，也不属于相邻桶，那么这两个元素必然不符合条件。

//        实现方面，我们将 {int} 范围内的每一个整数 x 表示为 x = (t + 1) * a + b(0≤b≤t) 的形式，这样 x 即归属于编号为 a 的桶。因为一个桶内至多只会有一个元素，所以我们使用哈希表实现即可。
        var tongs: [Int:Int] = [:] //第几个桶 ： 桶最多一个元素下标
        var i = 0
        while i < nums.count {
            let num = nums[i]
            let index = indexHelper(num, t + 1)
            if let _ = tongs[index] {
                //桶里有元素
                return true
            }
            if let nextTongNum = tongs[index + 1],abs(nextTongNum - num) <= t {//下一个桶有元素,比较
                return true
            }
            if let prevTongNum = tongs[index - 1],abs(prevTongNum - num) <= t {//上一个桶有元素,比较
                return true
            }
            tongs[index] = num
            if i >= k {//通过k维护窗口
                tongs.removeValue(forKey: indexHelper(nums[i - k], t + 1))
            }
            i += 1
        }
        return false
    }
    
    class func indexHelper(_ num: Int,_ w: Int) -> Int {
        if num >= 0 {
            return num / w
        }
        return (num + 1) / w - 1
    }
    
//    剑指 Offer II 055. 二叉搜索树迭代器
//    实现一个二叉搜索树迭代器类BSTIterator ，表示一个按中序遍历二叉搜索树（BST）的迭代器：
//    BSTIterator(TreeNode root) 初始化 BSTIterator 类的一个对象。BST 的根节点 root 会作为构造函数的一部分给出。指针应初始化为一个不存在于 BST 中的数字，且该数字小于 BST 中的任何元素。
//    boolean hasNext() 如果向指针右侧遍历存在数字，则返回 true ；否则返回 false 。
//    int next()将指针向右移动，然后返回指针处的数字。
//    注意，指针初始化为一个不存在于 BST 中的数字，所以对 next() 的首次调用将返回 BST 中的最小元素。
//    可以假设 next() 调用总是有效的，也就是说，当调用 next() 时，BST 的中序遍历中至少存在一个下一个数字。
//    示例：
//    输入
//    inputs = ["BSTIterator", "next", "next", "hasNext", "next", "hasNext", "next", "hasNext", "next", "hasNext"]
//    inputs = [[[7, 3, 15, null, null, 9, 20]], [], [], [], [], [], [], [], [], []]
//    输出
//    [null, 3, 7, true, 9, true, 15, true, 20, false]
//    解释
//    BSTIterator bSTIterator = new BSTIterator([7, 3, 15, null, null, 9, 20]);
//    bSTIterator.next();    // 返回 3
//    bSTIterator.next();    // 返回 7
//    bSTIterator.hasNext(); // 返回 True
//    bSTIterator.next();    // 返回 9
//    bSTIterator.hasNext(); // 返回 True
//    bSTIterator.next();    // 返回 15
//    bSTIterator.hasNext(); // 返回 True
//    bSTIterator.next();    // 返回 20
//    bSTIterator.hasNext(); // 返回 False
//    提示：
//    树中节点的数目在范围 [1, 105] 内
//    0 <= Node.val <= 106
//    最多调用 105 次 hasNext 和 next 操作
//    进阶：
//    你可以设计一个满足下述条件的解决方案吗？next() 和 hasNext() 操作均摊时间复杂度为 O(1) ，并使用 O(h) 内存。其中 h 是树的高度。
//    注意：本题与主站 173 题相同： https://leetcode-cn.com/problems/binary-search-tree-iterator/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/kTOapQ
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
//        7
//       3 15
//        9  20
    class BSTIterator {
        var stack: [TreeNode]
        var visited: Set<UInt> = []
        
        init(_ root: TreeNode?) {
            stack = [root!]
            var node = root!
            visited.insert(nodeAddr(&node))
        }
        
        func next() -> Int {
            while !stack.isEmpty {
                let node = stack.last!
                if var left = node.left ,!visited.contains(nodeAddr(&left)){
                    stack.append(left)
                    visited.insert(nodeAddr(&left))
                }else {
                    let last = stack.removeLast()
                    if var right = last.right,!visited.contains(nodeAddr(&right))  {
                        stack.append(right)
                        visited.insert(nodeAddr(&right))
                    }
                    return last.val
                }
            }
            return -1
        }
        
        func hasNext() -> Bool {
            return !stack.isEmpty
        }
        
        func nodeAddr(_ node: inout TreeNode) -> UInt {
            return withUnsafePointer(to: &node) { UnsafeRawPointer($0)}.load(as: UInt.self)
        }
    }
    
//    剑指 Offer II 054. 所有大于等于节点的值之和
//    给定一个二叉搜索树，请将它的每个节点的值替换成树中大于或者等于该节点值的所有节点值之和。
//    提醒一下，二叉搜索树满足下列约束条件：
//    节点的左子树仅包含键 小于 节点键的节点。
//    节点的右子树仅包含键 大于 节点键的节点。
//    左右子树也必须是二叉搜索树。
//    示例 1：
//    输入：root = [4,1,6,0,2,5,7,null,null,null,3,null,null,null,8]
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
//    树中的节点数介于 0 和 104 之间。
//    每个节点的值介于 -104 和 104 之间。
//    树中的所有值 互不相同 。
//    给定的树为二叉搜索树。
//    注意：
//    本题与主站 538 题相同： https://leetcode-cn.com/problems/convert-bst-to-greater-tree/
//    本题与主站 1038 题相同：https://leetcode-cn.com/problems/binary-search-tree-to-greater-sum-tree/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/w6cpku
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func convertBST(_ root: TreeNode?) -> TreeNode? {
        guard var node = root else { return root }
        var stack = [node]
        var visited = Set([nodeAddress(&node)])
        var sum = 0
        while !stack.isEmpty {
            let n = stack.last!
            if var right = n.right , !visited.contains(nodeAddress(&right)) {
                visited.insert(nodeAddress(&right))
                stack.append(right)
            }else {
                let last = stack.removeLast()
                sum += last.val
                last.val = sum
                if var left = last.left, !visited.contains(nodeAddress(&left)){
                    visited.insert(nodeAddress(&left))
                    stack.append(left)
                }
            }
        }
        return node
    }
    
    class func nodeAddress(_ node: inout TreeNode) -> UInt {
        return withUnsafePointer(to: &node) { UnsafeRawPointer($0)}.load(as: UInt.self)
    }
    
//    剑指 Offer II 053. 二叉搜索树中的中序后继
//    给定一棵二叉搜索树和其中的一个节点 p ，找到该节点在树中的中序后继。如果节点没有中序后继，请返回 null 。
//    节点 p 的后继是值比 p.val 大的节点中键值最小的节点，即按中序遍历的顺序节点 p 的下一个节点。
//    示例 1：
//    输入：root = [2,1,3], p = 1
//    输出：2
//    解释：这里 1 的中序后继是 2。请注意 p 和返回值都应是 TreeNode 类型。
//    示例 2：
//    输入：root = [5,3,6,2,4,null,null,1], p = 6
//    输出：null
//    解释：因为给出的节点没有中序后继，所以答案就返回 null 了。
//    提示：
//    树中节点的数目在范围 [1, 104] 内。
//    -105 <= Node.val <= 105
//    树中各节点的值均保证唯一。
//    注意：本题与主站 285 题相同： https://leetcode-cn.com/problems/inorder-successor-in-bst/
    class func inorderSuccessor(_ root: TreeNode?, _ p: TreeNode?) -> TreeNode? {
        guard let node = root,let pp = p else {return nil}
        var stack = [node]
        var visited = Set([node.val])
        while !stack.isEmpty {
            let node = stack.last!
            if let left = node.left,!visited.contains(left.val) {
                visited.insert(left.val)
                stack.append(left)
            }else {
                let last = stack.removeLast()
                //访问last
                if let right = node.right,!visited.contains(right.val) {
                    visited.insert(right.val)
                    stack.append(right)
                }
                if !stack.isEmpty && last.val == pp.val {
                    var n = stack.last!
                    if n.val == last.right?.val {
                        while n.left != nil {
                            n = n.left!
                        }
                        return n
                    }else {
                        return n
                    }
                }
            }
        }
        return nil
    }
//    剑指 Offer II 050. 向下的路径节点之和
//    给定一个二叉树的根节点 root ，和一个整数 targetSum ，求该二叉树里节点值之和等于 targetSum 的 路径 的数目。
//    路径 不需要从根节点开始，也不需要在叶子节点结束，但是路径方向必须是向下的（只能从父节点到子节点）。
//    示例 1：
//    输入：root = [10,5,-3,3,2,null,11,3,-2,null,1], targetSum = 8
//    输出：3
//    解释：和等于 8 的路径有 3 条，如图所示。
//    示例 2：
//    输入：root = [5,4,8,11,null,13,4,7,2,null,null,5,1], targetSum = 22
//    输出：3
//    提示:
//    二叉树的节点个数的范围是 [0,1000]
//    -109 <= Node.val <= 109
//    -1000 <= targetSum <= 1000
//    注意：本题与主站 437 题相同：https://leetcode-cn.com/problems/path-sum-iii/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/6eUYwP
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func pathSum(_ root: TreeNode?, _ targetSum: Int) -> Int {
        guard let node = root else { return 0 }
        var res = 0
        res += pathSumHelper(node, targetSum)
        res += pathSum(node.left, targetSum)
        res += pathSum(node.right, targetSum)
        return res
    }

    class func pathSumHelper(_ root: TreeNode?, _ targetSum: Int) -> Int {
        guard let node = root else { return 0 }
        var res = 0
        if node.val == targetSum {
            res += 1
        }
        if let left = node.left {
            res += pathSumHelper(left, targetSum - node.val)
        }
        if let right = node.right {
            res += pathSumHelper(right, targetSum - node.val)
        }
        return res
    }
    
//    剑指 Offer II 049. 从根节点到叶节点的路径数字之和
//    给定一个二叉树的根节点 root ，树中每个节点都存放有一个 0 到 9 之间的数字。
//    每条从根节点到叶节点的路径都代表一个数字：
//    例如，从根节点到叶节点的路径 1 -> 2 -> 3 表示数字 123 。
//    计算从根节点到叶节点生成的 所有数字之和 。
//    叶节点 是指没有子节点的节点。
//    示例 1：
//    输入：root = [1,2,3]
//    输出：25
//    解释：
//    从根到叶子节点路径 1->2 代表数字 12
//    从根到叶子节点路径 1->3 代表数字 13
//    因此，数字总和 = 12 + 13 = 25
//    示例 2：
//    输入：root = [4,9,0,5,1]
//    输出：1026
//    解释：
//    从根到叶子节点路径 4->9->5 代表数字 495
//    从根到叶子节点路径 4->9->1 代表数字 491
//    从根到叶子节点路径 4->0 代表数字 40
//    因此，数字总和 = 495 + 491 + 40 = 1026
//    提示：
//    树中节点的数目在范围 [1, 1000] 内
//    0 <= Node.val <= 9
//    树的深度不超过 10
//    注意：本题与主站 129 题相同： https://leetcode-cn.com/problems/sum-root-to-leaf-numbers/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/3Etpl5
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func sumNumbers(_ root: TreeNode?) -> Int {
        guard let node = root else { return 0 }
        var sum = 0
        sumNumbersHelper(node, &sum, 0)
        return sum
    }
    class func sumNumbersHelper(_ node: TreeNode,_ sum: inout Int,_ lei: Int) {
        let val = lei * 10 + node.val
        if node.left == nil && node.right == nil {
            sum += val
            return
        }
        if let left = node.left {
            sumNumbersHelper(left, &sum, val)
        }
        if let right = node.right {
            sumNumbersHelper(right, &sum, val)
        }
    }
//    剑指 Offer II 047. 二叉树剪枝
//    给定一个二叉树 根节点 root ，树的每个节点的值要么是 0，要么是 1。请剪除该二叉树中所有节点的值为 0 的子树。
//    节点 node 的子树为 node 本身，以及所有 node 的后代。
//    示例 1:
//    输入: [1,null,0,0,1]
//    输出: [1,null,0,null,1]
//    解释:
//    只有红色节点满足条件“所有不包含 1 的子树”。
//    右图为返回的答案。
//    示例 2:
//    输入: [1,0,1,0,0,0,1]
//    输出: [1,null,1,null,1]
//    解释:
//    示例 3:
//    输入: [1,1,0,1,1,0,1,0]
//    输出: [1,1,0,1,1,null,1]
//    解释:
//    提示:
//    二叉树的节点个数的范围是 [1,200]
//    二叉树节点的值只会是 0 或 1
//    注意：本题与主站 814 题相同：https://leetcode-cn.com/problems/binary-tree-pruning/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/pOCWxh
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func pruneTree(_ root: TreeNode?) -> TreeNode? {
        guard let node = root else { return root }
        return pruneTreeHelper(node) ? nil : node
    }
    
    class func pruneTreeHelper(_ root: TreeNode) -> Bool {
        if let left = root.left,let right = root.right {
            let leftCanCut = pruneTreeHelper(left)
            let rightCanCut = pruneTreeHelper(right)
            if leftCanCut {
                root.left = nil
            }
            if rightCanCut {
                root.right = nil
            }
            return leftCanCut && rightCanCut && root.val == 0
        }else if let left = root.left {
            let leftCanCut = pruneTreeHelper(left)
            if leftCanCut {
                root.left = nil
            }
            return leftCanCut && root.val == 0
        }else if let right = root.right {
            let rightCanCut = pruneTreeHelper(right)
            if rightCanCut {
                root.right = nil
            }
            return rightCanCut && root.val == 0
        }
        return root.val == 0
    }
//    剑指 Offer II 046. 二叉树的右侧视图
//    给定一个二叉树的 根节点 root，想象自己站在它的右侧，按照从顶部到底部的顺序，返回从右侧所能看到的节点值。
//    示例 1:
//    输入: [1,2,3,null,5,null,4]
//    输出: [1,3,4]
//    示例 2:
//    输入: [1,null,3]
//    输出: [1,3]
//    示例 3:
//    输入: []
//    输出: []
//    提示:
//    二叉树的节点个数的范围是 [0,100]
//    -100 <= Node.val <= 100
//    注意：本题与主站 199 题相同：https://leetcode-cn.com/problems/binary-tree-right-side-view/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/WNC0Lk
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func rightSideView(_ root: TreeNode?) -> [Int] {
        guard let node = root else { return [] }
        var stack: [TreeNode] = [node]
        var res: [Int] = []
        while !stack.isEmpty {
            let size = stack.count
            var i = 0
            while i < size {
                let node = stack.removeFirst()
                if i == size - 1 {
                    res.append(node.val)
                }
                if let left = node.left {
                    stack.append(left)
                }
                if let right = node.right {
                    stack.append(right)
                }
                i += 1
            }
        }
        return res
    }
    
//    剑指 Offer II 045. 二叉树最底层最左边的值
//    给定一个二叉树的 根节点 root，请找出该二叉树的 最底层 最左边 节点的值。
//    假设二叉树中至少有一个节点。
//    示例 1:
//    输入: root = [2,1,3]
//    输出: 1
//    示例 2:
//    输入: [1,2,3,4,null,5,6,null,null,7]
//    输出: 7
//    提示:
//    二叉树的节点个数的范围是 [1,104]
//    -231 <= Node.val <= 231 - 1
//    注意：本题与主站 513 题相同： https://leetcode-cn.com/problems/find-bottom-left-tree-value/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/LwUNpT
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func findBottomLeftValue(_ root: TreeNode?) -> Int {
        var stack = [root!]
        var bootomLeft = root!.val
        while !stack.isEmpty {
            let size = stack.count
            var i = 0
            while i < size {
                let node = stack.removeFirst()
                if i == 0 {
                    bootomLeft = node.val
                }
                if let left = node.left {
                    stack.append(left)
                }
                if let right = node.right {
                    stack.append(right)
                }
                i += 1
            }
        }
        return bootomLeft
    }
//    剑指 Offer II 044. 二叉树每层的最大值
//    给定一棵二叉树的根节点 root ，请找出该二叉树中每一层的最大值。
//    示例1：
//    输入: root = [1,3,2,5,3,null,9]
//    输出: [1,3,9]
//    解释:
//              1
//             / \
//            3   2
//           / \   \
//          5   3   9
//    示例2：
//    输入: root = [1,2,3]
//    输出: [1,3]
//    解释:
//              1
//             / \
//            2   3
//    示例3：
//    输入: root = [1]
//    输出: [1]
//    示例4：
//    输入: root = [1,null,2]
//    输出: [1,2]
//    解释:
//               1
//                \
//                 2
//    示例5：
//    输入: root = []
//    输出: []
//    提示：
//    二叉树的节点个数的范围是 [0,104]
//    -231 <= Node.val <= 231 - 1
//    注意：本题与主站 515 题相同： https://leetcode-cn.com/problems/find-largest-value-in-each-tree-row/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/hPov7L
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func largestValues(_ root: TreeNode?) -> [Int] {
        guard let node = root else { return [] }
        var stack: [TreeNode] = [node]
        var temp: [TreeNode] = []
        var res: [Int] = []
        var maxVal = Int.min
        while !stack.isEmpty {
            let n = stack.removeLast()
            maxVal = max(maxVal,n.val)
            if let left = n.left {
                temp.append(left)
            }
            if let right = n.right {
                temp.append(right)
            }
            if stack.isEmpty {
                res.append(maxVal)
                maxVal = Int.min
                stack = temp
                temp = []
            }
        }
        return res
    }
//    剑指 Offer II 107. 矩阵中的距离
//    给定一个由 0 和 1 组成的矩阵 mat ，请输出一个大小相同的矩阵，其中每一个格子是 mat 中对应位置元素到最近的 0 的距离。
//    两个相邻元素间的距离为 1 。
//    示例 1：
//    输入：mat = [[0,0,0],[0,1,0],[0,0,0]]
//    输出：[[0,0,0],[0,1,0],[0,0,0]]
//    示例 2：
//    输入：mat = [[0,0,0],
//                [0,1,0],
//                [1,1,1]]
//    输出：[[0,0,0],[0,1,0],[1,2,1]]
//    提示：
//    m == mat.length
//    n == mat[i].length
//    1 <= m, n <= 104
//    1 <= m * n <= 104
//    mat[i][j] is either 0 or 1.
//    mat 中至少有一个 0
//    注意：本题与主站 542 题相同：https://leetcode-cn.com/problems/01-matrix/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/2bCMpM
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func updateMatrix(_ mat: [[Int]]) -> [[Int]] {
        var res = Array(repeating: Array(repeating: -1, count: mat[0].count), count: mat.count)
        var queue: [[Int]] = []
        var i = 0
        while i < mat.count {
            var j = 0
            while j < mat[0].count {
                let num = mat[i][j]
                if num == 0 {
                    queue.append([i,j])
                    res[i][j] = 0
                }
                j += 1
            }
            i += 1
        }
        var temp: [[Int]] = []
        var step = 1
        let steps = [[0,1],[0,-1],[1,0],[-1,0]]
        while !queue.isEmpty {
            let a = queue.removeLast()
            for item in steps {
                let ii = item[0] + a[0]
                let jj = item[1] + a[1]
                if ii >= 0 && ii < mat.count && jj >= 0 && jj < mat[0].count && res[ii][jj] == -1 {//没访问过
                    res[ii][jj] = step
                    temp.append([ii,jj])
                }
            }
            if queue.isEmpty && !temp.isEmpty {
                step += 1
                queue = temp
                temp = []
            }
        }
        return res
    }
    
//    剑指 Offer II 043. 往完全二叉树添加节点
//    完全二叉树是每一层（除最后一层外）都是完全填充（即，节点数达到最大，第 n 层有 2^(n-1) 个节点）的，并且所有的节点都尽可能地集中在左侧。
//    设计一个用完全二叉树初始化的数据结构 CBTInserter，它支持以下几种操作：
//    CBTInserter(TreeNode root) 使用根节点为 root 的给定树初始化该数据结构；
//    CBTInserter.insert(int v)  向树中插入一个新节点，节点类型为 TreeNode，值为 v 。使树保持完全二叉树的状态，并返回插入的新节点的父节点的值；
//    CBTInserter.get_root() 将返回树的根节点。
//    示例 1：
//    输入：inputs = ["CBTInserter","insert","get_root"], inputs = [[[1]],[2],[]]
//    输出：[null,1,[1,2]]
//    示例 2：
//    输入：inputs = ["CBTInserter","insert","insert","get_root"], inputs = [[[1,2,3,4,5,6]],[7],[8],[]]
//    输出：[null,3,4,[1,2,3,4,5,6,7,8]]
//    提示：
//    最初给定的树是完全二叉树，且包含 1 到 1000 个节点。
//    每个测试用例最多调用 CBTInserter.insert  操作 10000 次。
//    给定节点或插入节点的每个值都在 0 到 5000 之间。
//    注意：本题与主站 919 题相同： https://leetcode-cn.com/problems/complete-binary-tree-inserter/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/NaqhDT
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class CBTInserter {
        var root: TreeNode?
        var deep: Int = 0
        var lastFathers: [TreeNode?] = []
        var lastChildren: [TreeNode?] = []
        init(_ root: TreeNode?) {
            self.root = root
            deep = 1
            var queue: [TreeNode] = [root!]
            lastChildren = queue
            var temp: [TreeNode] = []
            while !queue.isEmpty {
                let node = queue.removeFirst()
                if let left = node.left {
                    temp.append(left)
                }
                if let right = node.right {
                    temp.append(right)
                }
                if queue.isEmpty {
                    if !temp.isEmpty {
                        lastFathers = lastChildren
                        lastChildren = temp
                        queue = temp
                        deep += 1
                        temp = []
                    }
                }
            }
        }
        
        func insert(_ v: Int) -> Int {
            if Int(pow(2.0, Double(deep - 1))) == lastChildren.count {
                //当前是满树
                let father = lastChildren[0]
                father?.left = TreeNode(v)
                lastFathers = lastChildren
                lastChildren = [father?.left]
                deep += 1
                return father!.val
            }else {
                let index = lastChildren.count
                let putLeft = index % 2 == 0 ? true : false
                let fatherIndex = index / 2
                let father = lastFathers[fatherIndex]
                let node = TreeNode(v)
                if putLeft {
                    father?.left = node
                }else {
                    father?.right = node
                }
                lastChildren.append(node)
                return father!.val
            }
        }
        
        func get_root() -> TreeNode? {
            return root
        }
    }
    
//    剑指 Offer II 106. 二分图
//    存在一个 无向图 ，图中有 n 个节点。其中每个节点都有一个介于 0 到 n - 1 之间的唯一编号。
//    给定一个二维数组 graph ，表示图，其中 graph[u] 是一个节点数组，由节点 u 的邻接节点组成。形式上，对于 graph[u] 中的每个 v ，都存在一条位于节点 u 和节点 v 之间的无向边。该无向图同时具有以下属性：
//    不存在自环（graph[u] 不包含 u）。
//    不存在平行边（graph[u] 不包含重复值）。
//    如果 v 在 graph[u] 内，那么 u 也应该在 graph[v] 内（该图是无向图）
//    这个图可能不是连通图，也就是说两个节点 u 和 v 之间可能不存在一条连通彼此的路径。
//    二分图 定义：如果能将一个图的节点集合分割成两个独立的子集 A 和 B ，并使图中的每一条边的两个节点一个来自 A 集合，一个来自 B 集合，就将这个图称为 二分图 。
//    如果图是二分图，返回 true ；否则，返回 false 。
//    示例 1：
//    输入：graph = [[1,2,3],[0,2],[0,1,3],[0,2]]
//    输出：false
//    解释：不能将节点分割成两个独立的子集，以使每条边都连通一个子集中的一个节点与另一个子集中的一个节点。
//    示例 2：
//    输入：graph = [[1,3],[0,2],[1,3],[0,2]]
//    输出：true
//    解释：可以将节点分成两组: {0, 2} 和 {1, 3} 。
//    提示：
//    graph.length == n
//    1 <= n <= 100
//    0 <= graph[u].length < n
//    0 <= graph[u][i] <= n - 1
//    graph[u] 不会包含 u
//    graph[u] 的所有值 互不相同
//    如果 graph[u] 包含 v，那么 graph[v] 也会包含 u
//    注意：本题与主站 785 题相同： https://leetcode-cn.com/problems/is-graph-bipartite/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/vEAB3K
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func isBipartite(_ graph: [[Int]]) -> Bool {
        //DFS
        var A = Set<Int>()
        var B = Set<Int>()
        var stack: [Int] = []
        var i = 0
        while i < graph.count {
            if !A.contains(i) && !B.contains(i) {//这是一个没有分组的点
                if stack.isEmpty {
                    if i == 0 {
                        A.insert(i)
                    }else {
                        B.insert(i)//保证肯定分开放
                    }
                    stack.append(i)
                }
                while !stack.isEmpty {
                    let last = stack.removeLast()
                    let lastInA = A.contains(last)
                    for item in graph[last] {
                        if (lastInA && A.contains(item)) || (!lastInA && B.contains(item)) {
                            //有一个校验不通过就是不能放
                            return false
                        }else {
                            if lastInA && !B.contains(item) {
                                B.insert(item)
                                stack.append(item)
                            }else if !lastInA && !A.contains(item) {
                                A.insert(item)
                                stack.append(item)
                            }
                        }
                    }
                }
            }
            i += 1
        }
        return true
        
        //回溯放置 超时
//        let A: [Int: Int] = [:]
//        let B: [Int: Int] = [:]
//        var array = [A,B]
//        return isBipartiteBack(graph, 0, &array)
    }
    
    class func isBipartiteBack(_ graph: [[Int]],_ index: Int,_ array: inout [[Int: Int]]) -> Bool {
        if index == graph.count {
            return true
        }
        var i = 0
        while i < array.count {
            if index == 0 && i == 1 {
                break;
            }
            var curDic = array[i]
            let otherIndex = i == 0 ? i + 1 : i - 1
            var otherDic = array[otherIndex]
            var canPut = true
            if otherDic[index] != nil {//index不能放
                canPut = false
            }
            if canPut {
                for item in graph[index] {
                    if curDic[item] != nil {
                        canPut = false//有子元素不能放
                        break
                    }
                }
            }
            if canPut {//都能放
                curDic[index,default: 0] += 1
                for item in graph[index] {
                    otherDic[item,default: 0] += 1
                }
                array[i] = curDic
                array[otherIndex] = otherDic
                //验证下一个
                let res = isBipartiteBack(graph, index + 1, &array)
                if res {
                    return res
                }
                //回溯
                curDic[index,default: 0] -= 1
                if curDic[index] == 0 {
                    curDic.removeValue(forKey: index)
                }
                for item in graph[index] {
                    otherDic[item,default: 0] -= 1
                    if otherDic[item] == 0 {
                        otherDic.removeValue(forKey: item)
                    }
                }
                array[i] = curDic
                array[otherIndex] = otherDic
            }
            i += 1
        }
        return false
    }
//    剑指 Offer II 042. 最近请求次数
//    写一个 RecentCounter 类来计算特定时间范围内最近的请求。
//    请实现 RecentCounter 类：
//    RecentCounter() 初始化计数器，请求数为 0 。
//    int ping(int t) 在时间 t 添加一个新请求，其中 t 表示以毫秒为单位的某个时间，并返回过去 3000 毫秒内发生的所有请求数（包括新请求）。确切地说，返回在 [t-3000, t] 内发生的请求数。
//    保证 每次对 ping 的调用都使用比之前更大的 t 值。
//    示例：
//    输入：
//    inputs = ["RecentCounter", "ping", "ping", "ping", "ping"]
//    inputs = [[], [1], [100], [3001], [3002]]
//    输出：
//    [null, 1, 2, 3, 3]
//    解释：
//    RecentCounter recentCounter = new RecentCounter();
//    recentCounter.ping(1);     // requests = [1]，范围是 [-2999,1]，返回 1
//    recentCounter.ping(100);   // requests = [1, 100]，范围是 [-2900,100]，返回 2
//    recentCounter.ping(3001);  // requests = [1, 100, 3001]，范围是 [1,3001]，返回 3
//    recentCounter.ping(3002);  // requests = [1, 100, 3001, 3002]，范围是 [2,3002]，返回 3
//    提示：
//    1 <= t <= 109
//    保证每次对 ping 调用所使用的 t 值都 严格递增
//    至多调用 ping 方法 104 次
//    注意：本题与主站 933 题相同： https://leetcode-cn.com/problems/number-of-recent-calls/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/H8086Q
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class RecentCounter {
        class RecentCounterNode {
            var next: RecentCounterNode?
            var val: Int = 0
            init(_ val: Int) {
                self.val = val
            }
        }
        var head: RecentCounterNode?
        var tail: RecentCounterNode?
        var count = 0
        
        init() {

        }
        
        func ping(_ t: Int) -> Int {
            while count > 0 && head!.val < (t - 3000) {
                head = head?.next
                count -= 1
            }
            
            if count == 0 {
                head = RecentCounterNode(t)
                tail = head
                count += 1
                return count
            }
            
            tail?.next = RecentCounterNode(t)
            tail = tail?.next
            count += 1
            return count
        }
    }
    
//    剑指 Offer II 041. 滑动窗口的平均值
//    给定一个整数数据流和一个窗口大小，根据该滑动窗口的大小，计算滑动窗口里所有数字的平均值。
//    实现 MovingAverage 类：
//    MovingAverage(int size) 用窗口大小 size 初始化对象。
//    double next(int val) 成员函数 next 每次调用的时候都会往滑动窗口增加一个整数，请计算并返回数据流中最后 size 个值的移动平均值，即滑动窗口里所有数字的平均值。
//    示例：
//    输入：
//    inputs = ["MovingAverage", "next", "next", "next", "next"]
//    inputs = [[3], [1], [10], [3], [5]]
//    输出：
//    [null, 1.0, 5.5, 4.66667, 6.0]
//    解释：
//    MovingAverage movingAverage = new MovingAverage(3);
//    movingAverage.next(1); // 返回 1.0 = 1 / 1
//    movingAverage.next(10); // 返回 5.5 = (1 + 10) / 2
//    movingAverage.next(3); // 返回 4.66667 = (1 + 10 + 3) / 3
//    movingAverage.next(5); // 返回 6.0 = (10 + 3 + 5) / 3
//    提示：
//    1 <= size <= 1000
//    -105 <= val <= 105
//    最多调用 next 方法 104 次
//    注意：本题与主站 346 题相同： https://leetcode-cn.com/problems/moving-average-from-data-stream/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/qIsx9U
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class MovingAverage {
        class MovingAverageNode {
            var next: MovingAverageNode?
            var val: Int = 0
            init(_ val: Int) {
                self.val = val
            }
        }
        var avg: Double = 0
        var size: Int
        var count = 0
        var head: MovingAverageNode?
        var tail: MovingAverageNode?
        
        /** Initialize your data structure here. */
        init(_ size: Int) {
            self.size = size
        }
        
        func next(_ val: Int) -> Double {
            if count == 0 {
                head = MovingAverageNode(val)
                tail = head
                count += 1
                avg = Double(val)
                return Double(val)
            }
            var sum = avg * Double(count)
            if count == size {
                sum -= Double(head!.val)
                head = head?.next
                count -= 1
            }
            tail?.next = MovingAverageNode(val)
            tail = tail?.next
            sum += Double(val)
            count += 1
            avg = sum / Double(count)
            return avg
        }
    }
//    剑指 Offer II 105. 岛屿的最大面积
//    给定一个由 0 和 1 组成的非空二维数组 grid ，用来表示海洋岛屿地图。
//    一个 岛屿 是由一些相邻的 1 (代表土地) 构成的组合，这里的「相邻」要求两个 1 必须在水平或者竖直方向上相邻。你可以假设 grid 的四个边缘都被 0（代表水）包围着。
//    找到给定的二维数组中最大的岛屿面积。如果没有岛屿，则返回面积为 0 。
//    示例 1:
//    输入: grid = [[0,0,1,0,0,0,0,1,0,0,0,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,1,1,0,1,0,0,0,0,0,0,0,0],[0,1,0,0,1,1,0,0,1,0,1,0,0],[0,1,0,0,1,1,0,0,1,1,1,0,0],[0,0,0,0,0,0,0,0,0,0,1,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,0,0,0,0,0,0,1,1,0,0,0,0]]
//    输出: 6
//    解释: 对于上面这个给定矩阵应返回 6。注意答案不应该是 11 ，因为岛屿只能包含水平或垂直的四个方向的 1 。
//    示例 2:
//    输入: grid = [[0,0,0,0,0,0,0,0]]
//    输出: 0
//    提示：
//    m == grid.length
//    n == grid[i].length
//    1 <= m, n <= 50
//    grid[i][j] is either 0 or 1
//    注意：本题与主站 695 题相同： https://leetcode-cn.com/problems/max-area-of-island/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/ZL6zAn
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func maxAreaOfIsland(_ grid: [[Int]]) -> Int {
        var grid1 = grid
        var res = 0
        let steps = [(0,1),(0,-1),(1,0),(-1,0)]
        var stack: [(Int,Int)] = []
        var i = 0
        while i < grid1.count {
            var j = 0
            while j < grid1[0].count {
                let num = grid1[i][j]
                var temp = 0
                if num == 1 {
                    temp = 1
                    grid1[i][j] = 0
                    stack.append((i,j))
                }
                while !stack.isEmpty {
                    let num = stack.removeLast()
                    for step in steps {
                        let newI = num.0 + step.0
                        let newJ = num.1 + step.1
                        if newI >= 0 && newI < grid1.count && newJ >= 0 && newJ < grid1[0].count && grid1[newI][newJ] == 1 {
                            temp += 1
                            grid1[newI][newJ] = 0
                            stack.append((newI,newJ))
                        }
                    }
                }
                res = max(res,temp)
                j += 1
            }
            i += 1
        }
        return res
    }
    
    class func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        if list1 == nil {
            return list2
        }
        if list2 == nil {
            return list1
        }
        var n1 = list1
        var n2 = list2
        var head:ListNode? = nil
        var cur:ListNode? = nil
        while n1 != nil || n2 != nil {
            if n1 == nil && n2 != nil {
                cur?.next = n2
                break
            }else if n2 == nil && n1 != nil {
                cur?.next = n1
                break
            }else {
                if head == nil {
                    if n1!.val < n2!.val {
                        head = n1
                        n1 = n1?.next
                        head?.next = nil
                    }else {
                        head = n2
                        n2 = n2?.next
                        head?.next = nil
                    }
                    cur = head
                }else {
                    if n1!.val < n2!.val {
                        cur?.next = n1
                        n1 = n1?.next
                        cur = cur?.next
                    }else {
                        cur?.next = n2
                        n2 = n2?.next
                        cur = cur?.next
                    }
                    cur?.next = nil
                }
            }
        }
        return head
    }
    
//    剑指 Offer II 104. 排列的数目
//    给定一个由 不同 正整数组成的数组 nums ，和一个目标整数 target 。请从 nums 中找出并返回总和为 target 的元素组合的个数。数组中的数字可以在一次排列中出现任意次，但是顺序不同的序列被视作不同的组合。
//    题目数据保证答案符合 32 位整数范围。
//    示例 1：
//    输入：nums = [1,2,3], target = 4
//    输出：7
//    解释：
//    所有可能的组合为：
//    (1, 1, 1, 1)
//    (1, 1, 2)
//    (1, 2, 1)
//    (1, 3)
//    (2, 1, 1)
//    (2, 2)
//    (3, 1)
//    请注意，顺序不同的序列被视作不同的组合。
//    示例 2：
//    输入：nums = [9], target = 3
//    输出：0
//    提示：
//    1 <= nums.length <= 200
//    1 <= nums[i] <= 1000
//    nums 中的所有元素 互不相同
//    1 <= target <= 1000
//    进阶：如果给定的数组中含有负数会发生什么？问题会产生何种变化？如果允许负数出现，需要向题目中添加哪些限制条件？
//    注意：本题与主站 377 题相同：https://leetcode-cn.com/problems/combination-sum-iv/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/D0F0SV
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
        //dp[k] = sum(dp[k-num1]...)
        //dp[0] = 1
        var dp = Array(repeating: 0, count: target + 1)
        dp[0] = 1
        var i = 0
        while i <= target {
            for num in nums {
                if i - num >= 0 && dp[i - num] < Int.max - dp[i]{
                    dp[i] += dp[i - num]
                }
            }
            i += 1
        }
        return dp[target]
    }
    
//    剑指 Offer II 103. 最少的硬币数目
//    给定不同面额的硬币 coins 和一个总金额 amount。编写一个函数来计算可以凑成总金额所需的最少的硬币个数。如果没有任何一种硬币组合能组成总金额，返回 -1。
//    你可以认为每种硬币的数量是无限的。
//    示例 1：
//    输入：coins = [1, 2, 5], amount = 11
//    输出：3
//    解释：11 = 5 + 5 + 1
//    示例 2：
//    输入：coins = [2], amount = 3
//    输出：-1
//    示例 3：
//    输入：coins = [1], amount = 0
//    输出：0
//    示例 4：
//    输入：coins = [1], amount = 1
//    输出：1
//    示例 5：
//    输入：coins = [1], amount = 2
//    输出：2
//    提示：
//    1 <= coins.length <= 12
//    1 <= coins[i] <= 231 - 1
//    0 <= amount <= 104
//    注意：本题与主站 322 题相同： https://leetcode-cn.com/problems/coin-change/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/gaM7Ch
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        //dp[n] = min(dp[n - num1]...) + 1
        //dp[0] = 0
        //dp[num1...] = 1
        var dp = Array(repeating: amount + 1, count: amount + 1)
        dp[0] = 0
        var i = 1
        while i <= amount {
            var j = 0
            while j < coins.count {
                if i - coins[j] >= 0 {
                    dp[i] = min(dp[i], dp[i - coins[j]] + 1)
                }
                j += 1
            }
            i += 1
        }
        return dp[amount] > amount ? -1: dp[amount] 
    }
    
//    剑指 Offer II 072. 求平方根
//    给定一个非负整数 x ，计算并返回 x 的平方根，即实现 int sqrt(int x) 函数。
//    正数的平方根有两个，只输出其中的正数平方根。
//    如果平方根不是整数，输出只保留整数的部分，小数部分将被舍去。
//    示例 1:
//    输入: x = 4
//    输出: 2
//    示例 2:
//    输入: x = 8
//    输出: 2
//    解释: 8 的平方根是 2.82842...，由于小数部分将被舍去，所以返回 2
//    提示:
//    0 <= x <= 231 - 1
//    注意：本题与主站 69 题相同： https://leetcode-cn.com/problems/sqrtx/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/jJ0w9p
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func mySqrt(_ x: Int) -> Int {
        guard x > 1 else { return x }
        var left = 1
        var right = x / 2
        while left <= right {
            let mid = left + (right - left) / 2
            let val = mid * mid
            if val == x {
                return mid
            }else if val > x {
                right = mid - 1
            }else {
                left = mid + 1
            }
        }
        
        if right == 0 {
            return 1
        }else if left == x / 2 {
            return left * left > x ? right : left
        }else {
            return right * right > x ? right - 1: right
        }
    }
//    剑指 Offer II 075. 数组相对排序
//    给定两个数组，arr1 和 arr2，
//    arr2 中的元素各不相同
//    arr2 中的每个元素都出现在 arr1 中
//    对 arr1 中的元素进行排序，使 arr1 中项的相对顺序和 arr2 中的相对顺序相同。未在 arr2 中出现过的元素需要按照升序放在 arr1 的末尾。
//    示例：
//    输入：arr1 = [2,3,1,3,2,4,6,7,9,2,19], arr2 = [2,1,4,3,9,6]
//    输出：[2,2,2,1,4,3,3,9,6,7,19]
//    提示：
//    1 <= arr1.length, arr2.length <= 1000
//    0 <= arr1[i], arr2[i] <= 1000
//    arr2 中的元素 arr2[i] 各不相同
//    arr2 中的每个元素 arr2[i] 都出现在 arr1 中
//    注意：本题与主站 1122 题相同：https://leetcode-cn.com/problems/relative-sort-array/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/0H97ZC
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func relativeSortArray(_ arr1: [Int], _ arr2: [Int]) -> [Int] {
//        [28,6,22,8,44,17]
//        [22,28,8,6]
        var dic:[Int: [Int]] = [:]
        var other: [Int] = []
        let set = Set(arr2)
        for item in arr1 {
            if set.contains(item) {
                var array = dic[item,default: []]
                array.append(item)
                dic[item] = array
            }else {
                other.append(item)
            }
        }
        var res:[Int] = []
        for item in arr2 {
            res.append(contentsOf: dic[item,default: []])
        }
        other.sort()
        res.append(contentsOf: other)
        return res
    }
//    剑指 Offer II 068. 查找插入位置
//    给定一个排序的整数数组 nums 和一个整数目标值 target ，请在数组中找到 target ，并返回其下标。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。
//    请必须使用时间复杂度为 O(log n) 的算法。
//    示例 1:
//    输入: nums = [1,3,5,6], target = 5
//    输出: 2
//    示例 2:
//    输入: nums = [1,3,5,6], target = 2
//    输出: 1
//    示例 3:
//    输入: nums = [1,3,5,6], target = 7
//    输出: 4
//    示例 4:
//    输入: nums = [1,3,5,6], target = 0
//    输出: 0
//    示例 5:
//    输入: nums = [1], target = 0
//    输出: 0
//    提示:
//    1 <= nums.length <= 104
//    -104 <= nums[i] <= 104
//    nums 为无重复元素的升序排列数组
//    -104 <= target <= 104
//    注意：本题与主站 35 题相同： https://leetcode-cn.com/problems/search-insert-position/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/N6YdxV
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var l = 0
        var r = nums.count - 1
        while l <= r {
            let mid = l + (r - l)/2
            let num = nums[mid]
            if num == target {
                return mid
            }else if num > target {
                r = mid - 1
            }else {
                l = mid + 1
            }
        }
        if r < 0 {
            return 0
        }else if l == nums.count {
            return nums.count
        }else {
            if nums[r] > target {
                return r - 1 < 0 ? 0 : r - 1
            }
            return l
        }
    }
    
//    剑指 Offer II 059. 数据流的第 K 大数值
//    设计一个找到数据流中第 k 大元素的类（class）。注意是排序后的第 k 大元素，不是第 k 个不同的元素。
//    请实现 KthLargest 类：
//    KthLargest(int k, int[] nums) 使用整数 k 和整数流 nums 初始化对象。
//    int add(int val) 将 val 插入数据流 nums 后，返回当前数据流中第 k 大的元素。
//    示例：
//    输入：
//    ["KthLargest", "add", "add", "add", "add", "add"]
//    [[3, [4, 5, 8, 2]], [3], [5], [10], [9], [4]]
//    输出：
//    [null, 4, 5, 5, 8, 8]
//    解释：
//    KthLargest kthLargest = new KthLargest(3, [4, 5, 8, 2]);
//    kthLargest.add(3);   // return 4
//    kthLargest.add(5);   // return 5
//    kthLargest.add(10);  // return 5
//    kthLargest.add(9);   // return 8
//    kthLargest.add(4);   // return 8
//    提示：
//    1 <= k <= 104
//    0 <= nums.length <= 104
//    -104 <= nums[i] <= 104
//    -104 <= val <= 104
//    最多调用 add 方法 104 次
//    题目数据保证，在查找第 k 大元素时，数组中至少有 k 个元素
//    注意：本题与主站 703 题相同： https://leetcode-cn.com/problems/kth-largest-element-in-a-stream/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/jBjn9C
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class KthLargest {
         
        class Heap {
            var array:[Int] = []
            var size: Int {
                array.count
            }
            func siftDown(_ index: Int,_ size: Int) {
                let element = array[index]
                let half = size / 2
                var i = index
                while i < half {
                    var childIndex = 2 * i + 1
                    let rightIndex = childIndex + 1
                    var child = array[childIndex]
                    
                    if rightIndex < array.count && child > array[rightIndex] {
                        childIndex = rightIndex
                        child = array[rightIndex]
                    }
                    if element < child {
                        break
                    }
                    array[i] = child
                    i = childIndex
                }
                array[i] = element
            }
            func siftUp(_ index: Int) {
                let element = array[index]
                var i = index
                while i > 0 {
                    let fatherIndex = (i - 1)/2
                    let father = array[fatherIndex]
                    if father < element {
                        break
                    }
                    array[i] = father
                    i = fatherIndex
                }
                array[i] = element
            }
            func push(_ val: Int) {
                array.append(val)
                siftUp(array.count - 1)
            }
            func poll() {
                if !array.isEmpty {
                    array.swapAt(0, array.count - 1)
                    array.removeLast()
                    siftDown(0, array.count)
                }
            }
            func peek() -> Int {
                if array.isEmpty {
                    return -1
                }
                return array[0]
            }
            
        }
        var heap = Heap()
        let k: Int
        init(_ k: Int, _ nums: [Int]) {
            self.k = k
            for item in nums {
                _ = add(item)
            }
        }
        
        func add(_ val: Int) -> Int {
            heap.push(val)
            if heap.size > k {
                heap.poll()
            }
            return heap.peek()
        }
    }
//    public KthLargest(int k, int[] nums) {
//            this.k = k;
//            pq = new PriorityQueue<Integer>();
//            for (int x : nums) {
//                add(x);
//            }
//        }
//
//        public int add(int val) {
//            pq.offer(val);
//            if (pq.size() > k) {
//                pq.poll();
//            }
//            return pq.peek();
//        }

    
//    剑指 Offer II 056. 二叉搜索树中两个节点之和
//    给定一个二叉搜索树的 根节点 root 和一个整数 k , 请判断该二叉搜索树中是否存在两个节点它们的值之和等于 k 。假设二叉搜索树中节点的值均唯一。
//    示例 1：
//    输入: root = [8,6,10,5,7,9,11], k = 12
//    输出: true
//    解释: 节点 5 和节点 7 之和等于 12
//    示例 2：
//    输入: root = [8,6,10,5,7,9,11], k = 22
//    输出: false
//    解释: 不存在两个节点值之和为 22 的节点
//    提示：
//    二叉树的节点个数的范围是  [1, 104].
//    -104 <= Node.val <= 104
//    root 为二叉搜索树
//    -105 <= k <= 105
//    注意：本题与主站 653 题相同： https://leetcode-cn.com/problems/two-sum-iv-input-is-a-bst/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/opLdQZ
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
//        [2,0,3,-4,1]
//        -1
//           2
//         0   3
//        -4 1
        guard let node = root else {return false}
        let list = getValList(node)
        var l = 0
        var r = list.count - 1
        while l < r {
            if list[l] + list[r] == k {
                return true
            }else if list[l] + list[r] > k {
                r -= 1
            }else {
                l += 1
            }
        }
        return false
    }
    class func getValList(_ root: TreeNode?) -> [Int] {
        guard let node = root else {return []}
        var list: [Int] = []
        list += getValList(root?.left)
        list.append(node.val)
        list += getValList(root?.right)
        return list
    }
    
//    剑指 Offer II 052. 展平二叉搜索树
//    给你一棵二叉搜索树，请 按中序遍历 将其重新排列为一棵递增顺序搜索树，使树中最左边的节点成为树的根节点，并且每个节点没有左子节点，只有一个右子节点。
//    示例 1：
//    输入：root = [5,3,6,2,4,null,8,1,null,null,null,7,9]
//    输出：[1,null,2,null,3,null,4,null,5,null,6,null,7,null,8,null,9]
//    示例 2：
//    输入：root = [5,1,7]
//    输出：[1,null,5,null,7]
//    提示：
//    树中节点数的取值范围是 [1, 100]
//    0 <= Node.val <= 1000
//    注意：本题与主站 897 题相同： https://leetcode-cn.com/problems/increasing-order-search-tree/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/NYBBNL
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func increasingBST(_ root: TreeNode?) -> TreeNode? {
        guard let node = root else{ return nil}
        return increasingBST1(node).0
    }
    
    class func increasingBST1(_ root: TreeNode) -> (TreeNode,TreeNode) {
        if root.left == nil && root.right == nil {
            return (root,root)
        }
        var head = root
        var tail = root
        if let left = root.left {
            let t = increasingBST1(left)
            head = t.0
            root.left = nil
            t.1.right = root
        }
        
        if let right = root.right {
            let t = increasingBST1(right)
            tail.right = t.0
            tail = t.1
        }
        return (head,tail)
    }
//    剑指 Offer II 102. 加减的目标值
//    给定一个正整数数组 nums 和一个整数 target 。
//    向数组中的每个整数前添加 '+' 或 '-' ，然后串联起所有整数，可以构造一个 表达式 ：
//    例如，nums = [2, 1] ，可以在 2 之前添加 '+' ，在 1 之前添加 '-' ，然后串联起来得到表达式 "+2-1" 。
//    返回可以通过上述方法构造的、运算结果等于 target 的不同 表达式 的数目。
//    示例 1：
//    输入：nums = [1,1,1,1,1], target = 3
//    输出：5
//    解释：一共有 5 种方法让最终目标和为 3 。
//    -1 + 1 + 1 + 1 + 1 = 3
//    +1 - 1 + 1 + 1 + 1 = 3
//    +1 + 1 - 1 + 1 + 1 = 3
//    +1 + 1 + 1 - 1 + 1 = 3
//    +1 + 1 + 1 + 1 - 1 = 3
//    示例 2：
//    输入：nums = [1], target = 1
//    输出：1
//    提示：
//    1 <= nums.length <= 20
//    0 <= nums[i] <= 1000
//    0 <= sum(nums[i]) <= 1000
//    -1000 <= target <= 1000
//    注意：本题与主站 494 题相同： https://leetcode-cn.com/problems/target-sum/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/YaVDxD
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func findTargetSumWays(_ nums: [Int], _ target: Int) -> Int {
        //A + B = target
        //A - B = sum
        //2A = target + sum
        //A = (target + sum) * 0.5
        //转化为背包问题
        var sum = 0
        for item in nums {
            sum += item
        }
        guard (target + sum) % 2 == 0 else { return 0 }
        let k = (target + sum) / 2
        //dp[i][k] = dp[i-1][k] + dp[i-1][k-nums[i - 1]]
        //dp[0][k] = 0
        //dp[k][0] = 1
        var dp = Array(repeating: 0, count: k + 1)
        dp[0] = 1
        var i = 1
        while i <= nums.count {
            var j = k
            let num = nums[i - 1]
            while j >= 0 {
                if j - num >= 0 {
                    dp[j] = dp[j] + dp[j - num]
                }
                j -= 1
            }
            i += 1
        }
        return dp[k]
    }
//    剑指 Offer II 101. 分割等和子集
//    给定一个非空的正整数数组 nums ，请判断能否将这些数字分成元素和相等的两部分。
//    示例 1：
//    输入：nums = [1,5,11,5]
//    输出：true
//    解释：nums 可以分割成 [1, 5, 5] 和 [11] 。
//    示例 2：
//    输入：nums = [1,2,3,5]
//    输出：false
//    解释：nums 不可以分为和相等的两部分
//    提示：
//    1 <= nums.length <= 200
//    1 <= nums[i] <= 100
//    注意：本题与主站 416 题相同： https://leetcode-cn.com/problems/partition-equal-subset-sum/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/NUPfPr
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func canPartition(_ nums: [Int]) -> Bool {
        guard nums.count > 1 else {return false}
        var sum = 0
        for item in nums {
            sum += item
        }
        guard sum % 2 == 0 else {return false}
        let k = sum / 2
        //dp[i][k] = dp[i-1][k] + dp[i-1][k-nums[i-1]]
        //dp[0][k] = 0
        //dp[i][0] = 1
        var dp = Array(repeating: false, count: k + 1)
        dp[0] = true
        var i = 1
        while i < nums.count {
            var j = k
            while j >= 0 {
                if j == 0 {
                    dp[j] = true
                }else {
                    dp[j] = dp[j]
                    if !dp[j] && j - nums[i] >= 0 {
                        dp[j] = dp[j-nums[i]]
                    }
                }
                if j == k && dp[j]{
                    return true
                }
                j -= 1
            }
            i += 1
        }
        return false
    }
    
//    剑指 Offer II 100. 三角形中最小路径之和
//    给定一个三角形 triangle ，找出自顶向下的最小路径和。
//    每一步只能移动到下一行中相邻的结点上。相邻的结点 在这里指的是 下标 与 上一层结点下标 相同或者等于 上一层结点下标 + 1 的两个结点。也就是说，如果正位于当前行的下标 i ，那么下一步可以移动到下一行的下标 i 或 i + 1 。
//    示例 1：
//    输入：triangle = [[2],[3,4],[6,5,7],[4,1,8,3]]
//    输出：11
//    解释：如下面简图所示：
//       2
//      3 4
//     6 5 7
//    4 1 8 3
//    自顶向下的最小路径和为 11（即，2 + 3 + 5 + 1 = 11）。
//    示例 2：
//    输入：triangle = [[-10]]
//    输出：-10
//    提示：
//    1 <= triangle.length <= 200
//    triangle[0].length == 1
//    triangle[i].length == triangle[i - 1].length + 1
//    -104 <= triangle[i][j] <= 104
//    进阶：
//    你可以只使用 O(n) 的额外空间（n 为三角形的总行数）来解决这个问题吗？
//    注意：本题与主站 120 题相同： https://leetcode-cn.com/problems/triangle/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/IlPe0q
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func minimumTotal(_ triangle: [[Int]]) -> Int {
        var dp = Array(repeating: Int.max, count: triangle.count)
        var i = 0
        var res = Int.max
        while i < triangle.count {
            var j = triangle[i].count - 1
            while j >= 0 {
                if i == 0 && j == 0 {
                    dp[i] = triangle[0][0]
                }else {
                    if j == triangle[i].count - 1 {
                        dp[j] = dp[j-1] + triangle[i][j]
                    }else if j == 0 {
                        dp[j] = dp[j] + triangle[i][j]
                    }else {
                        dp[j] = min(dp[j], dp[j-1]) + triangle[i][j]
                    }
                }
                if i == triangle.count - 1 {
                    res = min(res, dp[j])
                }
                j -= 1
            }
            i += 1
        }
        return res
    }
//    剑指 Offer II 099. 最小路径之和
//    给定一个包含非负整数的 m x n 网格 grid ，请找出一条从左上角到右下角的路径，使得路径上的数字总和为最小。
//    说明：一个机器人每次只能向下或者向右移动一步。
//    示例 1：
//    输入：grid = [[1,3,1],[1,5,1],[4,2,1]]
//    输入：grid = [   [1,3,1],
//                    [1,5,1],
//                    [4,2,1]]
//    输出：7
//    解释：因为路径 1→3→1→1→1 的总和最小。
//    示例 2：
//    输入：grid = [[1,2,3],[4,5,6]]
//    输出：12
//    提示：
//    m == grid.length
//    n == grid[i].length
//    1 <= m, n <= 200
//    0 <= grid[i][j] <= 100
//    注意：本题与主站 64 题相同： https://leetcode-cn.com/problems/minimum-path-sum/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/0i0mDW
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func minPathSum(_ grid: [[Int]]) -> Int {
        var dp: [[Int]] = Array(repeating: Array(repeating: Int.max, count: grid[0].count), count: grid.count)
        var i = 0
        while i < dp.count {
            var j = 0
            while j < dp[0].count {
                if i == 0 && j == 0 {
                    dp[i][j] = grid[0][0]
                }else {
                    if i - 1 >= 0 {
                        dp[i][j] = min(dp[i][j], dp[i-1][j] + grid[i][j])
                    }
                    if j - 1 >= 0 {
                        dp[i][j] = min(dp[i][j], dp[i][j-1] + grid[i][j])
                    }
                }
                j += 1
            }
            i += 1
        }
        return dp.last!.last!
    }
//    剑指 Offer II 040. 矩阵中最大的矩形
//    给定一个由 0 和 1 组成的矩阵 matrix ，找出只包含 1 的最大矩形，并返回其面积。
//    注意：此题 matrix 输入格式为一维 01 字符串数组。
//    示例 1：
//    输入：matrix = [  "10100"
//                    ,"10111"
//                    ,"11111"
//                    ,"10010"]
//    输出：6
//    解释：最大矩形如上图所示。
//    示例 2：
//    输入：matrix = []
//    输出：0
//    示例 3：
//    输入：matrix = ["0"]
//    输出：0
//    示例 4：
//    输入：matrix = ["1"]
//    输出：1
//    示例 5：
//    输入：matrix = ["00"]
//    输出：0
//    提示：
//    rows == matrix.length
//    cols == matrix[0].length
//    0 <= row, cols <= 200
//    matrix[i][j] 为 '0' 或 '1'
//    注意：本题与主站 85 题相同（输入参数格式不同）： https://leetcode-cn.com/problems/maximal-rectangle/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/PLYXKQ
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func maximalRectangle(_ matrix: [String]) -> Int {
        var array: [[Character]] = []
        for item in matrix {
            array.append(Array(item))
        }
        var res = 0
        var i = 0
        while i < array.count {
            var j = 0
            while j < array[i].count {
                let cur = array[i][j]
                if cur == "1" {
                    var area = 1 //以这个点为左上角的最大面积
                    var maxW = array[i].count
                    //向下走
                    var k = i
                    while k < array.count {
                        if array[k][j] == "1" {
                            //向右走，确定矩形最长宽度
                            var tempW = 1
                            var jj = j + 1
                            while jj < array[k].count && tempW <= maxW {
                                if array[k][jj] == "1" {
                                    tempW += 1
                                }else {
                                    maxW = min(maxW, tempW)
                                    area = max(area, maxW * (k - i + 1))
                                    break
                                }
                                jj += 1
                            }
                        }else {
                            break
                        }
                        k += 1
                    }
                    res = max(res, area)
                }
                j += 1
            }
            i += 1
        }
        return res
    }
    
//    剑指 Offer II 039. 直方图最大矩形面积
//    给定非负整数数组 heights ，数组中的数字用来表示柱状图中各个柱子的高度。每个柱子彼此相邻，且宽度为 1 。
//    求在该柱状图中，能够勾勒出来的矩形的最大面积。
//    示例 1:
//    输入：heights = [2,1,5,6,2,3]
//    输出：10
//    解释：最大的矩形为图中红色区域，面积为 10
//    示例 2：
//    输入： heights = [2,4]
//    输出： 4
//    提示：
//    1 <= heights.length <=105
//    0 <= heights[i] <= 104
//    注意：本题与主站 84 题相同： https://leetcode-cn.com/problems/largest-rectangle-in-histogram/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/0ynMMM
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func largestRectangleArea(_ heights: [Int]) -> Int {
        //单调栈 左右放一个哨兵 弹出比当前大的，可以确定弹出元素的宽度 0 [2,1,5,6,2,3] 0
        //  小1 大 小2   可以确定大的面积 = （小2 - 小1 - 1）* 大的高度
        var res = 0
        let newHeights = [0] + heights + [0]
        var stack = [0]
        var i = 1
        while i < newHeights.count {
            while newHeights[i] < newHeights[stack.last!] {
                let lastIndex = stack.removeLast()
                let h = newHeights[lastIndex]
                let w = i - stack.last! - 1 //注意点 。宽度 = i - 上一个 - 1
                res = max(res, w * h)
            }
            stack.append(i)
            i += 1
        }
        return res
    }
//    假设你正在爬楼梯。需要 n 阶你才能到达楼顶。
//    每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？
//    示例 1：
//    输入：n = 2
//    输出：2
//    解释：有两种方法可以爬到楼顶。
//    1. 1 阶 + 1 阶
//    2. 2 阶
//    示例 2：
//    输入：n = 3
//    输出：3
//    解释：有三种方法可以爬到楼顶。
//    1. 1 阶 + 1 阶 + 1 阶
//    2. 1 阶 + 2 阶
//    3. 2 阶 + 1 阶
//    提示：
//    1 <= n <= 45
//    链接：https://leetcode-cn.com/problems/climbing-stairs
    class func climbStairs(_ n: Int) -> Int {
        //dp[n] = dp[n-1] + dp[n-2]
        //dp[0] = 0 dp[1] = 1 dp[2] = [2]
        guard n > 2 else {return n}
        var dp = Array(repeating: 0, count: n + 1)
        dp[1] = 1
        dp[2] = 2
        var i = 3
        while i <= n {
            dp[i] = dp[i-1] + dp[i-2]
            i += 1
        }
        return dp[n]
    }
    
//    剑指 Offer II 038. 每日温度
//    请根据每日 气温 列表 temperatures ，重新生成一个列表，要求其对应位置的输出为：要想观测到更高的气温，至少需要等待的天数。如果气温在这之后都不会升高，请在该位置用 0 来代替。
//    示例 1:
//    输入: temperatures = [73,74,75,71,69,72,76,73]
//    输出: [1,1,4,2,1,1,0,0]
//    示例 2:
//    输入: temperatures = [30,40,50,60]
//    输出: [1,1,1,0]
//    示例 3:
//    输入: temperatures = [30,60,90]
//    输出: [1,1,0]
//    提示：
//    1 <= temperatures.length <= 105
//    30 <= temperatures[i] <= 100
//    注意：本题与主站 739 题相同： https://leetcode-cn.com/problems/daily-temperatures/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/iIQa4I
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
//        可以维护一个存储下标的单调栈，从栈底到栈顶的下标对应的温度列表中的温度依次递减。如果一个下标在单调栈里，则表示尚未找到下一次温度更高的下标。
        var res: [Int] = Array(repeating: 0, count: temperatures.count)
        var stack: [Int] = []
        var i = 0
        while i < temperatures.count {
            let item = temperatures[i]
            if stack.isEmpty {
                stack.append(i)
            }else {
                while !stack.isEmpty {
                    let lastIndex = stack.last!
                    let last = temperatures[lastIndex]
                    if item > last {
                        stack.removeLast()
                        res[lastIndex] = i - lastIndex
                    }else {
                        break
                    }
                }
                stack.append(i)
            }
            i += 1
        }
        return res
    }
//    剑指 Offer II 037. 小行星碰撞
//    给定一个整数数组 asteroids，表示在同一行的小行星。
//    对于数组中的每一个元素，其绝对值表示小行星的大小，正负表示小行星的移动方向（正表示向右移动，负表示向左移动）。每一颗小行星以相同的速度移动。
//    找出碰撞后剩下的所有小行星。碰撞规则：两个行星相互碰撞，较小的行星会爆炸。如果两颗行星大小相同，则两颗行星都会爆炸。两颗移动方向相同的行星，永远不会发生碰撞。
//    示例 1：
//    输入：asteroids = [5,10,-5]
//    输出：[5,10]
//    解释：10 和 -5 碰撞后只剩下 10 。 5 和 10 永远不会发生碰撞。
//    示例 2：
//    输入：asteroids = [8,-8]
//    输出：[]
//    解释：8 和 -8 碰撞后，两者都发生爆炸。
//    示例 3：
//    输入：asteroids = [10,2,-5]
//    输出：[10]
//    解释：2 和 -5 发生碰撞后剩下 -5 。10 和 -5 发生碰撞后剩下 10 。
//    示例 4：
//    输入：asteroids = [-2,-1,1,2]
//    输出：[-2,-1,1,2]
//    解释：-2 和 -1 向左移动，而 1 和 2 向右移动。 由于移动方向相同的行星不会发生碰撞，所以最终没有行星发生碰撞。
//    提示：
//    2 <= asteroids.length <= 104
//    -1000 <= asteroids[i] <= 1000
//    asteroids[i] != 0
//    注意：本题与主站 735 题相同： https://leetcode-cn.com/problems/asteroid-collision/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/XagZNi
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func asteroidCollision(_ asteroids: [Int]) -> [Int] {
        var res:[Int] = []
        for item in asteroids {
            if item > 0 {
                res.append(item)
            }else {
                //如果是负数
                if res.isEmpty {
                    res.append(item)
                }else {
                    while !res.isEmpty {
                        let last = res.last!
                        if last < 0 {
                            //上一个也是负数，直接添加
                            res.append(item)
                            break
                        }else {
                            if last > -item {//自己炸了
                                break
                            }else if last < -item {
                                res.removeLast()//上一个炸了
                                if res.isEmpty {
                                    res.append(item)//胜出了
                                    break
                                }
                            }else {
                                res.removeLast()//一起炸了
                                break
                            }
                        }
                    }
                }
            }
        }
        return res
    }
//    剑指 Offer II 097. 子序列的数目
//    给定一个字符串 s 和一个字符串 t ，计算在 s 的子序列中 t 出现的个数。
//    字符串的一个 子序列 是指，通过删除一些（也可以不删除）字符且不干扰剩余字符相对位置所组成的新字符串。（例如，"ACE" 是 "ABCDE" 的一个子序列，而 "AEC" 不是）
//    题目数据保证答案符合 32 位带符号整数范围。
//    示例 1：
//    输入：s = "rabbbit", t = "rabbit"
//    输出：3
//    解释：
//    如下图所示, 有 3 种可以从 s 中得到 "rabbit" 的方案。
//    rabbbit
//    rabbbit
//    rabbbit
//    示例 2：
//    输入：s = "babgbag", t = "bag"
//    输出：5
//    解释：
//    如下图所示, 有 5 种可以从 s 中得到 "bag" 的方案。
//    babgbag
//    babgbag
//    babgbag
//    babgbag
//    babgbag
//    提示：
//    0 <= s.length, t.length <= 1000
//    s 和 t 由英文字母组成
//    注意：本题与主站 115 题相同： https://leetcode-cn.com/problems/distinct-subsequences/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/21dk04
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func numDistinct(_ s: String, _ t: String) -> Int {
        let ss = Array(s)
        let tt = Array(t)
        guard ss.count >= tt.count else { return 0}
        var book = Array(repeating: Array(repeating: -1, count: tt.count), count: ss.count)
        return numDistinct(ss, 0, tt, 0, &book)
    }
    class func numDistinct(_ s: [Character],_ i: Int,_ t: [Character],_ j: Int,_ book: inout [[Int]]) -> Int {
        if j == t.count - 1 {
            var res = 0
            var k = i
            while k < s.count {
                if s[k] == t[j] {
                    res += 1
                }
                k += 1
            }
            return res
        }
        if i == s.count {
            return 0
        }
        
        if book[i][j] != -1 {
            return book[i][j]
        }
        
        if s[i] == t[j] {
            let count1 = numDistinct(s, i + 1, t, j, &book)
            let count2 = numDistinct(s, i + 1, t, j + 1, &book)
            book[i][j] = count1 + count2
            return count1 + count2
        }else {
            let count = numDistinct(s, i + 1, t, j, &book)
            book[i][j] = count
            return count
        }
    }
//    剑指 Offer II 036. 后缀表达式
//    根据 逆波兰表示法，求该后缀表达式的计算结果。
//    有效的算符包括 +、-、*、/ 。每个运算对象可以是整数，也可以是另一个逆波兰表达式。
//    说明：
//    整数除法只保留整数部分。
//    给定逆波兰表达式总是有效的。换句话说，表达式总会得出有效数值且不存在除数为 0 的情况。
//    示例 1：
//    输入：tokens = ["2","1","+","3","*"]
//    输出：9
//    解释：该算式转化为常见的中缀算术表达式为：((2 + 1) * 3) = 9
//    示例 2：
//    输入：tokens = ["4","13","5","/","+"]
//    输出：6
//    解释：该算式转化为常见的中缀算术表达式为：(4 + (13 / 5)) = 6
//    示例 3：
//    输入：tokens = ["10","6","9","3","+","-11","*","/","*","17","+","5","+"]
//    输出：22
//    解释：
//    该算式转化为常见的中缀算术表达式为：
//      ((10 * (6 / ((9 + 3) * -11))) + 17) + 5
//    = ((10 * (6 / (12 * -11))) + 17) + 5
//    = ((10 * (6 / -132)) + 17) + 5
//    = ((10 * 0) + 17) + 5
//    = (0 + 17) + 5
//    = 17 + 5
//    = 22
//    提示：
//    1 <= tokens.length <= 104
//    tokens[i] 要么是一个算符（"+"、"-"、"*" 或 "/"），要么是一个在范围 [-200, 200] 内的整数
//    逆波兰表达式：
//    逆波兰表达式是一种后缀表达式，所谓后缀就是指算符写在后面。
//    平常使用的算式则是一种中缀表达式，如 ( 1 + 2 ) * ( 3 + 4 ) 。
//    该算式的逆波兰表达式写法为 ( ( 1 2 + ) ( 3 4 + ) * ) 。
//    逆波兰表达式主要有以下两个优点：
//    去掉括号后表达式无歧义，上式即便写成 1 2 + 3 4 + * 也可以依据次序计算出正确结果。
//    适合用栈操作运算：遇到数字则入栈；遇到算符则取出栈顶两个数字进行计算，并将结果压入栈中。
//    注意：本题与主站 150 题相同： https://leetcode-cn.com/problems/evaluate-reverse-polish-notation/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/8Zf90G
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func evalRPN(_ tokens: [String]) -> Int {
        var array = tokens
        return evalRPN1(&array)
    }
    
    class func evalRPN1(_ tokens: inout [String]) -> Int {
        if let last = tokens.last {
            if last == "+" || last == "-" || last == "*" || last == "/" {
                let op = tokens.removeLast()
                let right = evalRPN1(&tokens)
                let left = evalRPN1(&tokens)
                var res = 0
                switch op {
                case "+":
                    res = left + right
                case "-":
                    res = left - right
                case "*":
                    res = left * right
                default:
                    res = left / right
                }
                return res
            }else {
                return Int(tokens.removeLast())!
            }
        }
        return 0
    }
    
//    剑指 Offer II 035. 最小时间差
//    给定一个 24 小时制（小时:分钟 "HH:MM"）的时间列表，找出列表中任意两个时间的最小时间差并以分钟数表示。
//    示例 1：
//    输入：timePoints = ["23:59","00:00"]
//    输出：1
//    示例 2：
//    输入：timePoints = ["00:00","23:59","00:00"]
//    输出：0
//    提示：
//    2 <= timePoints <= 2 * 104
//    timePoints[i] 格式为 "HH:MM"
//    注意：本题与主站 539 题相同： https://leetcode-cn.com/problems/minimum-time-difference/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/569nqc
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func findMinDifference(_ timePoints: [String]) -> Int {
        var array: [Int] = []
        let hour24 = 60 * 24
        for item in timePoints {
            let arr = Array(item)
            let time = arr[0].wholeNumberValue! * 600 + arr[1].wholeNumberValue! * 60 + arr[3].wholeNumberValue! * 10 + arr[4].wholeNumberValue!
            array.append(time)
        }
        array.sort()
        var minVal = hour24 - array.last! + array[0]
        var i = 1
        while i < array.count {
            minVal = min(minVal, array[i] - array[i - 1])
            i += 1
        }
        return minVal
    }
    
//    剑指 Offer II 096. 字符串交织
//    给定三个字符串 s1、s2、s3，请判断 s3 能不能由 s1 和 s2 交织（交错） 组成。
//    两个字符串 s 和 t 交织 的定义与过程如下，其中每个字符串都会被分割成若干 非空 子字符串：
//    s = s1 + s2 + ... + sn
//    t = t1 + t2 + ... + tm
//    |n - m| <= 1
//    交织 是 s1 + t1 + s2 + t2 + s3 + t3 + ... 或者 t1 + s1 + t2 + s2 + t3 + s3 + ...
//    提示：a + b 意味着字符串 a 和 b 连接。
//    示例 1：
//    输入：s1 = "aabcc", s2 = "dbbca", s3 = "aadbbcbcac"
//    输出：true
//    示例 2：
//    输入：s1 = "aabcc", s2 = "dbbca", s3 = "aadbbbaccc"
//    输出：false
//    示例 3：
//    输入：s1 = "", s2 = "", s3 = ""
//    输出：true
//    提示：
//    0 <= s1.length, s2.length <= 100
//    0 <= s3.length <= 200
//    s1、s2、和 s3 都由小写英文字母组成
//    注意：本题与主站 97 题相同： https://leetcode-cn.com/problems/interleaving-string/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/IY6buf
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func isInterleave(_ s1: String, _ s2: String, _ s3: String) -> Bool {
        let ss1 = Array(s1)
        let ss2 = Array(s2)
        let ss3 = Array(s3)
        guard ss1.count + ss2.count == ss3.count else { return false }
        if ss1.count == 0 && ss2.count == 0 && ss3.count == 0 {
            return true
        }
        var book: [[Int]] = Array(repeating: Array(repeating: -1, count: ss2.count), count: ss1.count)
        return isInterleaveBacktrace(ss1, 0, ss2, 0, ss3, 0,&book)
    }
    class func isInterleaveBacktrace(_ ss1:[Character],_ i1: Int,_ ss2:[Character],_ i2: Int,_ ss3:[Character],_ i3: Int,_ book: inout [[Int]]) -> Bool {
        
        if i1 == ss1.count {
            var i = i2
            var j = i3
            while i < ss2.count {
                if ss2[i] != ss3[j] {
                    return false
                }
                i += 1
                j += 1
            }
            return true
        }
        if i2 == ss2.count {
            var i = i1
            var j = i3
            while i < ss1.count {
                if ss1[i] != ss3[j] {
                    return false
                }
                i += 1
                j += 1
            }
            return true
        }
        if book[i1][i2] != -1 {
            return book[i1][i2] == 1 ? true : false
        }
        
        if ss1[i1] == ss3[i3] {
            let flag = isInterleaveBacktrace(ss1, i1 + 1, ss2, i2, ss3, i3 + 1, &book)
            if flag {
                book[i1][i2] = 1
                return true
            }
        }
        if ss2[i2] == ss3[i3] {
            let flag = isInterleaveBacktrace(ss1, i1, ss2, i2 + 1, ss3, i3 + 1, &book)
            if flag {
                book[i1][i2] = 1
                return true
            }
        }
        book[i1][i2] = 0
        return false
    }
//    剑指 Offer II 034. 外星语言是否排序
//    某种外星语也使用英文小写字母，但可能顺序 order 不同。字母表的顺序（order）是一些小写字母的排列。
//    给定一组用外星语书写的单词 words，以及其字母表的顺序 order，只有当给定的单词在这种外星语中按字典序排列时，返回 true；否则，返回 false。
//    示例 1：
//    输入：words = ["hello","leetcode"], order = "hlabcdefgijkmnopqrstuvwxyz"
//    输出：true
//    解释：在该语言的字母表中，'h' 位于 'l' 之前，所以单词序列是按字典序排列的。
//    示例 2：
//    输入：words = ["word","world","row"], order = "worldabcefghijkmnpqstuvxyz"
//    输出：false
//    解释：在该语言的字母表中，'d' 位于 'l' 之后，那么 words[0] > words[1]，因此单词序列不是按字典序排列的。
//    示例 3：
//    输入：words = ["apple","app"], order = "abcdefghijklmnopqrstuvwxyz"
//    输出：false
//    解释：当前三个字符 "app" 匹配时，第二个字符串相对短一些，然后根据词典编纂规则 "apple" > "app"，因为 'l' > '∅'，其中 '∅' 是空白字符，定义为比任何其他字符都小（更多信息）。
//    提示：
//    1 <= words.length <= 100
//    1 <= words[i].length <= 20
//    order.length == 26
//    在 words[i] 和 order 中的所有字符都是英文小写字母。
//    注意：本题与主站 953 题相同： https://leetcode-cn.com/problems/verifying-an-alien-dictionary/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/lwyVBB
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func isAlienSorted(_ words: [String], _ order: String) -> Bool {
//        其他思路：
//        1.遍历order 建立与正常字符的映射，比如  外星e-->正常b
//        2.word替换为正常的字符
//        3.直接比较 word[i] word[i-1]
        
        guard words.count > 1 else { return true }
        let orders = Array(order)
        var book:[Character:Int] = [:]
        var i = 0
        while i < orders.count {
            book[orders[i]] = i
            i += 1
        }
        
        var maxLen = 0
        var wordArray: [[Character]] = []
        for item in words {
            let wordArr = Array(item)
            maxLen = max(maxLen, wordArr.count)
            wordArray.append(wordArr)
        }
        
        i = 0
        var start = 0
        while i < maxLen {
            var cur: [Character]?
            var j = start
            var iseq = false
            while j < wordArray.count {
                if cur == nil {
                    cur = wordArray[j]
                }else {
                    let next = wordArray[j]
                    if i != cur!.count && i == next.count {
                        return false
                    }else if i != cur!.count && i != next.count {
                        if book[cur![i]]! > book[next[i]]! {
                            return false
                        }else if book[cur![i]]! == book[next[i]]! {
                            if !iseq {
                                start = j - 1
                                iseq = true
                            }
                        }else {
                            if !iseq {
                                start = j
                            }
                        }
                    }else if i == cur!.count && i == next.count {
                        if !iseq {
                            start = j + 1
                        }
                    }else if i == cur!.count && i != next.count {
                        if !iseq {
                            start = j
                        }
                    }
                    cur = next
                }
                j += 1
            }
            if start == wordArray.count - 1 {
                break
            }
            i += 1
        }
        return true
    }
//    剑指 Offer II 033. 变位词组
//    给定一个字符串数组 strs ，将 变位词 组合在一起。 可以按任意顺序返回结果列表。
//    注意：若两个字符串中每个字符出现的次数都相同，则称它们互为变位词。
//    示例 1:
//    输入: strs = ["eat", "tea", "tan", "ate", "nat", "bat"]
//    输出: [["bat"],["nat","tan"],["ate","eat","tea"]]
//    示例 2:
//    输入: strs = [""]
//    输出: [[""]]
//    示例 3:
//    输入: strs = ["a"]
//    输出: [["a"]]
//    提示：
//    1 <= strs.length <= 104
//    0 <= strs[i].length <= 100
//    strs[i] 仅包含小写字母
//    注意：本题与主站 49 题相同： https://leetcode-cn.com/problems/group-anagrams/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/sfvd7V
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func groupAnagrams(_ strs: [String]) -> [[String]] {
        var res: [[String]] = []
        var book: [[Character]] = []
        for str in strs {
            var array = Array(str)
            array.sort()
            if res.count == 0 {
                res.append([str])
                book.append(array)
            }else {
                var i = 0
                while i < book.count {
                    let item = book[i]
                    if item == array {
                        res[i].append(str)
                        break
                    }
                    i += 1
                }
                if i == book.count {
                    res.append([str])
                    book.append(array)
                }
            }
        }
        return res
    }
//    剑指 Offer II 095. 最长公共子序列
//    给定两个字符串 text1 和 text2，返回这两个字符串的最长 公共子序列 的长度。如果不存在 公共子序列 ，返回 0 。
//    一个字符串的 子序列 是指这样一个新的字符串：它是由原字符串在不改变字符的相对顺序的情况下删除某些字符（也可以不删除任何字符）后组成的新字符串。
//    例如，"ace" 是 "abcde" 的子序列，但 "aec" 不是 "abcde" 的子序列。
//    两个字符串的 公共子序列 是这两个字符串所共同拥有的子序列。
//    示例 1：
//    输入：text1 = "abcde", text2 = "ace"
//    输出：3
//    解释：最长公共子序列是 "ace" ，它的长度为 3 。
//    示例 2：
//    输入：text1 = "abc", text2 = "abc"
//    输出：3
//    解释：最长公共子序列是 "abc" ，它的长度为 3 。
//    示例 3：
//    输入：text1 = "abc", text2 = "def"
//    输出：0
//    解释：两个字符串没有公共子序列，返回 0 。
//    提示：
//    1 <= text1.length, text2.length <= 1000
//    text1 和 text2 仅由小写英文字符组成。
//    注意：本题与主站 1143 题相同： https://leetcode-cn.com/problems/longest-common-subsequence/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/qJnOS7
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        let s1 = Array(text1)
        let s2 = Array(text2)
        var book = Array(repeating: Array(repeating: -1, count: s2.count), count: s1.count)
        return longestCommonSubsequenceDP(s1, s2, 0, 0, &book)
    }
    // 从index1 index2开始的最长公共子序列
    class func longestCommonSubsequenceDP(_ s1:[Character],_ s2:[Character],_ index1:Int,_ index2:Int,_ book: inout [[Int]]) -> Int {
        if index1 == s1.count || index2 == s2.count {
            return 0
        }
        if book[index1][index2] != -1 {
            return book[index1][index2]
        }else {
            var len = 0
            if s1[index1] == s2[index2] {
                len = longestCommonSubsequenceDP(s1, s2, index1 + 1, index2 + 1, &book) + 1
            }else {
                len = max(longestCommonSubsequenceDP(s1, s2, index1 + 1, index2, &book), longestCommonSubsequenceDP(s1, s2, index1, index2 + 1, &book))
            }
            book[index1][index2] = len
            return len
        }
    }
    
//    剑指 Offer II 032. 有效的变位词
//    给定两个字符串 s 和 t ，编写一个函数来判断它们是不是一组变位词（字母异位词）。
//    注意：若 s 和 t 中每个字符出现的次数都相同且字符顺序不完全相同，则称 s 和 t 互为变位词（字母异位词）。
//    示例 1:
//    输入: s = "anagram", t = "nagaram"
//    输出: true
//    示例 2:
//    输入: s = "rat", t = "car"
//    输出: false
//    示例 3:
//    输入: s = "a", t = "a"
//    输出: false
//    提示:
//    1 <= s.length, t.length <= 5 * 104
//    s and t 仅包含小写字母
//    进阶: 如果输入字符串包含 unicode 字符怎么办？你能否调整你的解法来应对这种情况？
//    注意：本题与主站 242 题相似（字母异位词定义不同）：https://leetcode-cn.com/problems/valid-anagram/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/dKk3P7
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func isAnagram(_ s: String, _ t: String) -> Bool {
        let ss = Array(s)
        let tt = Array(t)
        guard ss.count == tt.count else { return false }
        var dic: [Character:Int] = [:]
        var count = ss.count
        for item in ss {
            dic[item,default: 0] += 1
        }
        var eq = true
        var i = 0
        while i < tt.count {
            let item = tt[i]
            if eq && item != ss[i] {
                eq = false
            }
            if let c = dic[item] {
                count -= 1
                dic[item] = c - 1
                if c - 1 < 0{
                    return false
                }
            }else {
                return false
            }
            i += 1
        }
        return count == 0 && !eq
    }
//    剑指 Offer II 094. 最少回文分割
//    给定一个字符串 s，请将 s 分割成一些子串，使每个子串都是回文串。
//    返回符合要求的 最少分割次数 。
//    示例 1：
//    输入：s = "aab"
//    输出：1
//    解释：只需一次分割就可将 s 分割成 ["aa","b"] 这样两个回文子串。
//    示例 2：
//    输入：s = "a"
//    输出：0
//    示例 3：
//    输入：s = "ab"
//    输出：1
//    提示：
//    1 <= s.length <= 2000
//    s 仅由小写英文字母组成
//    注意：本题与主站 132 题相同： https://leetcode-cn.com/problems/palindrome-partitioning-ii/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/omKAoA
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func minCut(_ s: String) -> Int {
        // 先全部整理成线段，再回溯选取
        let array = Array(s)
        var huiwenDic: [Int:[Int]] = [:]//l -> [r,r,r]
        var i = 0
        while i < array.count {
            let huiArr1 = huiwenLen(array, i, i)
            if !huiArr1.isEmpty {
                for item in huiArr1 {
                    let l = item[0]
                    let r = item[1]
                    var rArr = huiwenDic[l,default: []]
                    rArr.append(r)
                    huiwenDic[l] = rArr
                }
            }
            let huiArr2 = huiwenLen(array, i, i + 1)
            if !huiArr2.isEmpty {
                for item in huiArr2 {
                    let l = item[0]
                    let r = item[1]
                    var rArr = huiwenDic[l,default: []]
                    rArr.append(r)
                    huiwenDic[l] = rArr
                }
            }
            i += 1
        }
        //回溯
        var book: [Int:Int] = [:]
        return minCutCount(array, huiwenDic, 0,&book) - 1
    }
    //从i开始的最少个数
    class func minCutCount(_ array: [Character],_ huiwenDic:[Int:[Int]],_ i:Int,_ book: inout [Int:Int]) -> Int {
        if i == array.count {
//            print("\(path)")
            return 0
        }
        if let count = book[i] {
            return count
        }
        let rights = huiwenDic[i]!
        var j = 0
        var minCount = 0
        while j < rights.count {
            let r = rights[j]
            let count = minCutCount(array, huiwenDic, r + 1, &book) + 1
            if j == 0 {
                minCount = count
            }else {
                minCount = min(minCount, count)
            }
            j += 1
        }
        book[i] = minCount
        return minCount
    }
    
    class func huiwenLen(_ s:[Character],_ left:Int,_ right: Int) -> [[Int]] {
        var arr: [[Int]] = []
        var l = left
        var r = right
        while l >= 0 && r < s.count && s[l] == s[r] {
            arr.append([l,r])
            r += 1
            l -= 1
        }
        return arr
    }
    
//    剑指 Offer II 093. 最长斐波那契数列
//    如果序列 X_1, X_2, ..., X_n 满足下列条件，就说它是 斐波那契式 的：
//    n >= 3
//    对于所有 i + 2 <= n，都有 X_i + X_{i+1} = X_{i+2}
//    给定一个严格递增的正整数数组形成序列 arr ，找到 arr 中最长的斐波那契式的子序列的长度。如果一个不存在，返回  0 。
//    （回想一下，子序列是从原序列  arr 中派生出来的，它从 arr 中删掉任意数量的元素（也可以不删），而不改变其余元素的顺序。例如， [3, 5, 8] 是 [3, 4, 5, 6, 7, 8] 的一个子序列）
//    示例 1：
//    输入: arr = [1,2,3,4,5,6,7,8]
//    输出: 5
//    解释: 最长的斐波那契式子序列为 [1,2,3,5,8] 。
//    示例 2：
//    输入: arr = [1,3,7,11,12,14,18]
//    输出: 3
//    解释: 最长的斐波那契式子序列有 [1,11,12]、[3,11,14] 以及 [7,11,18] 。
//    提示：
//    3 <= arr.length <= 1000
//    1 <= arr[i] < arr[i + 1] <= 10^9
//    注意：本题与主站 873 题相同： https://leetcode-cn.com/problems/length-of-longest-fibonacci-subsequence/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/Q91FMA
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func lenLongestFibSubseq(_ arr: [Int]) -> Int {
        var dic: [Int:Int] = [:]
        var index = 0
        while index < arr.count {
            let num = arr[index]
            dic[num] = index
            index += 1
        }
        var res = 0
        var book: [[Int]] = Array(repeating: Array(repeating: -1, count: arr.count), count: arr.count)
        var i = 0
        while i < arr.count {
            var j = i + 1
            while j < arr.count {
                res = max(res,lenLongestFibSubseqHelper(arr, i, j, dic, &book, 2))
                j += 1
            }
            i += 1
        }
        return res
    }
    
//        1        2     3  4  5
//     2 3 4 5   3 4 5  4
//    3   4   5 5      5
//   5
    class func lenLongestFibSubseqHelper(_ arr: [Int],_ i:Int,_ j:Int,_ dic:[Int:Int],_ book: inout [[Int]],_ len: Int) -> Int {
        if book[i][j] != -1 {
            return book[i][j]
        }
        if let index = dic[arr[i] + arr[j]] {
            let maxLen = lenLongestFibSubseqHelper(arr, j, index, dic, &book, len + 1)
            book[i][j] = maxLen
            return maxLen
        }
        return len < 3 ? 0 : len
    }
    
//    剑指 Offer II 031. 最近最少使用缓存
//    运用所掌握的数据结构，设计和实现一个  LRU (Least Recently Used，最近最少使用) 缓存机制 。
//    实现 LRUCache 类：
//    LRUCache(int capacity) 以正整数作为容量 capacity 初始化 LRU 缓存
//    int get(int key) 如果关键字 key 存在于缓存中，则返回关键字的值，否则返回 -1 。
//    void put(int key, int value) 如果关键字已经存在，则变更其数据值；如果关键字不存在，则插入该组「关键字-值」。当缓存容量达到上限时，它应该在写入新数据之前删除最久未使用的数据值，从而为新的数据值留出空间。
//    示例：
//    输入
//    ["LRUCache", "put", "put", "get", "put", "get", "put", "get", "get", "get"]
//    [[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]
//    输出
//    [null, null, null, 1, null, -1, null, -1, 3, 4]
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
//    0 <= key <= 10000
//    0 <= value <= 105
//    最多调用 2 * 105 次 get 和 put
//    进阶：是否可以在 O(1) 时间复杂度内完成这两种操作？
//    注意：本题与主站 146 题相同：https://leetcode-cn.com/problems/lru-cache/

    /**
     * Your LRUCache object will be instantiated and called as such:
     * let obj = LRUCache(capacity)
     * let ret_1: Int = obj.get(key)
     * obj.put(key, value)
     */

//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/OrIXps
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class LRUCache {
        class LRUCacheNode {
            var prev:LRUCacheNode?
            var next:LRUCacheNode?
            var key:Int = 0
            var val:Int = 0
        }
        var capacity:Int
        var count = 0
        var head: LRUCacheNode?
        var tail: LRUCacheNode?
        var hashMap: [Int:LRUCacheNode] = [:]
        
        init(_ capacity: Int) {
            self.capacity = capacity
        }
        
        func get(_ key: Int) -> Int {
            if let node = hashMap[key] {
                //置前
                bringToFront(node)
                return node.val
            }
            return -1
        }
        
        func put(_ key: Int, _ value: Int) {
            if let node = hashMap[key] {
                node.val = value
                //置前
                bringToFront(node)
            }else {
                if capacity > 0 {
                    //检查容量，删除最末尾
                    if count == capacity {
                        if count == 1 {
                            hashMap.removeValue(forKey: head!.key)
                            head = nil
                            tail = nil
                        }else {
                            let last = tail!
                            let prev = tail?.prev
                            prev?.next = nil
                            tail = prev
                            hashMap.removeValue(forKey: last.key)
                        }
                        count -= 1
                    }
                    
                    let newNode = LRUCacheNode()
                    newNode.key = key
                    newNode.val = value
                    if count == 0 {
                        //如果是第一个
                        head = newNode
                        tail = newNode
                    }else {
                        //插入最前
                        head?.prev = newNode
                        newNode.next = head
                        head = newNode
                    }
                    hashMap[key] = newNode
                    count += 1
                }
            }
        }
        
        func bringToFront(_ node: LRUCacheNode) {
            var headNode = head!
            var curNode = node
            if nodeAddress(&headNode) == nodeAddress(&curNode) {
                return
            }
            var tailNode = tail!
            let isTail = nodeAddress(&tailNode) == nodeAddress(&curNode)
            
            let prev = node.prev
            let next = node.next
            prev?.next = next
            next?.prev = prev
    
            node.prev = nil
            node.next = head
            head?.prev = node
            
            head = node
            
            if isTail {
                tail = prev
            }
        }
        
        func nodeAddress(_ node: inout LRUCacheNode) -> UInt {
            return withUnsafePointer(to: &node) { UnsafeRawPointer($0)}.load(as: UInt.self)
        }
    }
    
//    剑指 Offer II 092. 翻转字符
//    如果一个由 '0' 和 '1' 组成的字符串，是以一些 '0'（可能没有 '0'）后面跟着一些 '1'（也可能没有 '1'）的形式组成的，那么该字符串是 单调递增 的。
//    我们给出一个由字符 '0' 和 '1' 组成的字符串 s，我们可以将任何 '0' 翻转为 '1' 或者将 '1' 翻转为 '0'。
//    返回使 s 单调递增 的最小翻转次数。
//    示例 1：
//    输入：s = "00110"
//    输出：1
//    解释：我们翻转最后一位得到 00111.
//    示例 2：
//    输入：s = "010110"
//    输出：2
//    解释：我们翻转得到 011111，或者是 000111。
//    示例 3：
//    输入：s = "00011000"
//    输出：2
//    解释：我们翻转得到 00000000。
//    提示：
//    1 <= s.length <= 20000
//    s 中只包含字符 '0' 和 '1'
//    注意：本题与主站 926 题相同： https://leetcode-cn.com/problems/flip-string-to-monotone-increasing/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/cyJERH
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func minFlipsMonoIncr(_ s: String) -> Int {
        //dp[n][0] = nums[0] == 0 最后一位是0的最小反转次数
//                   = dp[n-1][0]
//                   nums[0] == 1
//                   == dp[n-1][0] + 1
        //dp[n][1] nums[0] == 0 最后一位是1的最小反转次数
//                = dp[n-1][1] + 1
                    
        let array = Array(s)
        var dp = Array(repeating: [0,0], count: array.count)
        dp[0][0] = array[0] == "0" ? 0 : 1
        dp[0][1] = array[0] == "1" ? 0 : 1
        var i = 1
        while i < array.count {
            let ch = array[i]
            if ch == "0" {
                dp[i][0] = dp[i-1][0]
                dp[i][1] = min(dp[i-1][0] + 1, dp[i-1][1] + 1)
            }else {
                dp[i][0] = dp[i-1][0] + 1
                dp[i][1] = min(dp[i-1][0], dp[i-1][1])
            }
            i += 1
        }
        return min(dp[i - 1][0], dp[i - 1][1])
        //-------------
        //错误
//        let array = Array(s)
//        var count0 = 0
//        var count1 = 0
//        var first1 = -1
//        var last0 = -1
//        var i = 0
//        while i < array.count {
//            let ch = array[i]
//            if ch == "0" {
//                count0 += 1
//                last0 = i
//            }else {
//                count1 += 1
//                if count1 == 1 {
//                    first1 = i
//                }
//            }
//            i += 1
//        }
//        //不用反转
//        if count0 == 0 || count1 == 0 {
//            return 0
//        }
//        //全反转另一个
////        let all = min(count0, count1)
//        //把第一个1之后的0都反转
//        let fisrt = count0 - first1
//        //把最后一个0之前的1都反转
//        let last = count1 - (array.count - last0 - 1)
//
//        return min(last, fisrt)
    }
//    剑指 Offer II 091. 粉刷房子
//    假如有一排房子，共 n 个，每个房子可以被粉刷成红色、蓝色或者绿色这三种颜色中的一种，你需要粉刷所有的房子并且使其相邻的两个房子颜色不能相同。
//    当然，因为市场上不同颜色油漆的价格不同，所以房子粉刷成不同颜色的花费成本也是不同的。每个房子粉刷成不同颜色的花费是以一个 n x 3 的正整数矩阵 costs 来表示的。
//    例如，costs[0][0] 表示第 0 号房子粉刷成红色的成本花费；costs[1][2] 表示第 1 号房子粉刷成绿色的花费，以此类推。
//    请计算出粉刷完所有房子最少的花费成本。
//    示例 1：
//    输入: costs = [[17,2,17],[16,16,5],[14,3,19]]
//    输出: 10
//    解释: 将 0 号房子粉刷成蓝色，1 号房子粉刷成绿色，2 号房子粉刷成蓝色。
//         最少花费: 2 + 5 + 3 = 10。
//    示例 2：
//    输入: costs = [[7,6,2]]
//    输出: 2
//    提示:
//    costs.length == n
//    costs[i].length == 3
//    1 <= n <= 100
//    1 <= costs[i][j] <= 20
//    注意：本题与主站 256 题相同：https://leetcode-cn.com/problems/paint-house/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/JEj789
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func minCost(_ costs: [[Int]]) -> Int {
        //dp[n] = min(dp[n][0],dp[n][1],dp[n][2])
        //dp[n][0] = min(dp[n-1][1],dp[n-1][2]) + cost[n][0]
        var dp0 = costs[0][0]
        var dp1 = costs[0][1]
        var dp2 = costs[0][2]
        var n = 1
        while n < costs.count {
            let cost = costs[n]
            let t0 = min(dp1, dp2) + cost[0]
            let t1 = min(dp0, dp2) + cost[1]
            let t2 = min(dp0, dp1) + cost[2]
            dp0 = t0
            dp1 = t1
            dp2 = t2
            n += 1
        }
        return min(min(dp0, dp1), dp2)
    }
//    剑指 Offer II 030. 插入、删除和随机访问都是 O(1) 的容器
//    设计一个支持在平均 时间复杂度 O(1) 下，执行以下操作的数据结构：
//    insert(val)：当元素 val 不存在时返回 true ，并向集合中插入该项，否则返回 false 。
//    remove(val)：当元素 val 存在时返回 true ，并从集合中移除该项，否则返回 false 。
//    getRandom：随机返回现有集合中的一项。每个元素应该有 相同的概率 被返回。
//    示例 :
//    输入: inputs = ["RandomizedSet", "insert", "remove", "insert", "getRandom", "remove", "insert", "getRandom"]
//    [[], [1], [2], [2], [], [1], [2], []]
//    输出: [null, true, false, true, 2, true, false, 2]
//    解释:
//    RandomizedSet randomSet = new RandomizedSet();  // 初始化一个空的集合
//    randomSet.insert(1); // 向集合中插入 1 ， 返回 true 表示 1 被成功地插入
//    randomSet.remove(2); // 返回 false，表示集合中不存在 2
//    randomSet.insert(2); // 向集合中插入 2 返回 true ，集合现在包含 [1,2]
//    randomSet.getRandom(); // getRandom 应随机返回 1 或 2
//    randomSet.remove(1); // 从集合中移除 1 返回 true 。集合现在包含 [2]
//    randomSet.insert(2); // 2 已在集合中，所以返回 false
//    randomSet.getRandom(); // 由于 2 是集合中唯一的数字，getRandom 总是返回 2
//    提示：
//    -231 <= val <= 231 - 1
//    最多进行 2 * 105 次 insert ， remove 和 getRandom 方法调用
//    当调用 getRandom 方法时，集合中至少有一个元素
//    注意：本题与主站 380 题相同：https://leetcode-cn.com/problems/insert-delete-getrandom-o1/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/FortPu
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class RandomizedSet {
        var dic: [Int:Int] = [:] //val->index
        var array: [Int] = []
        /** Initialize your data structure here. */
        init() {

        }
        
        /** Inserts a value to the set. Returns true if the set did not already contain the specified element. */
        func insert(_ val: Int) -> Bool {
            if dic.keys.contains(val) {
                return false
            }
            array.append(val)
            dic[val] = array.count - 1
            return true
        }
        
        /** Removes a value from the set. Returns true if the set contained the specified element. */
        func remove(_ val: Int) -> Bool {
            if let index = dic[val] {
                let lastVal = array.last!
                dic[lastVal] = index
                dic.removeValue(forKey: val)
                array[index] = lastVal
                array.removeLast()
                return true
            }
            return false
        }
        
        /** Get a random element from the set. */
        func getRandom() -> Int {
            return array[Int.random(in: 0...(array.count - 1))]
        }
    }
    
//    剑指 Offer II 090. 环形房屋偷盗
//    一个专业的小偷，计划偷窃一个环形街道上沿街的房屋，每间房内都藏有一定的现金。这个地方所有的房屋都 围成一圈 ，这意味着第一个房屋和最后一个房屋是紧挨着的。同时，相邻的房屋装有相互连通的防盗系统，如果两间相邻的房屋在同一晚上被小偷闯入，系统会自动报警 。
//    给定一个代表每个房屋存放金额的非负整数数组 nums ，请计算 在不触动警报装置的情况下 ，今晚能够偷窃到的最高金额。
//    示例 1：
//    输入：nums = [2,3,2]
//    输出：3
//    解释：你不能先偷窃 1 号房屋（金额 = 2），然后偷窃 3 号房屋（金额 = 2）, 因为他们是相邻的。
//    示例 2：
//    输入：nums = [1,2,3,1]
//    输出：4
//    解释：你可以先偷窃 1 号房屋（金额 = 1），然后偷窃 3 号房屋（金额 = 3）。
//         偷窃到的最高金额 = 1 + 3 = 4 。
//    示例 3：
//    输入：nums = [0]
//    输出：0
//    提示：
//    1 <= nums.length <= 100
//    0 <= nums[i] <= 1000
//    注意：本题与主站 213 题相同： https://leetcode-cn.com/problems/house-robber-ii/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/PzWKhm
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func rob111(_ nums: [Int]) -> Int {
        //dp[n][0] = max(dp[n-2][0] + nums[n],dp[n-1][0])
        //dp[n][1] = max(dp[n-2][1] + nums[n],dp[n-1][1])
//                n == nums.count  max(dp[n-2][1],dp[n-1][1])
        // base case
        // dp[0][0] = 0 dp[1][0] = nums[1]
        // dp[0][1] = nums[0] dp[1][1] = dp[0][1]
        
        guard nums.count > 1 else { return nums[0] }
        
        var dp: [[Int]] = Array(repeating: [0, 0], count: nums.count)
        dp[0][0] = 0
        dp[1][0] = nums[1]
        dp[0][1] = nums[0]
        dp[1][1] = dp[0][1]
        var n = 2
        while n < nums.count {
            dp[n][0] = max(dp[n-2][0] + nums[n],dp[n-1][0])
            if n == nums.count - 1 {
                dp[n][1] = max(dp[n-2][1],dp[n-1][1])
            }else {
                dp[n][1] = max(dp[n-2][1] + nums[n],dp[n-1][1])
            }
            n += 1
        }
        return max(dp[n - 1][0], dp[n - 1][1])
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
    
//    剑指 Offer II 029. 排序的循环链表
//    给定循环单调非递减列表中的一个点，写一个函数向这个列表中插入一个新元素 insertVal ，使这个列表仍然是循环升序的。
//    给定的可以是这个列表中任意一个顶点的指针，并不一定是这个列表中最小元素的指针。
//    如果有多个满足条件的插入位置，可以选择任意一个位置插入新的值，插入后整个列表仍然保持有序。
//    如果列表为空（给定的节点是 null），需要创建一个循环有序列表并返回这个节点。否则。请返回原先给定的节点。
//    示例 1：
//    输入：head = [3,4,1], insertVal = 2
//    输出：[3,4,1,2]
//    解释：在上图中，有一个包含三个元素的循环有序列表，你获得值为 3 的节点的指针，我们需要向表中插入元素 2 。新插入的节点应该在 1 和 3 之间，插入之后，整个列表如上图所示，最后返回节点 3 。
//    示例 2：
//    输入：head = [], insertVal = 1
//    输出：[1]
//    解释：列表为空（给定的节点是 null），创建一个循环有序列表并返回这个节点。
//    示例 3：
//    输入：head = [1], insertVal = 0
//    输出：[1,0]
//    提示：
//    0 <= Number of Nodes <= 5 * 10^4
//    -10^6 <= Node.val <= 10^6
//    -10^6 <= insertVal <= 10^6
//    注意：本题与主站 708 题相同： https://leetcode-cn.com/problems/insert-into-a-sorted-circular-linked-list/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/4ueAj6
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func insert(_ head: Node?, _ insertVal: Int) -> Node? {
        let newNode = Node(insertVal)
        guard var node = head else {
            newNode.next = newNode
            return newNode
        }
        let headAddress = nodeAdress1(&node)
        let nextAddress = nodeAdress1(&(node.next!))
        if headAddress == nextAddress {
            newNode.next = head
            head?.next = newNode
            return head
        }
        
        var array1: [Node] = []
        var array2: [Node] = []
        var putTo2 = true
        while true {
            var next = node.next!
            if node.val > next.val {
                //5 1   6
                //5 1   5
                //5 1   0
                //5 1   1
                if (insertVal >= node.val && insertVal >= next.val) ||
                    (insertVal <= node.val && insertVal <= next.val){
                    newNode.next = node.next
                    node.next = newNode
                    return head
                }
                array2.append(node)
                putTo2 = false
            }else {
                //1 3  2
                if insertVal >= node.val && insertVal <= next.val {
                    newNode.next = node.next
                    node.next = newNode
                    return head
                }
                if putTo2 {
                    array2.append(node)
                }else {
                    array1.append(node)
                }
            }
            if nodeAdress1(&next) == headAddress {
                break
            }
            node = next
        }
        array1.append(contentsOf: array2)
        // 5 5 4
        
        newNode.next = node.next
        node.next = newNode
        
        return head
    }
    
    
    class func nodeAdress1(_ node: inout Node) -> UInt {
        return withUnsafePointer(to: &node) { UnsafeRawPointer($0)}.load(as: UInt.self)
    }
    
      public class Node {
          public var val: Int
          public var prev: Node?
          public var next: Node?
          public var child: Node?
          public init(_ val: Int) {
              self.val = val
              self.prev = nil
              self.next = nil
              self.child  = nil
          }
      }
     
//    剑指 Offer II 028. 展平多级双向链表
//    多级双向链表中，除了指向下一个节点和前一个节点指针之外，它还有一个子链表指针，可能指向单独的双向链表。这些子列表也可能会有一个或多个自己的子项，依此类推，生成多级数据结构，如下面的示例所示。
//    给定位于列表第一级的头节点，请扁平化列表，即将这样的多级双向链表展平成普通的双向链表，使所有结点出现在单级双链表中。
//    示例 1：
//    输入：head = [1,2,3,4,5,6,null,null,null,7,8,9,10,null,null,11,12]
//    输出：[1,2,3,7,8,11,12,9,10,4,5,6]
//    解释：
//    输入的多级列表如下图所示：
//    示例 2：
//    输入：head = [1,2,null,3]
//    输出：[1,3,2]
//    解释：
//    输入的多级列表如下图所示：
//      1---2---NULL
//      |
//      3---NULL
//    示例 3：
//    输入：head = []
//    输出：[]
//    如何表示测试用例中的多级链表？
//    以 示例 1 为例：
//     1---2---3---4---5---6--NULL
//             |
//             7---8---9---10--NULL
//                 |
//                 11--12--NULL
//    序列化其中的每一级之后：
//    [1,2,3,4,5,6,null]
//    [7,8,9,10,null]
//    [11,12,null]
//    为了将每一级都序列化到一起，我们需要每一级中添加值为 null 的元素，以表示没有节点连接到上一级的上级节点。
//    [1,2,3,4,5,6,null]
//    [null,null,7,8,9,10,null]
//    [null,11,12,null]
//    合并所有序列化结果，并去除末尾的 null 。
//    [1,2,3,4,5,6,null,null,null,7,8,9,10,null,null,11,12]
//    提示：
//    节点数目不超过 1000
//    1 <= Node.val <= 10^5
//    注意：本题与主站 430 题相同： https://leetcode-cn.com/problems/flatten-a-multilevel-doubly-linked-list/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/Qv1Da2
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func flatten(_ head: Node?) -> Node? {
        _ = flattenHelper(head)
        return head
    }
    
    class func flattenHelper(_ head: Node?) -> Node? {
        if head == nil {
            return nil
        }
        var node = head
        var res = node
        while node != nil {
            let next = node?.next
            if node?.child != nil {
                let child = node?.child
                let tail = flattenHelper(child)
                node?.child = nil
                node?.next = child
                child?.prev = node
                res = tail
                tail?.next = next
                next?.prev = tail
            }
            if next != nil {
                res = next
            }
            node = next
        }
        return res
    }
    
//    剑指 Offer II 026. 重排链表
//    给定一个单链表 L 的头节点 head ，单链表 L 表示为：
//     L0 → L1 → … → Ln-1 → Ln
//    请将其重新排列后变为：
//    L0 → Ln → L1 → Ln-1 → L2 → Ln-2 → …
//    不能只是单纯的改变节点内部的值，而是需要实际的进行节点交换。
//    示例 1:
//    输入: head = [1,2,3,4]
//    输出: [1,4,2,3]
//    示例 2:
//    输入: head = [1,2,3,4,5]
//    输出: [1,5,2,4,3]
//    提示：
//    链表的长度范围为 [1, 5 * 104]
//    1 <= node.val <= 1000
//    注意：本题与主站 143 题相同：https://leetcode-cn.com/problems/reorder-list/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/LGjMqU
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func reorderList(_ head: ListNode?) {
//        [1,2,3,4,5]
        var array: [ListNode] = []
        var node = head
        while node != nil {
            let next = node?.next
            node?.next = nil
            array.append(node!)
            node = next
        }
        if array.count >= 2 {
            var l = 0
            var r = array.count - 1
            var tail: ListNode?
            while l <= r {
                if l == r {
                    let leftNode = array[l]
                    tail?.next = leftNode
                }else {
                    let leftNode = array[l]
                    let rightNode = array[r]
                    if tail != nil {
                        tail?.next = leftNode
                    }
                    leftNode.next = rightNode
                    rightNode.next = nil
                    tail = rightNode
                }
                l += 1
                r -= 1
            }
        }
    }
    
//    剑指 Offer II 025. 链表中的两数相加
//    给定两个 非空链表 l1和 l2 来代表两个非负整数。数字最高位位于链表开始位置。它们的每个节点只存储一位数字。将这两数相加会返回一个新的链表。
//    可以假设除了数字 0 之外，这两个数字都不会以零开头。
//    示例1：
//    输入：l1 = [7,2,4,3], l2 = [5,6,4]
//    输出：[7,8,0,7]
//    示例2：
//    输入：l1 = [2,4,3], l2 = [5,6,4]
//    输出：[8,0,7]
//    示例3：
//    输入：l1 = [0], l2 = [0]
//    输出：[0]
//    提示：
//    链表的长度范围为 [1, 100]
//    0 <= node.val <= 9
//    输入数据保证链表代表的数字无前导 0
//    进阶：如果输入链表不能修改该如何处理？换句话说，不能对列表中的节点进行翻转。
//    注意：本题与主站 445 题相同：https://leetcode-cn.com/problems/add-two-numbers-ii/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/lMSNwu
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var arr1: [Int] = []
        var arr2: [Int] = []
        return addTwoNumbers1(l1, l2, &arr1, &arr2)
    }
    class func addTwoNumbers1(_ l1: ListNode?, _ l2: ListNode?,_ arr1: inout [Int],_ arr2: inout [Int]) -> ListNode? {
        if l1 == nil && l2 == nil {
            var sum = 0
            if !arr1.isEmpty {
                sum += arr1.removeLast()
            }
            if !arr2.isEmpty {
                sum += arr2.removeLast()
            }
            return ListNode(sum)
        }else {
            if l1 != nil {
                arr1.append(l1!.val)
            }
            if l2 != nil {
                arr2.append(l2!.val)
            }
            let next = addTwoNumbers1(l1?.next, l2?.next, &arr1, &arr2)
            var sum = 0
            if next!.val >= 10 {
                next!.val = next!.val - 10
                sum += 1
            }
            if sum == 0 && arr1.isEmpty && arr2.isEmpty {
                return next
            }
            if !arr1.isEmpty {
                sum += arr1.removeLast()
            }
            if !arr2.isEmpty {
                sum += arr2.removeLast()
            }
            return ListNode(sum, next)
        }
    }
//    剑指 Offer II 024. 反转链表
//    给定单链表的头节点 head ，请反转链表，并返回反转后的链表的头节点。
//    示例 1
//    输入：head = [1,2,3,4,5]
//    输出：[5,4,3,2,1]
//    示例 2：
//    输入：head = [1,2]
//    输出：[2,1]
//    示例 3：
//    输入：head = []
//    输出：[]
//    提示：
//    链表中节点的数目范围是 [0, 5000]
//    -5000 <= Node.val <= 5000
//    进阶：链表可以选用迭代或递归方式完成反转。你能否用两种方法解决这道题？
//    注意：本题与主站 206 题相同： https://leetcode-cn.com/problems/reverse-linked-list/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/UHnkqh
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func reverseList(_ head: ListNode?) -> ListNode? {
        //迭代
        var preNode:ListNode? = nil
        var cur = head
        var next = cur?.next
        while cur != nil {
            let nextNext = next?.next
            cur?.next = preNode
            preNode = cur
            if next == nil {
                break
            }
            cur = next
            next = nextNext
        }
        return cur
        
        //递归
//        let cur = head
//        let next = cur?.next
//        if next == nil {
//            return cur
//        }
//        let newhead = reverseList(next)
//        cur?.next = nil
//        next?.next = cur
//        return newhead
    }
    
//    剑指 Offer II 023. 两个链表的第一个重合节点
//    给定两个单链表的头节点 headA 和 headB ，请找出并返回两个单链表相交的起始节点。如果两个链表没有交点，返回 null 。
//    图示两个链表在节点 c1 开始相交：
//    题目数据 保证 整个链式结构中不存在环。
//    注意，函数返回结果后，链表必须 保持其原始结构 。
//    示例 1：
//    输入：intersectVal = 8, listA = [4,1,8,4,5], listB = [5,0,1,8,4,5], skipA = 2, skipB = 3
//    输出：Intersected at '8'
//    解释：相交节点的值为 8 （注意，如果两个链表相交则不能为 0）。
//    从各自的表头开始算起，链表 A 为 [4,1,8,4,5]，链表 B 为 [5,0,1,8,4,5]。
//    在 A 中，相交节点前有 2 个节点；在 B 中，相交节点前有 3 个节点。
//    示例 2：
//    输入：intersectVal = 2, listA = [0,9,1,2,4], listB = [3,2,4], skipA = 3, skipB = 1
//    输出：Intersected at '2'
//    解释：相交节点的值为 2 （注意，如果两个链表相交则不能为 0）。
//    从各自的表头开始算起，链表 A 为 [0,9,1,2,4]，链表 B 为 [3,2,4]。
//    在 A 中，相交节点前有 3 个节点；在 B 中，相交节点前有 1 个节点。
//    示例 3：
//    输入：intersectVal = 0, listA = [2,6,4], listB = [1,5], skipA = 3, skipB = 2
//    输出：null
//    解释：从各自的表头开始算起，链表 A 为 [2,6,4]，链表 B 为 [1,5]。
//    由于这两个链表不相交，所以 intersectVal 必须为 0，而 skipA 和 skipB 可以是任意值。
//    这两个链表不相交，因此返回 null 。
//    提示：
//    listA 中节点数目为 m
//    listB 中节点数目为 n
//    0 <= m, n <= 3 * 104
//    1 <= Node.val <= 105
//    0 <= skipA <= m
//    0 <= skipB <= n
//    如果 listA 和 listB 没有交点，intersectVal 为 0
//    如果 listA 和 listB 有交点，intersectVal == listA[skipA + 1] == listB[skipB + 1]
//    进阶：能否设计一个时间复杂度 O(n) 、仅用 O(1) 内存的解决方案？
//    注意：本题与主站 160 题相同：https://leetcode-cn.com/problems/intersection-of-two-linked-lists/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/3u1WK4
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
//        listA = [4,1,8,4,5], listB = [5,0,1,8,4,5]
//        [4,1,8,4,5 5,0,1,8,4,5]
//        [5,0,1,8,4,5 4,1,8,4,5]
        
        var node1 = headA
        var node2 = headB
        var flag1 = true
        var flag2 = true
        while node1 != nil && node2 != nil {
            if nodeAdress(&(node1!)) == nodeAdress(&(node2!)) {
                return node1
            }
            
            node1 = node1?.next
            if node1 == nil && flag1 {
                node1 = headB
                flag1 = false
            }
            
            node2 = node2?.next
            if node2 == nil && flag2 {
                node2 = headA
                flag2 = false
            }
            
        }

        return nil
    }
    
//    剑指 Offer II 022. 链表中环的入口节点
//    给定一个链表，返回链表开始入环的第一个节点。 从链表的头节点开始沿着 next 指针进入环的第一个节点为环的入口节点。如果链表无环，则返回 null。
//    为了表示给定链表中的环，我们使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。 如果 pos 是 -1，则在该链表中没有环。注意，pos 仅仅是用于标识环的情况，并不会作为参数传递到函数中。
//    说明：不允许修改给定的链表。
//    示例 1：
//    输入：head = [3,2,0,-4], pos = 1
//    输出：返回索引为 1 的链表节点
//    解释：链表中有一个环，其尾部连接到第二个节点。
//    示例 2：
//    输入：head = [1,2], pos = 0
//    输出：返回索引为 0 的链表节点
//    解释：链表中有一个环，其尾部连接到第一个节点。
//    示例 3：
//    输入：head = [1], pos = -1
//    输出：返回 null
//    解释：链表中没有环。
//    提示：
//    链表中节点的数目范围在范围 [0, 104] 内
//    -105 <= Node.val <= 105
//    pos 的值为 -1 或者链表中的一个有效索引
//    进阶：是否可以使用 O(1) 空间解决此题？
//    注意：本题与主站 142 题相同： https://leetcode-cn.com/problems/linked-list-cycle-ii/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/c32eOV
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func detectCycle(_ head: ListNode?) -> ListNode? {
//        3,2,0,-4 2,0,-4 2,0,-4 2,0,-4
//        x x x  x
//        y y
//        3,2,0,-4 2,0,-4 2,0,-4 2,0,-4
//        x   x    x    x
//                      y y
//        1,2 1,2 1,2 1,2
//        x x x
//        y
//        1,2 1,2 1,2 1,2
//        x   x   x
//                y
        

        guard let node = head else { return nil }
        
        var slow = node
        var fast = node
        while let fastN = fast.next,let fastNN = fastN.next {
            fast = fastNN
            slow = slow.next!
            if nodeAdress(&fast) == nodeAdress(&slow) {
                var start = node
                while nodeAdress(&start) != nodeAdress(&slow){//细节
                    start = start.next!
                    slow = slow.next!
                }
                return start
            }
        }
        return nil
    }
    
    class func nodeAdress(_ node: inout ListNode) -> UInt {
        return withUnsafePointer(to: &node) { UnsafeRawPointer($0)}.load(as: UInt.self)
    }
    
    
    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init() { self.val = 0; self.next = nil; }
        public init(_ val: Int) { self.val = val; self.next = nil; }
        public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    }
     
//    剑指 Offer II 021. 删除链表的倒数第 n 个结点
//    给定一个链表，删除链表的倒数第 n 个结点，并且返回链表的头结点。
//    示例 1：
//    输入：head = [1,2,3,4,5], n = 2
//    输出：[1,2,3,5]
//    示例 2：
//    输入：head = [1], n = 1
//    输出：[]
//    示例 3：
//    输入：head = [1,2], n = 1
//    输出：[1]
//    提示：
//    链表中结点的数目为 sz
//    1 <= sz <= 30
//    0 <= Node.val <= 100
//    1 <= n <= sz
//    进阶：能尝试使用一趟扫描实现吗？
//    注意：本题与主站 19 题相同： https://leetcode-cn.com/problems/remove-nth-node-from-end-of-list/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/SLwz0R
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        if let node = head,let next = node.next {
            let nextIndex = removeNthFromEndHelper(node, next, n)
            if nextIndex == n - 1 {
                return next
            }
            return node
        }
        return nil
    }
    class func removeNthFromEndHelper(_ pre: ListNode,_ node: ListNode, _ n: Int) -> Int {
        let m = node.next == nil ? 1 : removeNthFromEndHelper(node,node.next!, n) + 1
        if m == n {
            pre.next = node.next
        }
        return m
    }
//    剑指 Offer II 020. 回文子字符串的个数
//    给定一个字符串 s ，请计算这个字符串中有多少个回文子字符串。
//    具有不同开始位置或结束位置的子串，即使是由相同的字符组成，也会被视作不同的子串。
//    示例 1：
//    输入：s = "abc"
//    输出：3
//    解释：三个回文子串: "a", "b", "c"
//    示例 2：
//    输入：s = "aaa"
//    输出：6
//    解释：6个回文子串: "a", "a", "a", "aa", "aa", "aaa"
//    提示：
//    1 <= s.length <= 1000
//    s 由小写英文字母组成
//    注意：本题与主站 647 题相同：https://leetcode-cn.com/problems/palindromic-substrings/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/a7VOhD
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func countSubstrings(_ s: String) -> Int {
        let ss = Array(s)
        var i = 0
        var count = 0
        while i < ss.count {
            count += countSubstringsHelper(ss, i, i)
            count += countSubstringsHelper(ss, i, i + 1)
            i += 1
        }
        return count
    }
    
    class func countSubstringsHelper(_ s:[Character],_ left:Int, _ right:Int) -> Int {
        var l = left
        var r = right
        var count = 0
        while l >= 0 && r < s.count && s[l] == s[r] {
            count += 1
            l -= 1
            r += 1
        }
        return count
    }
//    剑指 Offer II 019. 最多删除一个字符得到回文
//    给定一个非空字符串 s，请判断如果 最多 从字符串中删除一个字符能否得到一个回文字符串。
//    示例 1:
//    输入: s = "aba"
//    输出: true
//    示例 2:
//    输入: s = "abca"
//    输出: true
//    解释: 可以删除 "c" 字符 或者 "b" 字符
//    示例 3:
//    输入: s = "abc"
//    输出: false
//    提示:
//    1 <= s.length <= 105
//    s 由小写英文字母组成
//    注意：本题与主站 680 题相同： https://leetcode-cn.com/problems/valid-palindrome-ii/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/RQku0D
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func validPalindrome(_ s: String) -> Bool {
        let ss = Array(s)
        var l = 0
        var r = ss.count - 1
        while l < r {
            if ss[l] == ss[r] {
                l += 1
                r -= 1
            }else {
                return validPalindromeHelper(ss, l + 1, r) || validPalindromeHelper(ss, l, r - 1)
            }
        }
        return true
    }
    
    class func validPalindromeHelper(_ s:[Character],_ left:Int, _ right:Int) -> Bool {
        var l = left
        var r = right
        while l < r {
            if s[l] == s[r] {
                l += 1
                r -= 1
            }else {
                return false
            }
        }
        return true
    }
//    剑指 Offer II 018. 有效的回文
//    给定一个字符串 s ，验证 s 是否是 回文串 ，只考虑字母和数字字符，可以忽略字母的大小写。
//    本题中，将空字符串定义为有效的 回文串 。
//    示例 1:
//    输入: s = "A man, a plan, a canal: Panama"
//    输出: true
//    解释："amanaplanacanalpanama" 是回文串
//    示例 2:
//    输入: s = "race a car"
//    输出: false
//    解释："raceacar" 不是回文串
//    提示：
//    1 <= s.length <= 2 * 105
//    字符串 s 由 ASCII 字符组成
//    注意：本题与主站 125 题相同： https://leetcode-cn.com/problems/valid-palindrome/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/XltzEq
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func isPalindrome(_ s: String) -> Bool {
        let ss = Array(s)
        var sss :[Character] = []
        for item in ss {
            if item.isLetter || item.isNumber {
                sss.append(item.isUppercase ? Character(item.lowercased()) : item)
            }
        }
        var l = 0
        var r = sss.count - 1
        while l < r {
            if sss[l] == sss[r] {
                l += 1
                r -= 1
            }else {
                return false
            }
        }
        return true
    }
//    剑指 Offer II 017. 含有所有字符的最短字符串
//    给定两个字符串 s 和 t 。返回 s 中包含 t 的所有字符的最短子字符串。如果 s 中不存在符合条件的子字符串，则返回空字符串 "" 。
//    如果 s 中存在多个符合条件的子字符串，返回任意一个。
//    注意： 对于 t 中重复字符，我们寻找的子字符串中该字符数量必须不少于 t 中该字符数量。
//    示例 1：
//    输入：s = "ADOBECODEBANC", t = "ABC"
//    输出："BANC"
//    解释：最短子字符串 "BANC" 包含了字符串 t 的所有字符 'A'、'B'、'C'
//    示例 2：
//    输入：s = "a", t = "a"
//    输出："a"
//    示例 3：
//    输入：s = "a", t = "aa"
//    输出：""
//    解释：t 中两个字符 'a' 均应包含在 s 的子串中，因此没有符合条件的子字符串，返回空字符串。
//    提示：
//    1 <= s.length, t.length <= 105
//    s 和 t 由英文字母组成
//    进阶：你能设计一个在 o(n) 时间内解决此问题的算法吗？
//    注意：本题与主站 76 题相似（本题答案不唯一）：https://leetcode-cn.com/problems/minimum-window-substring/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/M1oyTv
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func minWindow(_ s: String, _ t: String) -> String {
        guard s.count >= t.count else { return "" }
        let ss = Array(s)
        let tt = Array(t)
        var need: [Character:Int] = [:]
        for item in tt {
            need[item,default: 0] += 1
        }
        var needcount = tt.count
        var minL = -1
        var minR = -1
        var l = 0
        var r = 0
        while r < ss.count {
            let rightCh = ss[r]
            r += 1
            
            if let chCount = need[rightCh] {
                need[rightCh] = chCount - 1
                if chCount > 0 {
                    needcount -= 1
                }
            }
            
            while needcount == 0 {
                let leftCh = ss[l]
                if let chCount = need[leftCh] {
                    if chCount >= 0  {//这个还需要
                        break
                    }else {//多了
                        need[leftCh] = chCount + 1
                    }
                }
                l += 1
            }
            
            if needcount == 0 {
                if minL == -1 || ((minL != -1) && ((r - l) < (minR - minL))){
                    minL = l
                    minR = r
                }
            }
        }
        return minL == -1 ? "" : String(ss[minL..<minR])
    }
//    剑指 Offer II 016. 不含重复字符的最长子字符串
//    给定一个字符串 s ，请你找出其中不含有重复字符的 最长连续子字符串 的长度。
//    示例 1:
//    输入: s = "abcabcbb"
//    输出: 3
//    解释: 因为无重复字符的最长子字符串是 "abc"，所以其长度为 3。
//    示例 2:
//    输入: s = "bbbbb"
//    输出: 1
//    解释: 因为无重复字符的最长子字符串是 "b"，所以其长度为 1。
//    示例 3:
//    输入: s = "pwwkew"
//    输出: 3
//    解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
//         请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。
//    示例 4:
//    输入: s = ""
//    输出: 0
//    提示：
//    0 <= s.length <= 5 * 104
//    s 由英文字母、数字、符号和空格组成
//    注意：本题与主站 3 题相同： https://leetcode-cn.com/problems/longest-substring-without-repeating-characters/
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/wtcaE1
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func lengthOfLongestSubstring111(_ s: String) -> Int {
        let ss = Array(s)
        var set: Set<Character> = []
        var l = 0
        var r = 0
        var len = 0
        while r < ss.count {
            let rightCh = ss[r]
            r += 1
            
            while set.contains(rightCh) {
                let leftCh = ss[l]
                set.remove(leftCh)
                l += 1
            }
            set.insert(rightCh)
            len = max(len, r - l)
        }
        return len
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
        let ss = Array(s)
        let pp = Array(p)
        
        var need:[Character:Int] = [:]
        for item in pp {
            need[item,default: 0] += 1
        }
        var needCount = pp.count
        var res: [Int] = []
        var l = 0
        var r = 0
        while r < ss.count {
            let rightch = ss[r]
            r += 1
            
            if let chCount = need[rightch] {
                need[rightch] = chCount - 1
                if chCount > 0 {
                    needCount -= 1
                }
            }
            
            while r - l > pp.count {
                let leftch = ss[l]
                if let chCount = need[leftch] {
                    need[leftch] = chCount + 1
                    if need[leftch]! > 0 {
                        needCount += 1
                    }
                }
                l += 1
            }
            
            if needCount == 0{
                res.append(l)
            }
        }
        return res
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

