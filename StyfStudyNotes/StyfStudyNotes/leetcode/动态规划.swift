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
        return 1
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
