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
//        print(minimumDeleteSum("sea", "eat"))//231
//        print(minimumDeleteSum("delete", "leet"))//403
        
//        516. 最长回文子序列
//        print(longestPalindromeSubseq("bbbab"))//4
//        print(longestPalindromeSubseq("cbbd"))//2
        
//        188. 买卖股票的最佳时机 IV
//        print(maxProfit(2, [2,4,1]))//2
//        print(maxProfit(2, [3,2,6,5,0,3]))//7
        
//        121. 买卖股票的最佳时机
//        print(maxProfit1([7,1,5,3,6,4]))//5
//        print(maxProfit1([7,6,4,3,1]))//0
        
//        122. 买卖股票的最佳时机 II
//        print(maxProfit2([7,1,5,3,6,4]))//7
//        print(maxProfit2([1,2,3,4,5]))//4
//        print(maxProfit2([7,6,4,3,1]))//0
        
//        123. 买卖股票的最佳时机 III
//        print(maxProfit3([3,3,5,0,0,3,1,4]))//6
//        print(maxProfit3([1,2,3,4,5]))//4
//        print(maxProfit3([7,6,4,3,1]))//0
//        print(maxProfit3([1]))//0
        
//        309. 最佳买卖股票时机含冷冻期
//        print(maxProfit4([1,2,3,0,2]))//3
        
//        714. 买卖股票的最佳时机含手续费
//        print(maxProfit5([1, 3, 2, 8, 4, 9], 2))//8
//        print(maxProfit5([1,3,7,5,10,3], 3))//6
        
//        198. 打家劫舍
//        print(rob([1,2,3,1]))//4
//        print(rob([2,7,9,3,1]))//12
        //    213. 打家劫舍 II
//        print(rob1([2,3,2]))//3
//        print(rob1([1,2,3,1]))//4
//        print(rob1([0]))//0
        
        
    }
    //    337. 打家劫舍 III
    //    在上次打劫完一条街道之后和一圈房屋后，小偷又发现了一个新的可行窃的地区。这个地区只有一个入口，我们称之为“根”。 除了“根”之外，每栋房子有且只有一个“父“房子与之相连。一番侦察之后，聪明的小偷意识到“这个地方的所有房屋的排列类似于一棵二叉树”。 如果两个直接相连的房子在同一天晚上被打劫，房屋将自动报警。
    //
    //    计算在不触动警报的情况下，小偷一晚能够盗取的最高金额。
    //
    //    示例 1:
    //
    //    输入: [3,2,3,null,3,null,1]
    //
    //         3
    //        / \
    //       2   3
    //        \   \
    //         3   1
    //
    //    输出: 7
    //    解释: 小偷一晚能够盗取的最高金额 = 3 + 3 + 1 = 7.
    //    示例 2:
    //
    //    输入: [3,4,5,1,3,null,1]
    //
    //         3
    //        / \
    //       4   5
    //      / \   \
    //     1   3   1
    //
    //    输出: 9
    //    解释: 小偷一晚能够盗取的最高金额 = 4 + 5 = 9.
    //    https://leetcode-cn.com/problems/house-robber-iii/
    class func rob2(_ root: TreeNode?) -> Int {
        return 0
    }
        
    //    213. 打家劫舍 II
    //    你是一个专业的小偷，计划偷窃沿街的房屋，每间房内都藏有一定的现金。这个地方所有的房屋都 围成一圈 ，这意味着第一个房屋和最后一个房屋是紧挨着的。同时，相邻的房屋装有相互连通的防盗系统，如果两间相邻的房屋在同一晚上被小偷闯入，系统会自动报警 。
    //    给定一个代表每个房屋存放金额的非负整数数组，计算你 在不触动警报装置的情况下 ，今晚能够偷窃到的最高金额。
    //    示例 1：
    //    输入：nums = [2,3,2]
    //    输出：3
    //    解释：你不能先偷窃 1 号房屋（金额 = 2），然后偷窃 3 号房屋（金额 = 2）, 因为他们是相邻的。
    //    示例 2：
    //    输入：nums = [1,2,3,1]
    //    输出：4
    //    解释：你可以先偷窃 1 号房屋（金额 = 1），然后偷窃 3 号房屋（金额 = 3）。
    //         偷窃到的最高金额 = 1 + 3 = 4 。
    //    示例 3：
    //    输入：nums = [0]
    //    输出：0
    //    提示：
    //    1 <= nums.length <= 100
    //    0 <= nums[i] <= 1000
    //    https://leetcode-cn.com/problems/house-robber-ii/
        class func rob1(_ nums: [Int]) -> Int {
            if nums.count == 1 {
                return nums[0]
            }
            //dp[i][k][0] = max(dp[i-1][k][1],dp[i-2][k][1])
            //dp[i][k][1] = max(dp[i-1][0] + nums[i],dp[i-2][1] + nums[i])
            var dp = Array(repeating: Array(repeating: [0,0], count: 2), count: nums.count)
            dp[0][1][1] = nums[0]
            dp[0][1][0] = -10000
            dp[0][0][1] = -10000
            dp[0][0][0] = 0
            
            dp[1][1][1] = -10000
            dp[1][1][0] = nums[0]
            dp[1][0][1] = nums[1]
            dp[1][0][0] = 0
            var i = 2
            while i < nums.count {
                dp[i][0][0] = max(dp[i-1][0][1],dp[i-2][0][1])
                dp[i][1][0] = max(dp[i-1][1][1],dp[i-2][1][1])
                dp[i][0][1] = max(dp[i-1][0][0] + nums[i],dp[i-2][0][1] + nums[i])
                if i == nums.count - 1 {
                    dp[i][1][1] = -10000
                }else {
                    dp[i][1][1] = max(dp[i-1][1][0] + nums[i],dp[i-2][1][1] + nums[i])
                }
                i += 1
            }
            let len = nums.count - 1
            let array = [dp[len][0][0],dp[len][1][0],dp[len][0][1],dp[len][1][1]]
            var maxVal = 0
            for item in array {
                maxVal = max(maxVal,item)
            }
            return maxVal
        }
        
        
    //    198. 打家劫舍
    //    你是一个专业的小偷，计划偷窃沿街的房屋。每间房内都藏有一定的现金，影响你偷窃的唯一制约因素就是相邻的房屋装有相互连通的防盗系统，如果两间相邻的房屋在同一晚上被小偷闯入，系统会自动报警。
    //    给定一个代表每个房屋存放金额的非负整数数组，计算你 不触动警报装置的情况下 ，一夜之内能够偷窃到的最高金额。
    //    示例 1：
    //    输入：[1,2,3,1]
    //    输出：4
    //    解释：偷窃 1 号房屋 (金额 = 1) ，然后偷窃 3 号房屋 (金额 = 3)。
    //         偷窃到的最高金额 = 1 + 3 = 4 。
    //    示例 2：
    //    输入：[2,7,9,3,1]
    //    输出：12
    //    解释：偷窃 1 号房屋 (金额 = 2), 偷窃 3 号房屋 (金额 = 9)，接着偷窃 5 号房屋 (金额 = 1)。
    //         偷窃到的最高金额 = 2 + 9 + 1 = 12 。
    //    提示：
    //    1 <= nums.length <= 100
    //    0 <= nums[i] <= 400
    //    https://leetcode-cn.com/problems/house-robber/
        class func rob(_ nums: [Int]) -> Int {
            if nums.count == 1 {
                return nums[0]
            }
            //dp[i][0] = max(dp[i-1][1],dp[i-2][1])
            //dp[i][1] = max(dp[i-1][0] + nums[i],dp[i-2][1] + nums[i])
            var dp = Array(repeating: [0,0], count: nums.count)
            dp[0][1] = nums[0]
            dp[1][1] = nums[1]
            dp[1][0] = nums[0]
            var i = 2
            while i < nums.count {
                dp[i][0] = max(dp[i-1][1],dp[i-2][1])
                dp[i][1] = max(dp[i-1][0] + nums[i],dp[i-2][1] + nums[i])
                i += 1
            }
            return max(dp[nums.count - 1][0],dp[nums.count - 1][1])
        }
    
//    714. 买卖股票的最佳时机含手续费
//    给定一个整数数组 prices，其中第 i 个元素代表了第 i 天的股票价格 ；整数 fee 代表了交易股票的手续费用。
//    你可以无限次地完成交易，但是你每笔交易都需要付手续费。如果你已经购买了一个股票，在卖出它之前你就不能再继续购买股票了。
//    返回获得利润的最大值。
//    注意：这里的一笔交易指买入持有并卖出股票的整个过程，每笔交易你只需要为支付一次手续费。
//    示例 1：
//    输入：prices = [1, 3, 2, 8, 4, 9], fee = 2
//    输出：8
//    解释：能够达到的最大利润:
//    在此处买入 prices[0] = 1
//    在此处卖出 prices[3] = 8
//    在此处买入 prices[4] = 4
//    在此处卖出 prices[5] = 9
//    总利润: ((8 - 1) - 2) + ((9 - 4) - 2) = 8
//    示例 2：
//    输入：prices = [1,3,7,5,10,3], fee = 3
//    输出：6
//    提示：
//    1 <= prices.length <= 5 * 104
//    1 <= prices[i] < 5 * 104
//    0 <= fee < 5 * 104
//    https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-with-transaction-fee/
    class func maxProfit5(_ prices: [Int], _ fee: Int) -> Int {
//        dp[i][0] = max(dp[i-1][0],dp[i-1][1] + prices[i] - fee)
//        dp[i][1] = max(dp[i-1][1],dp[i-1][0] - prices[i])
        var dp = Array(repeating: [-50000,-50000], count: prices.count)
        var maxVal = 0
        dp[0][0] = 0
        dp[0][1] = -prices[0]
        var i = 1
        while i < prices.count {
            dp[i][0] = max(dp[i-1][0],dp[i-1][1] + prices[i] - fee)
            dp[i][1] = max(dp[i-1][1],dp[i-1][0] - prices[i])
            maxVal = max(maxVal, max(dp[i][0],dp[i][1]))
            i += 1
        }
        return maxVal
    }
    
//    309. 最佳买卖股票时机含冷冻期
//    给定一个整数数组，其中第 i 个元素代表了第 i 天的股票价格 。
//    设计一个算法计算出最大利润。在满足以下约束条件下，你可以尽可能地完成更多的交易（多次买卖一支股票）:
//    你不能同时参与多笔交易（你必须在再次购买前出售掉之前的股票）。
//    卖出股票后，你无法在第二天买入股票 (即冷冻期为 1 天)。
//    示例:
//    输入: [1,2,3,0,2]
//    输出: 3
//    解释: 对应的交易状态为: [买入, 卖出, 冷冻期, 买入, 卖出]
    class func maxProfit4(_ prices: [Int]) -> Int {
//        dp[i][0] = max(dp[i-1][0],dp[i-1][1] + prices[i])
//        dp[i][1] = max(dp[i-1][1],dp[i-2][0] - prices[i])
        if prices.count < 2 {
            return 0
        }
        var dp = Array(repeating: [-100000,-10000], count: prices.count)
        var maxVal = 0
        dp[0][1] = -prices[0]
        dp[0][0] = 0
        var i = 1
        while i < prices.count {
            if i == 1 {
                dp[i][1] = max(dp[i-1][1],dp[i-1][0] - prices[i])
                dp[i][0] = max(dp[i-1][0],dp[i-1][1] + prices[i])
            }else {
                dp[i][0] = max(dp[i-1][0],dp[i-1][1] + prices[i])
                dp[i][1] = max(dp[i-1][1],dp[i-2][0] - prices[i])
            }
            maxVal = max(maxVal, max(dp[i][0], dp[i][1]))
            i += 1
        }
        return maxVal
    }
    
//    123. 买卖股票的最佳时机 III
//    给定一个数组，它的第 i 个元素是一支给定的股票在第 i 天的价格。
//    设计一个算法来计算你所能获取的最大利润。你最多可以完成 两笔 交易。
//    注意：你不能同时参与多笔交易（你必须在再次购买前出售掉之前的股票）。
//    示例 1:
//    输入：prices = [3,3,5,0,0,3,1,4]
//    输出：6
//    解释：在第 4 天（股票价格 = 0）的时候买入，在第 6 天（股票价格 = 3）的时候卖出，这笔交易所能获得利润 = 3-0 = 3 。
//         随后，在第 7 天（股票价格 = 1）的时候买入，在第 8 天 （股票价格 = 4）的时候卖出，这笔交易所能获得利润 = 4-1 = 3 。
//    示例 2：
//    输入：prices = [1,2,3,4,5]
//    输出：4
//    解释：在第 1 天（股票价格 = 1）的时候买入，在第 5 天 （股票价格 = 5）的时候卖出, 这笔交易所能获得利润 = 5-1 = 4 。
//         注意你不能在第 1 天和第 2 天接连购买股票，之后再将它们卖出。
//         因为这样属于同时参与了多笔交易，你必须在再次购买前出售掉之前的股票。
//    示例 3：
//    输入：prices = [7,6,4,3,1]
//    输出：0
//    解释：在这个情况下, 没有交易完成, 所以最大利润为 0。
//    示例 4：
//    输入：prices = [1]
//    输出：0
//    提示：
//    1 <= prices.length <= 105
//    0 <= prices[i] <= 105
    class func maxProfit3(_ prices: [Int]) -> Int {
        if prices.count < 2 {
            return 0
        }
        var dp = Array(repeating: Array(repeating: [-100001,-100001], count: 3), count: prices.count)
        //dp[i][k][0] = max(dp[i-1][k][0],dp[i-1][k][1] + prices[i])
        //dp[i][k][1] = max(dp[i-1][k][1],dp[i-1][k - 1][0] - prices[i])
        dp[0][0][0] = 0
        dp[0][1][1] = -prices[0]
        var maxVal = 0
        var i = 1
        while i < prices.count {
            var k = 0
            while k < 3 {
                if k == 0 {
                    dp[i][k][0] = 0
                    dp[i][k][1] = 0
                }else {
                    dp[i][k][0] = max(dp[i-1][k][0],dp[i-1][k][1] + prices[i])
                    dp[i][k][1] = max(dp[i-1][k][1],dp[i-1][k - 1][0] - prices[i])
                }
                maxVal = max(maxVal,max(dp[i][k][1], dp[i][k][0]))
                k += 1
            }
            i += 1
        }
        return maxVal
    }
    
//    122. 买卖股票的最佳时机 II
//    给定一个数组 prices ，其中 prices[i] 是一支给定股票第 i 天的价格。
//    设计一个算法来计算你所能获取的最大利润。你可以尽可能地完成更多的交易（多次买卖一支股票）。
//    注意：你不能同时参与多笔交易（你必须在再次购买前出售掉之前的股票）。
//    示例 1:
//    输入: prices = [7,1,5,3,6,4]
//    输出: 7
//    解释: 在第 2 天（股票价格 = 1）的时候买入，在第 3 天（股票价格 = 5）的时候卖出, 这笔交易所能获得利润 = 5-1 = 4 。
//         随后，在第 4 天（股票价格 = 3）的时候买入，在第 5 天（股票价格 = 6）的时候卖出, 这笔交易所能获得利润 = 6-3 = 3 。
//    示例 2:
//    输入: prices = [1,2,3,4,5]
//    输出: 4
//    解释: 在第 1 天（股票价格 = 1）的时候买入，在第 5 天 （股票价格 = 5）的时候卖出, 这笔交易所能获得利润 = 5-1 = 4 。
//         注意你不能在第 1 天和第 2 天接连购买股票，之后再将它们卖出。因为这样属于同时参与了多笔交易，你必须在再次购买前出售掉之前的股票。
//    示例 3:
//    输入: prices = [7,6,4,3,1]
//    输出: 0
//    解释: 在这种情况下, 没有交易完成, 所以最大利润为 0。
//    提示：
//    1 <= prices.length <= 3 * 104
//    0 <= prices[i] <= 104
    class func maxProfit2(_ prices: [Int]) -> Int {
//        dp[i][0] = max(dp[i-1][0],dp[i-1][1] + prices[i])
//        dp[i][1] = max(dp[i-1][1],dp[i-1][0] - prices[i])
        if prices.count == 0 {
            return 0
        }
        var dp = Array(repeating: [-10001,-10001], count: prices.count)
        var maxVal = 0
        dp[0][1] = -prices[0]
        dp[0][0] = 0
        var i = 1
        while i < prices.count {
            dp[i][0] = max(dp[i-1][0],dp[i-1][1] + prices[i])
            dp[i][1] = max(dp[i-1][1],dp[i-1][0] - prices[i])
            maxVal = max(maxVal,max(dp[i][0], dp[i][1]))
            i += 1
        }
        return maxVal
    }

    
//    121. 买卖股票的最佳时机
//    给定一个数组 prices ，它的第 i 个元素 prices[i] 表示一支给定股票第 i 天的价格。
//    你只能选择 某一天 买入这只股票，并选择在 未来的某一个不同的日子 卖出该股票。设计一个算法来计算你所能获取的最大利润。
//    返回你可以从这笔交易中获取的最大利润。如果你不能获取任何利润，返回 0 。
//    示例 1：
//    输入：[7,1,5,3,6,4]
//    输出：5
//    解释：在第 2 天（股票价格 = 1）的时候买入，在第 5 天（股票价格 = 6）的时候卖出，最大利润 = 6-1 = 5 。
//         注意利润不能是 7-1 = 6, 因为卖出价格需要大于买入价格；同时，你不能在买入前卖出股票。
//    示例 2：
//    输入：prices = [7,6,4,3,1]
//    输出：0
//    解释：在这种情况下, 没有交易完成, 所以最大利润为 0。
//    提示：
//    1 <= prices.length <= 105
//    0 <= prices[i] <= 104
    class func maxProfit1(_ prices: [Int]) -> Int {
        //dp[i][0] = max(dp[i-1][0],dp[i-1][1] + prices[i])
        //dp[i][1] = max(dp[i-1][1], -prices[i])
        if prices.count == 0 {
            return 0
        }
        var dp = Array(repeating: [0,0], count: prices.count)
        var maxValue = 0
        dp[0][0] = 0
        dp[0][1] = -prices[0]
        var i = 1
        while i < prices.count {
            dp[i][0] = max(dp[i-1][0],dp[i-1][1] + prices[i])
            dp[i][1] = max(dp[i-1][1],-prices[i])
            maxValue = max(maxValue,max(dp[i][0],dp[i][1]))
            i += 1
        }
        return maxValue
    }
    
//    188. 买卖股票的最佳时机 IV
//    给定一个整数数组 prices ，它的第 i 个元素 prices[i] 是一支给定的股票在第 i 天的价格。
//    设计一个算法来计算你所能获取的最大利润。你最多可以完成 k 笔交易。
//    注意：你不能同时参与多笔交易（你必须在再次购买前出售掉之前的股票）。
//    示例 1：
//    输入：k = 2, prices = [2,4,1]
//    输出：2
//    解释：在第 1 天 (股票价格 = 2) 的时候买入，在第 2 天 (股票价格 = 4) 的时候卖出，这笔交易所能获得利润 = 4-2 = 2 。
//    示例 2：
//    输入：k = 2, prices = [3,2,6,5,0,3]
//    输出：7
//    解释：在第 2 天 (股票价格 = 2) 的时候买入，在第 3 天 (股票价格 = 6) 的时候卖出, 这笔交易所能获得利润 = 6-2 = 4 。
//         随后，在第 5 天 (股票价格 = 0) 的时候买入，在第 6 天 (股票价格 = 3) 的时候卖出, 这笔交易所能获得利润 = 3-0 = 3 。
//    提示：
//    0 <= k <= 100
//    0 <= prices.length <= 1000
//    0 <= prices[i] <= 1000
    class func maxProfit(_ k: Int, _ prices: [Int]) -> Int {
        if k == 0 || prices.count == 0 {
            return 0
        }
        var dp = Array(repeating: Array(repeating: [-1001,-1001], count: k + 1), count: prices.count)
        
        //dp[i][k][0] = max(dp[i-1][k][0],dp[i-1][k][1] + prices[i])
        //dp[i][k][1] = max(dp[i-1][k][1],dp[i-1][k - 1][0] - prices[i])
        dp[0][1][1] = -prices[0]
        dp[0][0][0] = 0
        var maxValue = 0
        var i = 1
        while i < prices.count {
            var kk = 0
            while kk < k + 1 {
                if kk == 0 {
                    dp[i][0][0] = 0
                    dp[i][0][1] = 0
                }else {
                    dp[i][kk][0] = max(dp[i-1][kk][0],dp[i-1][kk][1] + prices[i])
                    dp[i][kk][1] = max(dp[i-1][kk][1],dp[i-1][kk - 1][0] - prices[i])
                    maxValue = max(maxValue, max(dp[i][kk][0],dp[i][kk][1]))
                }
                kk += 1
            }
            i += 1
        }
        return maxValue
    }
    
//    416. 分割等和子集
//    给你一个 只包含正整数 的 非空 数组 nums 。请你判断是否可以将这个数组分割成两个子集，使得两个子集的元素和相等。
//    示例 1：
//    输入：nums = [1,5,11,5]
//    输出：true
//    解释：数组可以分割成 [1, 5, 5] 和 [11] 。
//    示例 2：
//    输入：nums = [1,2,3,5]
//    输出：false
//    解释：数组不能分割成两个元素和相等的子集。
//    提示：
//    1 <= nums.length <= 200
//    1 <= nums[i] <= 100
//    链接：https://leetcode-cn.com/problems/partition-equal-subset-sum
    class func canPartition(_ nums: [Int]) -> Bool {
        var sum = 0
        for item in nums {
            sum += item
        }
        if sum % 2 == 0 {
            sum = sum / 2
            
        }
        return false
    }
    
//    516. 最长回文子序列
//    给定一个字符串 s ，找到其中最长的回文子序列，并返回该序列的长度。可以假设 s 的最大长度为 1000 。
//    示例 1:
//    输入:
//    "bbbab"
//    输出:
//    4
//    一个可能的最长回文子序列为 "bbbb"。
//    示例 2:
//    输入:
//    "cbbd"
//    输出:
//    2
//    一个可能的最长回文子序列为 "bb"。
//    提示：
//    1 <= s.length <= 1000
//    s 只包含小写英文字母
//    链接：https://leetcode-cn.com/problems/longest-palindromic-subsequence
    class func longestPalindromeSubseq(_ s: String) -> Int {
        //在子数组array[i..j]中，我们要求的子序列（最长回文子序列）的长度为dp[i][j]。
        //        bbbab
//                  0 1 2 3 4
//                0 1       x
//                1   1
//                2     1
//                3       1
//                4         1
//        dp[0][4] dp[1][3]
//        dp[1][3] dp[2][2]
//        dp[0][3] dp[1][2]
        
        let array = Array(s)
        var dp = Array(repeating: Array(repeating: 1, count: array.count), count: array.count)
        var i = array.count - 1
        while i >= 0 {
            var j = i
            while j < array.count {
                if j - i == 0 {
                    dp[i][j] = 1
                }else if j - i == 1 {
                    dp[i][j] = array[i] == array[j] ? 2 : 1
                }else {
                    if array[i] == array[j] {
                        dp[i][j] = dp[i + 1][j - 1] + 2
                    }else {
                        dp[i][j] = max(dp[i][j - 1], dp[i + 1][j])
                    }
                }
                j += 1
            }
            i -= 1
        }
        return dp[0][array.count - 1]
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
