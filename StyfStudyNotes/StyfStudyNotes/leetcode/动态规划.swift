//
//  DongTaiGuiHua.swift
//  StyfStudyNotes
//
//  Created by styf on 2021/2/9.
//

//# 初始化 base case
//dp[0][0][...] = base
//# 进行状态转移
//for 状态1 in 状态1的所有取值：
//    for 状态2 in 状态2的所有取值：
//        for ...
//            dp[状态1][状态2][...] = 求最值(选择1，选择2...)

import Foundation

@objcMembers class DongTaiGuiHua: NSObject {
    class func test()  {
        //300. 最长递增子序列
//        print(lengthOfLIS([10,9,2,5,3,7,101,18]))//4
//        print(lengthOfLIS([0,1,0,3,2,3]))//4
//        print(lengthOfLIS([7,7,7,7,7,7,7]))//1
        
//        354. 俄罗斯套娃信封问题
//        print(maxEnvelopes([[5,4],[6,4],[6,7],[2,3]]))
//        print(maxEnvelopes([[1,1],[1,1],[1,1]]))
        
//        53. 最大子序和
//        print(maxSubArray([-2,1,-3,4,-1,2,1,-5,4]))//6
//        print(maxSubArray([1]))//1
//        print(maxSubArray([0]))//0
//        print(maxSubArray([-1]))//-1
//        print(maxSubArray([-100000]))//-100000
        
//        1143. 最长公共子序列
//        print(longestCommonSubsequence("abcde", "ace"))//3
//        print(longestCommonSubsequence("abc", "abc"))//3
//        print(longestCommonSubsequence("abc", "def"))//0
        
//        583. 两个字符串的删除操作
//        print(minDistance("sea", "eat"))//2
        
//        712. 两个字符串的最小ASCII删除和
        print(minimumDeleteSum("sea", "eat"))//231
        print(minimumDeleteSum("delete", "leet"))//403
    }
//    712. 两个字符串的最小ASCII删除和
//    给定两个字符串s1, s2，找到使两个字符串相等所需删除字符的ASCII值的最小和。
//    示例 1:
//    输入: s1 = "sea", s2 = "eat"
//    输出: 231
//    解释: 在 "sea" 中删除 "s" 并将 "s" 的值(115)加入总和。
//    在 "eat" 中删除 "t" 并将 116 加入总和。
//    结束时，两个字符串相等，115 + 116 = 231 就是符合条件的最小和。
//    示例 2:
//    输入: s1 = "delete", s2 = "leet"
//    输出: 403
//    解释: 在 "delete" 中删除 "dee" 字符串变成 "let"，
//    将 100[d]+101[e]+101[e] 加入总和。在 "leet" 中删除 "e" 将 101[e] 加入总和。
//    结束时，两个字符串都等于 "let"，结果即为 100+101+101+101 = 403 。
//    如果改为将两个字符串转换为 "lee" 或 "eet"，我们会得到 433 或 417 的结果，比答案更大。
//    注意:
//    0 < s1.length, s2.length <= 1000。
//    所有字符串中的字符ASCII值在[97, 122]之间。
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/minimum-ascii-delete-sum-for-two-strings
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func minimumDeleteSum(_ s1: String, _ s2: String) -> Int {
        let array1 = Array(s1)
        let array2 = Array(s2)
        var memo = Array(repeating: Array(repeating: -1, count: array2.count + 1), count: array1.count + 1)
        let lcs = minimumDeleteSumDP(array1, array2, 0, 0, &memo)
        return lcs
    }
    class func minimumDeleteSumDP(_ s1: [Character],_ s2: [Character],_ idx1: Int,_ idx2: Int,_ memo: inout [[Int]]) -> Int {
        
        if memo[idx1][idx2] != -1 {
            return memo[idx1][idx2]
        }
        
        if idx1 == s1.count || idx2 == s2.count {
            if idx1 == s1.count {
                var sum = 0
                var i = idx2
                while i < s2.count {
                    sum += Int(s2[i].asciiValue!)
                    i += 1
                }
                return sum
            }else {
                var sum = 0
                var i = idx1
                while i < s1.count {
                    sum += Int(s1[i].asciiValue!)
                    i += 1
                }
                return sum
            }
        }
        
        if s1[idx1] == s2[idx2] {
            let lcs = minimumDeleteSumDP(s1, s2, idx1 + 1, idx2 + 1, &memo)
            memo[idx1][idx2] = lcs
            return lcs
        }else {
            let asc1 = Int(s1[idx1].asciiValue!)
            let asc2 = Int(s2[idx2].asciiValue!)
            let lcs = min(minimumDeleteSumDP(s1, s2, idx1 + 1, idx2, &memo) + asc1, minimumDeleteSumDP(s1, s2, idx1, idx2 + 1, &memo) + asc2)
            memo[idx1][idx2] = lcs
            return lcs
        }
    }
    
//    583. 两个字符串的删除操作
//    给定两个单词 word1 和 word2，找到使得 word1 和 word2 相同所需的最小步数，每步可以删除任意一个字符串中的一个字符。
//    示例：
//    输入: "sea", "eat"
//    输出: 2
//    解释: 第一步将"sea"变为"ea"，第二步将"eat"变为"ea"
//    提示：
//    给定单词的长度不超过500。
//    给定单词中的字符只含有小写字母。
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/delete-operation-for-two-strings
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func minDistance(_ word1: String, _ word2: String) -> Int {
        let lcs = longestCommonSubsequence(word1, word2)
        return word1.count - lcs + word2.count - lcs
    }
//    1143. 最长公共子序列
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
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/longest-common-subsequence
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        var memo = Array(repeating: Array(repeating: -1, count: text2.count), count: text1.count)
        return longestCommonSubsequenceDP(Array(text1), 0, Array(text2), 0, &memo)
    }
    //从idx开始的字符串的最长公共子序列长度
    class func longestCommonSubsequenceDP(_ text1: Array<Character>,_ idx1: Int,_ text2: Array<Character>,_ idx2: Int,_ memo: inout [[Int]]) -> Int {
        if idx1 == text1.count || idx2 == text2.count {
            return 0
        }
        if memo[idx1][idx2] != -1 {
            return memo[idx1][idx2]
        }else {
            if text1[idx1] == text2[idx2] {
                let len = 1 + longestCommonSubsequenceDP(text1, idx1 + 1, text2, idx2 + 1, &memo)
                memo[idx1][idx2] = len
                return len
            }else {
                //不相同，两个字符中必定有一个不在最长公共子序列
                let len = max(longestCommonSubsequenceDP(text1, idx1, text2, idx2 + 1, &memo), longestCommonSubsequenceDP(text1, idx1 + 1, text2, idx2, &memo))
                memo[idx1][idx2] = len
                return len
            }
        }
    }
    
//    53. 最大子序和
//    给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
//    示例 1：
//    输入：nums = [-2,1,-3,4,-1,2,1,-5,4]
//    输出：6
//    解释：连续子数组 [4,-1,2,1] 的和最大，为 6 。
//    示例 2：
//    输入：nums = [1]
//    输出：1
//    示例 3：
//    输入：nums = [0]
//    输出：0
//    示例 4：
//    输入：nums = [-1]
//    输出：-1
//    示例 5：
//    输入：nums = [-100000]
//    输出：-100000
//    提示：
//    1 <= nums.length <= 3 * 104
//    -105 <= nums[i] <= 105
//    进阶：如果你已经实现复杂度为 O(n) 的解法，尝试使用更为精妙的 分治法 求解。
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/maximum-subarray
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func maxSubArray(_ nums: [Int]) -> Int {
        var dp = Array(repeating: 0, count: nums.count)
        dp[0] = nums[0]
        var maxSum = nums[0]
        var i = 1
        while i < nums.count {
            let num = nums[i]
            dp[i] = dp[i - 1] > 0 ? dp[i - 1] + num : num
            maxSum = max(maxSum, dp[i])
            i += 1
        }
        return maxSum
    }
    
//    354. 俄罗斯套娃信封问题
//    给你一个二维整数数组 envelopes ，其中 envelopes[i] = [wi, hi] ，表示第 i 个信封的宽度和高度。
//    当另一个信封的宽度和高度都比这个信封大的时候，这个信封就可以放进另一个信封里，如同俄罗斯套娃一样。
//    请计算 最多能有多少个 信封能组成一组“俄罗斯套娃”信封（即可以把一个信封放到另一个信封里面）。
//    注意：不允许旋转信封。
//    示例 1：
//    输入：envelopes = [[5,4],[6,4],[6,7],[2,3]]
//    输出：3
//    解释：最多信封的个数为 3, 组合为: [2,3] => [5,4] => [6,7]。
//    示例 2：
//    输入：envelopes = [[1,1],[1,1],[1,1]]
//    输出：1
//    提示：
//    1 <= envelopes.length <= 5000
//    envelopes[i].length == 2
//    1 <= wi, hi <= 104
//    链接：https://leetcode-cn.com/problems/russian-doll-envelopes
    class func maxEnvelopes(_ envelopes: [[Int]]) -> Int {
        //解法2：先对w递增排序，w相同就对h降序排序，最后对h求最长递增子序列
        let array = envelopes.sorted { (envelope1, envelope2) -> Bool in
            if envelope1[0] > envelope2[0] {
                return false
            }else if envelope1[0] == envelope2[0] {
                return envelope2[1] > envelope1[1]
            }else {
                return true
            }
        }
//        print(array)
        //dp[i] 以下标i结尾的数组的最长子序列长度
        //求dp[5],找出前面比nums[5]小的dp[i]，然后+1
        var dp = Array(repeating: 1, count: array.count)
        var maxLen = 1
        var i = 1
        while i < array.count {
            let arrI = array[i]
            var j = i - 1
            while j >= 0 {
                let arrJ = array[j]
                if arrI[0] > arrJ[0] && arrI[1] > arrJ[1] {
                    dp[i] = max(dp[i], dp[j] + 1)
                    maxLen = max(dp[i], maxLen)
                }
                j -= 1
            }
            i += 1
        }
        
        return maxLen
    }
    
//    300. 最长递增子序列
//    给你一个整数数组 nums ，找到其中最长严格递增子序列的长度。
//    子序列是由数组派生而来的序列，删除（或不删除）数组中的元素而不改变其余元素的顺序。例如，[3,6,2,7] 是数组 [0,3,1,6,2,2,7] 的子序列。
//    示例 1：
//    输入：nums = [10,9,2,5,3,7,101,18]
//    输出：4
//    解释：最长递增子序列是 [2,3,7,101]，因此长度为 4 。
//    示例 2：
//    输入：nums = [0,1,0,3,2,3]
//    输出：4
//    示例 3：
//    输入：nums = [7,7,7,7,7,7,7]
//    输出：1
//    提示：
//    1 <= nums.length <= 2500
//    -104 <= nums[i] <= 104
//    进阶：
//    你可以设计时间复杂度为 O(n2) 的解决方案吗？
//    你能将算法的时间复杂度降低到 O(n log(n)) 吗?
//    链接：https://leetcode-cn.com/problems/longest-increasing-subsequence
    class func lengthOfLIS(_ nums: [Int]) -> Int {
        //dp[i] 以下标i结尾的数组的最长子序列长度
        //求dp[5],找出前面比nums[5]小的dp[i]，然后+1
        var dp = Array(repeating: 1, count: nums.count)
        var maxLen = 1
        var i = 1
        while i < nums.count {
            let numI = nums[i]
            var j = i - 1
            while j >= 0 {
                let numJ = nums[j]
                if numI > numJ {
                    dp[i] = max(dp[i], dp[j] + 1)
                    maxLen = max(maxLen, dp[i])
                }
                j -= 1
            }
            i += 1
        }
        return maxLen
    }
}
