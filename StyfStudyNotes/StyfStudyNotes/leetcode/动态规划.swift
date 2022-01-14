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

//KMP 模式匹配算法
// 用dp数组来保存状态切换   dp[j][c] = next   j 表示当前状态  c表示遇到的字符[0,255] next下一个状态
// dp[4]['A'] = 3 表示  当前是状态4，如果遇到A,则回到状态3
public class KMP {
    private var dp: [[Int]]
    private var pat: Array<Character>
    init(_ pat: String) {
        self.pat = Array(pat)
        let M = pat.count
        //dp[j][c] = next   j 表示当前状态  c表示遇到的字符[0,255] next下一个状态
        dp = Array(repeating: Array(repeating: 0, count: 256), count: M)
        //base case
        dp[0][Int(self.pat[0].asciiValue!)] = 1
        var j = 1
        var x = 0
        while j < M {
            let ch = Int(self.pat[j].asciiValue!)
            var c = 0
            while c < 256 {
                if ch == c {
                    //向前推进
                    dp[j][c] = j + 1
                }else {
                    //回到影子状态
                    dp[j][c] = dp[x][c]
                }
                c += 1
            }
            //更新影子状态
            //当前是状态x,遇到字符pat[j]
            //pat应该往哪里转移
            x = dp[x][ch]
            j += 1
        }
    }
    
    func search(_ text: String) -> Int {
        let M = pat.count
        let array = Array(text)
        let N = array.count
        var j = 0
        var i = 0
        while i < N {
            j = dp[j][Int(array[i].asciiValue!)]
            if j == M {
                return i - M + 1
            }
            i += 1
        }
        return -1
    }
}

// 贪心算法 最多能找到多少个不重叠
// 按end 排序

// 前缀和技巧 累加成N+1的新数组，可以得知 nums[i..j] = sum[j+1] - sum[i]  场景：原数组不变，频繁查询某个区间累加和
//    nums   3 5 2 -2 4 1
//  presum 0 3 8 10 8..  nums[0...3] = 10 - 0

// 差分数组技巧  diff[i] = nums[i]-nums[i-1]         场景：频繁对原数组的某个区间元素进行增减
//       原数组 res[i] = res[i - 1] + diff[i]
//       想要num[i..j]全部加3  需要diff[i] += 3   diff[j+1]-=3
//  nums 8  2  6  3  1
// diff  8 -6  4 -3  -2
class Difference {
    private var diff: [Int]
    public var result: [Int] {
        get {
            var res = [diff[0]]
            var i = 1
            while i < diff.count {
                res.append(res[i - 1] + diff[i])
                i += 1
            }
            return res
        }
    }
    init(_ array: [Int]) {
        //构建差分数组
        diff = [array[0]]
        var i = 1
        while i < array.count {
            diff.append(array[i] - array[i - 1])
            i += 1
        }
    }
    // 给[i,j]之间的元素加val
    func add(_ val:Int,_ i:Int,_ j:Int) {
        diff[i] += val
        if j + 1 < diff.count {
            diff[j + 1] -= val
        }
    }
    
}

// 大数乘法： num1 * num2 转化为 每个位单独相乘 num1[i] * num2[j] 的结果存放在数组res[i + j] 和 res[j + j + 1]上

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
        
//        337. 打家劫舍 III
//        let node = TreeTest.deserialize("[3,2,3,null,3,null,1]")
//        print(rob2(node))
//        let node1 = TreeTest.deserialize("[3,4,5,1,3,null,1]")
//        print(rob2(node1))
        

        //    931. 下降路径最小和
//        print(minFallingPathSum([[2,1,3],[6,5,4],[7,8,9]]))//13
//        print(minFallingPathSum([[-19,57],[-40,-5]]))//-59
//        print(minFallingPathSum([[-48]]))
        
        //    494. 目标和
//        print(findTargetSumWays([1,1,1,1,1], 3))
//        print(findTargetSumWays([1], 1))
        
//        416. 分割等和子集
//        print(canPartition([1,5,11,5]))//true
//        print(canPartition([1,2,3,5]))//false
//        print(canPartition([100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,99,97]))
        
        //    518. 零钱兑换 II
//        print(change(5, [1, 2, 5]))//4
//        print(change(3, [2]))//0
//        print(change(10, [10]))//1
        
        //    64. 最小路径和
//        print(minPathSum([[1,3,1], [1,5,1],[4,2,1]]))//7
//        print(minPathSum([[1,2,3], [4,5,6]]))//12
//        print(minPathSum([[1,2,3]]))//6
        
        //    174. 地下城游戏
//        print(calculateMinimumHP([[-2,-3,3],[-5,-10,1],[10,30,-5]]))//7
//        print(calculateMinimumHP([[1,-3,3],[0,-2,0],[-3,-3,-3]]))//3
//        print(calculateMinimumHP([[1,2,1],[-2,-3,-3],[3,2,-2]]))//1
        
//        514. 自由之路
//        print(findRotateSteps("godding", "gd"))//4
//        print(findRotateSteps("godding", "godding"))//13
        
        //    787. K 站中转内最便宜的航班
//        print(findCheapestPrice(3, [[0,1,100],[1,2,100],[0,2,500]], 0, 2, 1))//200
//        print(findCheapestPrice(3, [[0,1,100],[1,2,100],[0,2,500]], 0, 2, 0))//500
//        print(findCheapestPrice(5, [[0,1,5],[1,2,5],[0,3,2],[3,1,2],[1,4,1],[4,2,1]], 0, 2, 2))//7
//        print(findCheapestPrice(5, [[1,2,10],[2,0,7],[1,3,8],[4,0,10],[3,4,2],[4,2,10],[0,3,3],[3,1,6],[2,4,5]], 0, 4, 1))//5
//        print(findCheapestPrice(18, [[16,1,81],[15,13,47],[1,0,24],[5,10,21],[7,1,72],[0,4,88],[16,4,39],[9,3,25],[10,11,28],[13,8,93],[10,3,62],[14,0,38],[3,10,58],[3,12,46],[3,8,2],[10,16,27],[6,9,90],[14,8,6],[0,13,31],[6,4,65],[14,17,29],[13,17,64],[12,5,26],[12,1,9],[12,15,79],[16,11,79],[16,15,17],[4,0,21],[15,10,75],[3,17,23],[8,5,55],[9,4,19],[0,10,83],[3,7,17],[0,12,31],[11,5,34],[17,14,98],[11,14,85],[16,7,48],[12,6,86],[5,17,72],[4,12,5],[12,10,23],[3,2,31],[12,7,5],[6,13,30],[6,7,88],[2,17,88],[6,8,98],[0,7,69],[10,15,13],[16,14,24],[1,17,24],[13,9,82],[13,6,67],[15,11,72],[12,0,83],[1,4,37],[12,9,36],[9,17,81],[9,15,62],[8,15,71],[10,12,25],[7,6,23],[16,5,76],[7,17,4],[3,11,82],[2,11,71],[8,4,11],[14,10,51],[8,10,51],[4,1,57],[6,16,68],[3,9,100],[1,14,26],[10,7,14],[8,17,24],[1,11,10],[2,9,85],[9,6,49],[11,4,95]], 7, 2, 6))//169
//
//        print(findCheapestPrice(17, [[0,12,28],[5,6,39],[8,6,59],[13,15,7],[13,12,38],[10,12,35],[15,3,23],[7,11,26],[9,4,65],[10,2,38],[4,7,7],[14,15,31],[2,12,44],[8,10,34],[13,6,29],[5,14,89],[11,16,13],[7,3,46],[10,15,19],[12,4,58],[13,16,11],[16,4,76],[2,0,12],[15,0,22],[16,12,13],[7,1,29],[7,14,100],[16,1,14],[9,6,74],[11,1,73],[2,11,60],[10,11,85],[2,5,49],[3,4,17],[4,9,77],[16,3,47],[15,6,78],[14,1,90],[10,5,95],[1,11,30],[11,0,37],[10,4,86],[0,8,57],[6,14,68],[16,8,3],[13,0,65],[2,13,6],[5,13,5],[8,11,31],[6,10,20],[6,2,33],[9,1,3],[14,9,58],[12,3,19],[11,2,74],[12,14,48],[16,11,100],[3,12,38],[12,13,77],[10,9,99],[15,13,98],[15,12,71],[1,4,28],[7,0,83],[3,5,100],[8,9,14],[15,11,57],[3,6,65],[1,3,45],[14,7,74],[2,10,39],[4,8,73],[13,5,77],[10,0,43],[12,9,92],[8,2,26],[1,7,7],[9,12,10],[13,11,64],[8,13,80],[6,12,74],[9,7,35],[0,15,48],[3,7,87],[16,9,42],[5,16,64],[4,5,65],[15,14,70],[12,0,13],[16,14,52],[3,10,80],[14,11,85],[15,2,77],[4,11,19],[2,7,49],[10,7,78],[14,6,84],[13,7,50],[11,6,75],[5,10,46],[13,8,43],[9,10,49],[7,12,64],[0,10,76],[5,9,77],[8,3,28],[11,9,28],[12,16,87],[12,6,24],[9,15,94],[5,7,77],[4,10,18],[7,2,11],[9,5,41]], 13, 4, 13))
        
        //    887. 鸡蛋掉落
//        print(superEggDrop(1, 2))//2
//        print(superEggDrop(2, 6))//3
//        print(superEggDrop(3, 14))//4
//        print(superEggDrop(7, 100000))//
        
        //    10. 正则表达式匹配
//        print(isMatch("aa", "a"))//false
//        print(isMatch("aa", "a*"))//true
//        print(isMatch("ab", ".*"))//true
//        print(isMatch("aab", "c*a*b"))//true
//        print(isMatch("mississippi", "mis*is*p*."))//false
//        print(isMatch("ab", ".*c"))//false
//        print(isMatch("a", "ab*"))//true
//        print(isMatch("bbbba", ".*a*a"))//true
        
        //    312. 戳气球
//        print(maxCoins([3,1,5,8]))//167
//        print(maxCoins([1,5]))//10
        
        //4键问题 dp[i]第i次操作后，A的数量
        //dp[i] = max(这次按下A，这次按下Ctrl+V)
        
        //    1312. 让字符串成为回文串的最少插入次数
//        print(minInsertions("zzazz"))//0
//        print(minInsertions("mbadm"))//2
//        print(minInsertions("leetcode"))//5
//        print(minInsertions("g"))//0
//        print(minInsertions("no"))//1
//        print(minInsertions("zjveiiwvc"))//5
        
//        435. 无重叠区间
//        print(eraseOverlapIntervals([ [1,2], [2,3], [3,4], [1,3] ]))//1
//        print(eraseOverlapIntervals([ [1,2], [1,2], [1,2] ]))//2
//        print(eraseOverlapIntervals([ [1,2], [2,3] ]))//0
        
//        452. 用最少数量的箭引爆气球
//        print(findMinArrowShots([[10,16],[2,8],[1,6],[7,12]]))//2
//        print(findMinArrowShots([[1,2],[3,4],[5,6],[7,8]]))//4
//        print(findMinArrowShots([[1,2],[2,3],[3,4],[4,5]]))//2
//        print(findMinArrowShots([[1,2]]))//1
//        print(findMinArrowShots([[2,3],[2,3]]))//1
//        print(findMinArrowShots([[1,2],[4,5],[1,5]]))//2
//        print(findMinArrowShots([[9,12],[1,10],[4,11],[8,12],[3,9],[6,9],[6,7]]))//2
        
        //    252 会议室
//        print(huiyishi1([[0,30],[5,10],[15,20]]))//false
//        print(huiyishi1([[7,10],[2,4]]))//true
        
//        253. 会议室 II
//        print(huiyishi2([[0, 30],[5, 10],[15, 20]]))
//        print(huiyishi2([[7,10],[2,4]]))
        
        //    1109. 航班预订统计
//        print(corpFlightBookings([[1,2,10],[2,3,20],[2,5,25]], 5))
        
        //    1024. 视频拼接
//        print(videoStitching([[0,2],[4,6],[8,10],[1,9],[1,5],[5,9]], 10))//3
//        print(videoStitching([[0,1],[1,2]], 5))//-1
//        print(videoStitching([[0,1],[6,8],[0,2],[5,6],[0,4],[0,3],[6,7],[1,3],[4,7],[1,4],[2,5],[2,6],[3,4],[4,5],[5,7],[6,9]], 9))//3
//        print(videoStitching([[0,4],[2,8]], 5))//2
//        print(videoStitching([[0,2],[1,6],[3,10]], 10))//3
//        print(videoStitching([[3,12],[7,14],[9,14],[12,15],[0,9],[4,14],[2,7],[1,11]], 10))//2
        
        //    55. 跳跃游戏
//        print(canJump([2,3,1,1,4]))
//        print(canJump([3,2,1,0,4]))
//        print(canJump([2,0,0]))
        
        //    134. 加油站
        print(canCompleteCircuit([1,2,3,4,5], [3,4,5,1,2]))//3
        print(canCompleteCircuit([2,3,4], [3,4,3]))
    }
//    134. 加油站
//    在一条环路上有 N 个加油站，其中第 i 个加油站有汽油 gas[i] 升。
//    你有一辆油箱容量无限的的汽车，从第 i 个加油站开往第 i+1 个加油站需要消耗汽油 cost[i] 升。你从其中的一个加油站出发，开始时油箱为空。
//    如果你可以绕环路行驶一周，则返回出发时加油站的编号，否则返回 -1。
//    说明:
//    如果题目有解，该答案即为唯一答案。
//    输入数组均为非空数组，且长度相同。
//    输入数组中的元素均为非负数。
//    示例 1:
//    输入:
//    gas  = [1,2,3,4,5]
//    cost = [3,4,5,1,2]
//    输出: 3
//    解释:
//    从 3 号加油站(索引为 3 处)出发，可获得 4 升汽油。此时油箱有 = 0 + 4 = 4 升汽油
//    开往 4 号加油站，此时油箱有 4 - 1 + 5 = 8 升汽油
//    开往 0 号加油站，此时油箱有 8 - 2 + 1 = 7 升汽油
//    开往 1 号加油站，此时油箱有 7 - 3 + 2 = 6 升汽油
//    开往 2 号加油站，此时油箱有 6 - 4 + 3 = 5 升汽油
//    开往 3 号加油站，你需要消耗 5 升汽油，正好足够你返回到 3 号加油站。
//    因此，3 可为起始索引。
//    示例 2:
//    输入:
//    gas  = [2,3,4]
//    cost = [3,4,3]
//    输出: -1
//    解释:
//    你不能从 0 号或 1 号加油站出发，因为没有足够的汽油可以让你行驶到下一个加油站。
//    我们从 2 号加油站出发，可以获得 4 升汽油。 此时油箱有 = 0 + 4 = 4 升汽油
//    开往 0 号加油站，此时油箱有 4 - 3 + 2 = 3 升汽油
//    开往 1 号加油站，此时油箱有 3 - 3 + 3 = 3 升汽油
//    你无法返回 2 号加油站，因为返程需要消耗 4 升汽油，但是你的油箱只有 3 升汽油。
//    因此，无论怎样，你都不可能绕环路行驶一周。
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/gas-station
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        // 贪心解法
        // 如果i无法走到j，那么i---j之间的任何位置都无法走到j
        
        
        // 图解法
        // 想象成环图，每个节点就是 gas[i] - cost[i] （到达下一站的状态）
        // 问题转换为： 从哪个节点开始，能让累加和一直保持>=0
        // 在坐标系上，就是寻找最低点
        var sum = 0
        var minSum = 0
        var i = 0
        var j = 0
        while i < gas.count {
            sum += gas[i] - cost[i]
            if sum < minSum {//经过这个点，会到达一个最低点
                minSum = sum
                j = i + 1
            }
            i += 1
        }
        if sum < 0 {
            return -1
        }
        return j == gas.count ? 0 : j
        // 勉强能过
//        guard gas.count > 1 else { return gas[0] >= cost[0] ? 0 : -1 }
//        var i = 0
//        var sumGas = 0
//        var sumCost = 0
//        var canTrys: [[Int]] = []
//        while i < gas.count {
//            let g = gas[i]
//            let c = cost[i]
//            sumGas += g
//            sumCost += c
//            if g > c {
//                canTrys.append([i,g,c])
//            }
//            i += 1
//        }
//        if sumGas < sumCost {
//            return -1
//        }
//        canTrys.sort { a, b in
//            return a[1]-a[2] > b[1]-b[2]
//        }
//        var gas1 = gas
//        gas1.append(contentsOf: gas)
//        var cost1 = cost
//        cost1.append(contentsOf: cost)
//        for item in canTrys {
//            i = item[0]
//            var left = 0
//            while i < item[0] + gas.count {
//                left += gas1[i]
//                left -= cost1[i]
//                if left < 0 {
//                    break
//                }
//                i += 1
//            }
//            if i == item[0] + gas.count {
//                return item[0]
//            }
//        }
//        return -1
    }
//    45. 跳跃游戏 II
//    给你一个非负整数数组 nums ，你最初位于数组的第一个位置。
//    数组中的每个元素代表你在该位置可以跳跃的最大长度。
//    你的目标是使用最少的跳跃次数到达数组的最后一个位置。
//    假设你总是可以到达数组的最后一个位置。
//    示例 1:
//    输入: nums = [2,3,1,1,4]
//    输出: 2
//    解释: 跳到最后一个位置的最小跳跃数是 2。
//         从下标为 0 跳到下标为 1 的位置，跳 1 步，然后跳 3 步到达数组的最后一个位置。
//    示例 2:
//    输入: nums = [2,3,0,1,4]
//    输出: 2
//    提示:
//    1 <= nums.length <= 104
//    0 <= nums[i] <= 1000
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/jump-game-ii
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func jump(_ nums: [Int]) -> Int {
        //动态规划超时
        
        //贪心算法
//        [5,....]
        //如果最远能跳5，那无论这次选择跳1234，之后必经过5，所以i = 5的时候 step
        //也因为无论选择1-5，最远的是far,后面也必经过far
        var step = 0
        var end = 0
        var far = 0
        var i = 0
        while i < nums.count - 1 {
            far = max(far, i + nums[i])//能跳的最远的地方
            if end == i {
                end = far
                step += 1
            }
            i += 1
        }
        return step
    }
//    55. 跳跃游戏
//    给定一个非负整数数组 nums ，你最初位于数组的 第一个下标 。
//    数组中的每个元素代表你在该位置可以跳跃的最大长度。
//    判断你是否能够到达最后一个下标。
//    示例 1：
//    输入：nums = [2,3,1,1,4]
//    输出：true
//    解释：可以先跳 1 步，从下标 0 到达下标 1, 然后再从下标 1 跳 3 步到达最后一个下标。
//    示例 2：
//    输入：nums = [3,2,1,0,4]
//    输出：false
//    解释：无论怎样，总会到达下标为 3 的位置。但该下标的最大跳跃长度是 0 ， 所以永远不可能到达最后一个下标。
//    提示：
//    1 <= nums.length <= 3 * 104
//    0 <= nums[i] <= 105
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/jump-game
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func canJump(_ nums: [Int]) -> Bool {
        //贪心算法
        var i = 0
        var long = 0
        while i < nums.count - 1 {
            long = max(long,i + nums[i])//不断计算能到的最远位置
            if long <= i {//当前是0，之前的也没能跳过i这个位置
                return false
            }
            i += 1
        }
        return long >= nums.count - 1
        
        //dp[i][j] = dp[i][i + 1] && dp[i + 1][j] ...   dp[0][1] dp[1][5]
        // dp[3][4] = nums[3] > 0
        //  0 1 2 3 4 5
        //0 1 x a   b
        //1   1       x
        //2     1     a
        //3       1
        //4         1 b
        //5           1
        // base base dp[0][0] = true
        // 超时
//        var dp = Array(repeating: Array(repeating: false, count: nums.count), count: nums.count)
//        var i = nums.count - 1
//        while i >= 0 {
//            var j = i
//            while j < nums.count {
//                let steps = nums[i]
//                if j - i <= steps {
//                    dp[i][j] = true
//                }else {
//                    var s = 1
//                    while s <= steps {
//                        dp[i][j] = dp[i][i + s] && dp[i + s][j]
//                        if dp[i][j] {
//                            break
//                        }
//                        s += 1
//                    }
//                }
//                j += 1
//            }
//            i -= 1
//        }
//        return dp[0][nums.count - 1]
    }
    
    
    
//    1024. 视频拼接
//    你将会获得一系列视频片段，这些片段来自于一项持续时长为 time 秒的体育赛事。这些片段可能有所重叠，也可能长度不一。
//    使用数组 clips 描述所有的视频片段，其中 clips[i] = [starti, endi] 表示：某个视频片段开始于 starti 并于 endi 结束。
//    甚至可以对这些片段自由地再剪辑：
//    例如，片段 [0, 7] 可以剪切成 [0, 1] + [1, 3] + [3, 7] 三部分。
//    我们需要将这些片段进行再剪辑，并将剪辑后的内容拼接成覆盖整个运动过程的片段（[0, time]）。返回所需片段的最小数目，如果无法完成该任务，则返回 -1 。
//    示例 1：
//    输入：clips = [[0,2],[4,6],[8,10],[1,9],[1,5],[5,9]], time = 10
//    输出：3
//    解释：
//    选中 [0,2], [8,10], [1,9] 这三个片段。
//    然后，按下面的方案重制比赛片段：
//    将 [1,9] 再剪辑为 [1,2] + [2,8] + [8,9] 。
//    现在手上的片段为 [0,2] + [2,8] + [8,10]，而这些覆盖了整场比赛 [0, 10]。
//    示例 2：
//    输入：clips = [[0,1],[1,2]], time = 5
//    输出：-1
//    解释：
//    无法只用 [0,1] 和 [1,2] 覆盖 [0,5] 的整个过程。
//    示例 3：
//    输入：clips = [[0,1],[6,8],[0,2],[5,6],[0,4],[0,3],[6,7],[1,3],[4,7],[1,4],[2,5],[2,6],[3,4],[4,5],[5,7],[6,9]], time = 9
//    输出：3
//    解释：
//    选取片段 [0,4], [4,7] 和 [6,9] 。
//    示例 4：
//    输入：clips = [[0,4],[2,8]], time = 5
//    输出：2
//    解释：
//    注意，你可能录制超过比赛结束时间的视频。
//    提示：
//    1 <= clips.length <= 100
//    0 <= starti <= endi <= 100
//    1 <= time <= 100
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/video-stitching
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func videoStitching(_ clips: [[Int]], _ time: Int) -> Int {
        let array = clips.sorted { a, b in
            //按 start 升序  end降序
            a[0] == b[0] ? a[1] > b[1] : a[0] < b[0]
        }
        //得出第一个肯定是要的
        var cur = array[0]
        if cur[0] != 0 {
            return -1
        }
        var count = 1
        if cur[1] >= time {
            return 1//已经达标了
        }
        var i = 1
        
        while i < array.count {
            var j = i
            var choose: [Int]?
            while j < array.count {
                let next = array[j]
                if array[j][0] <= cur[1] {
                    if choose == nil {
                        choose = next
                    }else {
                        //哪个end更大就要哪个
                        choose = next[1] > choose![1] ? next : choose
                    }
                }else {
                    break
                }
                j += 1
            }
            if choose == nil {
                return -1
            }
            count += 1
            cur = choose!
            if cur[1] >= time {
                break//提前达标
            }
            i = j
        }
        if cur[1] < time {
            return -1
        }
        return count
    }
    
//    1109. 航班预订统计
//    这里有 n 个航班，它们分别从 1 到 n 进行编号。
//    有一份航班预订表 bookings ，表中第 i 条预订记录 bookings[i] = [firsti, lasti, seatsi] 意味着在从 firsti 到 lasti （包含 firsti 和 lasti ）的 每个航班 上预订了 seatsi 个座位。
//    请你返回一个长度为 n 的数组 answer，里面的元素是每个航班预定的座位总数。
//    示例 1：
//    输入：bookings = [[1,2,10],[2,3,20],[2,5,25]], n = 5
//    输出：[10,55,45,25,25]
//    解释：
//    航班编号        1   2   3   4   5
//    预订记录 1 ：   10  10
//    预订记录 2 ：       20  20
//    预订记录 3 ：       25  25  25  25
//    总座位数：      10  55  45  25  25
//    因此，answer = [10,55,45,25,25]
//    示例 2：
//    输入：bookings = [[1,2,10],[2,2,15]], n = 2
//    输出：[10,25]
//    解释：
//    航班编号        1   2
//    预订记录 1 ：   10  10
//    预订记录 2 ：       15
//    总座位数：      10  25
//    因此，answer = [10,25]
//    提示：
//    1 <= n <= 2 * 104
//    1 <= bookings.length <= 2 * 104
//    bookings[i].length == 3
//    1 <= firsti <= lasti <= n
//    1 <= seatsi <= 104
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/corporate-flight-bookings
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func corpFlightBookings(_ bookings: [[Int]], _ n: Int) -> [Int] {
        let array = Array(repeating: 0, count: n)
        let diff = Difference(array)
        for item in bookings {
            diff.add(item[2], item[0] - 1, item[1] - 1)
        }
        return diff.result
    }
//    253. 会议室 II
//    给定一个会议时间安排的数组，每个会议时间都会包括开始和结束的时间 [[s1,e1],[s2,e2],...] (si < ei)，为避免会议冲突，同时要考虑充分利用会议室资源，请你计算至少需要多少间会议室，才能满足这些会议安排。
//    示例 1:
//    输入: [[0, 30],[5, 10],[15, 20]]
//    输出: 2
//    示例 2:
//    输入: [[7,10],[2,4]]
//    输出: 1
    class func huiyishi2(_ array:[[Int]]) -> Int {
        //扫描线解法
        guard array.count > 0 else { return 0 }
        var start: [Int] = []
        var end: [Int] = []
        var i = 0
        while i < array.count {
            start.append(array[i][0])
            end.append(array[i][1])
            i += 1
        }
        start.sort()
        end.sort()
        var ptr1 = 0
        var ptr2 = 0
        var count = 0
        var result = 0
        while ptr1 < start.count && ptr2 < end.count {
            if ptr1 == start.count {
                //剩下的都是结束点了
                ptr2 += 1
                count -= 1
            }else {
                let s = start[ptr1]
                let e = end[ptr2]
                if e > s {
                    count += 1
                    ptr1 += 1
                    result = max(result, count)
                }else {
                    count -= 1
                    ptr2 += 1
                }
            }
        }
        return result
        
        
        //差分数组解法
//        guard array.count > 0 else { return 0 }
//        var start = Int.max
//        var end = -1
//        for item in array {
//            start = min(start, item[0])
//            end = max(end, item[1])
//        }
////        1 5
//        let n = end - start + 1
//        let arr = Array(repeating: 0, count: n)
//        let diff = Difference(arr)
//        for item in array {
//            diff.add(1, item[0] - start, item[1] - start)
//        }
//
//        let result = diff.result
//        var maxRoom = 0
//        for item in result {
//            maxRoom = max(maxRoom,item)
//        }
//        return maxRoom
        
        //效率低
//        guard array.count > 0 else { return 0 }
//        let arr = array.sorted { a, b in
//            return a[1] < b[1]
//        }
//        var holdRooms: [[Int]] = [arr[0]]
//        var maxCount = 1
//        var i = 1
//        while i < arr.count {
//            let cur = arr[i]
//            var find: [Int]?
//            var j = 0
//            while j < holdRooms.count {
//                let item = holdRooms[j]
//                if cur[0] >= item[1] {
//                    find = item
//                    holdRooms[j] = cur
//                    break
//                }
//                j += 1
//            }
//
//            if find == nil {
//                holdRooms.append(cur)
//                maxCount = max(maxCount, holdRooms.count)
//            }
//            i += 1
//        }
//        return maxCount
    }
    
//    252 会议室
//    题目描述
//    给定一个会议时间安排的数组，每个会议时间都会包括开始和结束的时间 [[s1,e1],[s2,e2],...] (si < ei)，请你判断一个人是否能够参加这里面的全部会议。
//    示例 1:
//    输入: [[0,30],[5,10],[15,20]]
//    输出: false
//    示例 2:
//    输入: [[7,10],[2,4]]
//    输出: true
    class func huiyishi1(_ array:[[Int]]) -> Bool {
        guard array.count > 0 else { return true }
        let arr = array.sorted { a, b in
            return a[1] < b[1]
        }
        var cur = arr[0]
        var i = 1
        while i < arr.count {
            if arr[i][0] < cur[1] {
                return false
            }
            cur = arr[i]
            i += 1
        }
        return true
    }
    
//    452. 用最少数量的箭引爆气球
//    在二维空间中有许多球形的气球。对于每个气球，提供的输入是水平方向上，气球直径的开始和结束坐标。由于它是水平的，所以纵坐标并不重要，因此只要知道开始和结束的横坐标就足够了。开始坐标总是小于结束坐标。
//    一支弓箭可以沿着 x 轴从不同点完全垂直地射出。在坐标 x 处射出一支箭，若有一个气球的直径的开始和结束坐标为 xstart，xend， 且满足  xstart ≤ x ≤ xend，则该气球会被引爆。可以射出的弓箭的数量没有限制。 弓箭一旦被射出之后，可以无限地前进。我们想找到使得所有气球全部被引爆，所需的弓箭的最小数量。
//    给你一个数组 points ，其中 points [i] = [xstart,xend] ，返回引爆所有气球所必须射出的最小弓箭数。
//    示例 1：
//    输入：points = [[10,16],[2,8],[1,6],[7,12]]
//    输出：2
//    解释：对于该样例，x = 6 可以射爆 [2,8],[1,6] 两个气球，以及 x = 11 射爆另外两个气球
//    示例 2：
//    输入：points = [[1,2],[3,4],[5,6],[7,8]]
//    输出：4
//    示例 3：
//    输入：points = [[1,2],[2,3],[3,4],[4,5]]
//    输出：2
//    示例 4：
//    输入：points = [[1,2]]
//    输出：1
//    示例 5：
//    输入：points = [[2,3],[2,3]]
//    输出：1
//    提示：
//    1 <= points.length <= 104
//    points[i].length == 2
//    -231 <= xstart < xend <= 231 - 1
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/minimum-number-of-arrows-to-burst-balloons
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func findMinArrowShots(_ points: [[Int]]) -> Int {
        // 按start排列，重叠的一箭
        guard points.count > 0 else { return 0 }
        let array = points.sorted { a, b in
            return a[1] < b[1]
        }
        var count = 1 //第一个球，肯定要一箭
        var cur = array[0]
        var i = 1
        while i < array.count {
            if array[i][0] > cur[1] {//这个球不重叠了，需要另一箭
                count += 1
                cur = array[i]
            }
            i += 1
        }
        return count
    }
//    435. 无重叠区间
//    给定一个区间的集合，找到需要移除区间的最小数量，使剩余区间互不重叠。
//    注意:
//    可以认为区间的终点总是大于它的起点。
//    区间 [1,2] 和 [2,3] 的边界相互“接触”，但没有相互重叠。
//    示例 1:
//    输入: [ [1,2], [2,3], [3,4], [1,3] ]
//    输出: 1
//    解释: 移除 [1,3] 后，剩下的区间没有重叠。
//    示例 2:
//    输入: [ [1,2], [1,2], [1,2] ]
//    输出: 2
//    解释: 你需要移除两个 [1,2] 来使剩下的区间没有重叠。
//    示例 3:
//    输入: [ [1,2], [2,3] ]
//    输出: 0
//    解释: 你不需要移除任何区间，因为它们已经是无重叠的了。
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/non-overlapping-intervals
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func eraseOverlapIntervals(_ intervals: [[Int]]) -> Int {
        guard intervals.count > 0 else { return 0 }
        // 贪心算法 最多能找到多少个不重叠
        // 按end 排序
        let array = intervals.sorted { a, b in
            return a[1] < b[1]
        }
        
        var count = 1 //多少个不重叠
        var cur = array[0]
        var i = 1
        while i < array.count {
            if array[i][0] >= cur[1] {
                count += 1
                cur = array[i]
            }
            i += 1
        }
        
        return array.count - count
    }
    
//    1312. 让字符串成为回文串的最少插入次数
//    给你一个字符串 s ，每一次操作你都可以在字符串的任意位置插入任意字符。
//    请你返回让 s 成为回文串的 最少操作次数 。
//    「回文串」是正读和反读都相同的字符串。
//    示例 1：
//    输入：s = "zzazz"
//    输出：0
//    解释：字符串 "zzazz" 已经是回文串了，所以不需要做任何插入操作。
//    示例 2：
//    输入：s = "mbadm"
//    输出：2
//    解释：字符串可变为 "mbdadbm" 或者 "mdbabdm" 。
//    示例 3：
//    输入：s = "leetcode"
//    输出：5
//    解释：插入 5 个字符后字符串变为 "leetcodocteel" 。
//    示例 4：
//    输入：s = "g"
//    输出：0
//    示例 5：
//    输入：s = "no"
//    输出：1
//    提示：
//    1 <= s.length <= 500
//    s 中所有字符都是小写字母。
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/minimum-insertion-steps-to-make-a-string-palindrome
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func minInsertions(_ s: String) -> Int {
        //  dp[i][j] 表示 s[i...j]之间的最少操作数次
        //  dp[i][j] == 0,i<=j
        //  dp[i][j] = min ( dp[i + 1][j] + 1,
        //                   dp[i][j - 1] + 1,
        //                   if(array[i] == array[j]) dp[i + 1][j - 1])
        //
        // 遍历方向
        //  0 1 2 3 4 5 6 7
        //0 0           a x
        //1 0 0         a a
        //2     0
        //3       0
        //4         0
        //5           0
        //6             0
        //7               0
//        01 12 ... 67
//        02 13 ... 57
        
        let array = Array(s)
        var dp = Array(repeating: Array(repeating: 0, count: array.count), count: array.count)
        var J = 1
        while J < array.count {
            var i = 0
            var j = J
            while j < array.count {
                if array[i] == array[j] {
                    dp[i][j] = dp[i + 1][j - 1]
                }else {
                    dp[i][j] = min(dp[i + 1][j] + 1, dp[i][j - 1] + 1)
                }
                i += 1
                j += 1
            }
            J += 1
        }
        return dp[0][array.count - 1]
    }
    
//    312. 戳气球
//    有 n 个气球，编号为0 到 n - 1，每个气球上都标有一个数字，这些数字存在数组 nums 中。
//    现在要求你戳破所有的气球。戳破第 i 个气球，你可以获得 nums[i - 1] * nums[i] * nums[i + 1] 枚硬币。 这里的 i - 1 和 i + 1 代表和 i 相邻的两个气球的序号。如果 i - 1或 i + 1 超出了数组的边界，那么就当它是一个数字为 1 的气球。
//    求所能获得硬币的最大数量。
//    示例 1：
//    输入：nums = [3,1,5,8]
//    输出：167
//    解释：
//    nums = [3,1,5,8] --> [3,5,8] --> [3,8] --> [8] --> []
//    coins =  3*1*5    +   3*5*8   +  1*3*8  + 1*8*1 = 167
//    示例 2：
//    输入：nums = [1,5]
//    输出：10
//    提示：
//    n == nums.length
//    1 <= n <= 500
//    0 <= nums[i] <= 100
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/burst-balloons
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func maxCoins(_ nums: [Int]) -> Int {
        // 核心： dp[i][j]  表示戳破 (i,j)之间后的最大值  给原数组前后，加一 则，dp[0][n+1] 就是最终要求的
        // 假设(i,j)之间 最后一个被戳破的为k
        // dp[i][j] = dp[i,k] + dp[k,j] + nums[i] * nums[k] * nums[j]
        // base case 当 j <= i + 1 时，dp[i][j] = 0
        
        //  0 1 2 3 4 5 6 7
        //0 0 a b       c x
        //1   0           a
        //2     0         b
        //3       0
        //4         0
        //5           0
        //6             0 c
        //7               0
        
        //0 - 7
        // k = 1 0-1 1-7
        // k = 2 0-2 2-7
        // k = 3 0-3 3-7
        guard nums.count > 0 else { return 0 }
        var array = [1]
        array.append(contentsOf: nums)
        array.append(1)
        let n = array.count
        var dp = Array(repeating: Array(repeating: 0, count: n), count: n)
        var i = n - 1
        while i >= 0 {
            var j = i + 1
            while j < n {
                if j <= i + 1 {
                    dp[i][j] = 0
                }else {
                    var maxVal = 0
                    var k = i + 1
                    while k < j {
                        let temp = dp[i][k] + dp[k][j] + array[i] * array[k] * array[j]
                        maxVal = max(maxVal,temp)
                        k += 1
                    }
                    dp[i][j] = maxVal
                }
                j += 1
            }
            i -= 1
        }
        return dp[0][n - 1]
    }
    
    
    
//    10. 正则表达式匹配
//    给你一个字符串 s 和一个字符规律 p，请你来实现一个支持 '.' 和 '*' 的正则表达式匹配。
//    '.' 匹配任意单个字符
//    '*' 匹配零个或多个前面的那一个元素
//    所谓匹配，是要涵盖 整个 字符串 s的，而不是部分字符串。
//    示例 1：
//    输入：s = "aa" p = "a"
//    输出：false
//    解释："a" 无法匹配 "aa" 整个字符串。
//    示例 2:
//    输入：s = "aa" p = "a*"
//    输出：true
//    解释：因为 '*' 代表可以匹配零个或多个前面的那一个元素, 在这里前面的元素就是 'a'。因此，字符串 "aa" 可被视为 'a' 重复了一次。
//    示例 3：
//    输入：s = "ab" p = ".*"
//    输出：true
//    解释：".*" 表示可匹配零个或多个（'*'）任意字符（'.'）。
//    示例 4：
//    输入：s = "aab" p = "c*a*b"
//    输出：true
//    解释：因为 '*' 表示零个或多个，这里 'c' 为 0 个, 'a' 被重复一次。因此可以匹配字符串 "aab"。
//    示例 5：
//    输入：s = "mississippi" p = "mis*is*p*."
//    输出：false
//    提示：
//    1 <= s.length <= 20
//    1 <= p.length <= 30
//    s 可能为空，且只包含从 a-z 的小写字母。
//    p 可能为空，且只包含从 a-z 的小写字母，以及字符 . 和 *。
//    保证每次出现字符 * 时，前面都匹配到有效的字符
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/regular-expression-matching
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func isMatch(_ s: String, _ p: String) -> Bool {
        let sArray = Array(s)
        let pArray = Array(p)
        if pArray.count == 0 {
            return false
        }
        var itemArray: [String] = []
        var i = 0
        while i < pArray.count {
            let ch = pArray[i]
            if i + 1 < pArray.count {
                let next = pArray[i + 1]
                if next == "*" {
                    itemArray.append("\(ch)*")
                    i += 2
                    continue
                }
            }
            itemArray.append(String(ch))
            i += 1
        }
        //dp[i][j] 从s的i开始 p的j开始 能否匹配成功
        //dp[i][j] = num[j] = “a” ?  dp[i+1][j+1] == true && s[i] == p[j]
        //                  = "." ?  dp[i+1][j+1] == true
        //                  = "a*" ? dp[i+1][j+1] == true || dp[i+2][j+1] == true || ...
        //                  = ".*" ? true
        var book = Array(repeating: Array(repeating: -1, count: pArray.count), count: sArray.count)
        return isMatchDp(sArray, 0, itemArray, 0, &book)
    }
    //从s的i开始 p的j开始 能否匹配成功
    class func isMatchDp(_ s:[Character],_ i: Int,_ p: [String],_ j: Int,_ book: inout [[Int]]) -> Bool {
        if i == s.count {
//            "a", "ab*" 如果剩下的都是带星的，也是正确的
            var jj = j
            while jj < p.count {
                if p[jj].count == 1 {
                    return false
                }
                jj += 1
            }
            return true
        }
        if j == p.count {
            //p不够匹配s的
            return false
        }
        if book[i][j] != -1 {
            return book[i][j] == 1
        }
        var ss = s[i]
        let pp = p[j]
        var res = false
        if pp == "." {
            res = isMatchDp(s, i + 1, p, j + 1, &book)
        }else if pp.count > 1 {//"a*"
            let ppArr = Array(pp)
            let ppCh = ppArr[0]
            if ppCh == "." {//特殊情况 .*
                //挨个匹配
                var move = 0
                while i + move <= s.count {
                    let temp = isMatchDp(s, i + move, p, j + 1, &book)
                    if temp {
                        res = temp
                        break
                    }else {
                        move += 1
                    }
                }
            }else {
                
                //一个都不匹配
                let temp = isMatchDp(s, i, p, j + 1, &book)
                if temp {
                    res = temp
                }else {
                    var move = 0
                    while ss == ppCh  {//当前已经匹配上了
                        let temp = isMatchDp(s, i + move, p, j + 1, &book)
                        if temp {
                            res = temp//后面的能匹配上
                            break
                        }else {
                            //试试能不能匹配多个
                            if i + move < s.count {
                                ss = s[i + move]
                                move += 1
                            }else {
                                break
                            }
                        }
                    }
                }
            }
        }else {
            res = (String(ss) == pp) && isMatchDp(s, i + 1, p, j + 1, &book)
        }
        book[i][j] = res ? 1 : 0
        return res
    }
    
//    887. 鸡蛋掉落
//    给你 k 枚相同的鸡蛋，并可以使用一栋从第 1 层到第 n 层共有 n 层楼的建筑。
//    已知存在楼层 f ，满足 0 <= f <= n ，任何从 高于 f 的楼层落下的鸡蛋都会碎，从 f 楼层或比它低的楼层落下的鸡蛋都不会破。
//    每次操作，你可以取一枚没有碎的鸡蛋并把它从任一楼层 x 扔下（满足 1 <= x <= n）。如果鸡蛋碎了，你就不能再次使用它。如果某枚鸡蛋扔下后没有摔碎，则可以在之后的操作中 重复使用 这枚鸡蛋。
//    请你计算并返回要确定 f 确切的值 的 最小操作次数 是多少？
//    示例 1：
//    输入：k = 1, n = 2
//    输出：2
//    解释：
//    鸡蛋从 1 楼掉落。如果它碎了，肯定能得出 f = 0 。
//    否则，鸡蛋从 2 楼掉落。如果它碎了，肯定能得出 f = 1 。
//    如果它没碎，那么肯定能得出 f = 2 。
//    因此，在最坏的情况下我们需要移动 2 次以确定 f 是多少。
//    示例 2：
//    输入：k = 2, n = 6
//    输出：3
//    示例 3：
//    输入：k = 3, n = 14
//    输出：4
//    提示：
//    1 <= k <= 100
//    1 <= n <= 104
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/super-egg-drop
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func superEggDrop(_ k: Int, _ n: Int) -> Int {
        
        //重新定义dp   dp[k][m] = n  当个数为k时，尝试m次，运气最差能测n层楼
        // dp[1][7] = 7  dp[7][1] = 1 dp[2][3] = dp[1][2] + dp[2][2] + 1
        // m最大就是n
        // base case dp[1][m] = m  dp[k][1] = 1
        // 可以优化到一维
        var dp = Array(repeating: Array(repeating: 0, count: n + 1), count: k + 1)
        var kk = 1
        while kk <= k {
            var m = 1
            while m <= n {
                if kk == 1 {
                    //一个鸡蛋只能下往上测
                    dp[kk][m] = m
                }else if m == 1 {
                    //只测一次就只能测一层
                    dp[kk][m] = 1
                }else {
                    //当前测的一层 + 碎了之后能测的 + 没碎能测的
                    dp[kk][m] = dp[kk - 1][m - 1] + dp[kk][m - 1] + 1
                }
                if kk == k && dp[kk][m] >= n {
                    return m
                }
                if dp[kk][m] >= n {
                    // 由左边的 和 左上的 相加得出当前，当前已经大于目标值了，对下一行没有帮助了
                    break
                }
                m += 1
            }
            kk += 1
        }
        return -1
        
        
        //二分优化  还是超时了
//        var book = Array(repeating: Array(repeating: -1, count: n + 1), count: k + 1)
//        return superEggDropDP1(k, n, &book)
        
        //超时了  dp定义 个数为 k 时，在区间1-N中找到f的最小操作次数
//        var book = Array(repeating: Array(repeating: -1, count: n + 1), count: k + 1)
//        return superEggDropDP(k, n, &book)
    }
    
    //个数为 k 时，在区间1-N中找到f的最小操作次数
    class func superEggDropDP1(_ k: Int, _ n: Int,_ book: inout [[Int]]) -> Int {
        if k == 1 {
            return n
        }
        if n == 0 {
            return 0
        }
        
        if book[k][n] != -1 {
            return book[k][n]
        }
        
        var res = Int.max
        //从i层开始尝试
        // 用二分来优化
        var left = 1
        var right = n
        while left <= right {
            let i = left + (right - left) / 2
            //碎了 往下找   k n 固定的情况下 随i单调递增
            let sui = superEggDropDP(k - 1, i - 1, &book)
            //没碎 往上找 随i单调递减
            let meisui = superEggDropDP(k, n - i, &book)
            
            if sui > meisui {
                right = i - 1
                res = min(res, sui + 1)
            }else {
                left = i + 1
                res = min(res, meisui + 1)
            }
        }
        book[k][n] = res
        return res
    }
    
    //个数为 k 时，在区间1-N中找到f的最小操作次数
    class func superEggDropDP(_ k: Int, _ n: Int,_ book: inout [[Int]]) -> Int {
        if k == 1 {
            return n
        }
        if n == 0 {
            return 0
        }
        
        if book[k][n] != -1 {
            return book[k][n]
        }
        
        var res = Int.max
        //从i层开始尝试
        var i = 1
        while i <= n {
            //碎了 往下找
            let sui = superEggDropDP(k - 1, i - 1, &book)
            //没碎 往上找
            let meisui = superEggDropDP(k, n - i, &book)
            
            res = min(res, max(sui, meisui) + 1)
            
            i += 1
        }
        book[k][n] = res
        return res
    }
    
//    787. K 站中转内最便宜的航班
//    有 n 个城市通过一些航班连接。给你一个数组 flights ，其中 flights[i] = [fromi, toi, pricei] ，表示该航班都从城市 fromi 开始，以价格 pricei 抵达 toi。
//    现在给定所有的城市和航班，以及出发城市 src 和目的地 dst，你的任务是找到出一条最多经过 k 站中转的路线，使得从 src 到 dst 的 价格最便宜 ，并返回该价格。 如果不存在这样的路线，则输出 -1。
//    示例 1：
//    输入:
//    n = 3, edges = [[0,1,100],[1,2,100],[0,2,500]]
//    src = 0, dst = 2, k = 1
//    输出: 200
//    解释:
//    城市航班图如下
//    示例 2：
//    输入:
//    n = 3, edges = [[0,1,100],[1,2,100],[0,2,500]]
//    src = 0, dst = 2, k = 0
//    输出: 500
//    解释:
//    城市航班图如下
//    提示：
//    1 <= n <= 100
//    0 <= flights.length <= (n * (n - 1) / 2)
//    flights[i].length == 3
//    0 <= fromi, toi < n
//    fromi != toi
//    1 <= pricei <= 104
//    航班没有重复，且不存在自环
//    0 <= src, dst, k < n
//    src != dst
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/cheapest-flights-within-k-stops
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func findCheapestPrice(_ n: Int, _ flights: [[Int]], _ src: Int, _ dst: Int, _ k: Int) -> Int {
        var graph :[Int:[[Int]]] = [:]   // from : [[flight]]
        for item in flights {
            let to = item[1]
            var flightArray = graph[to, default: []]
            flightArray.append(item)
            graph[to] = flightArray
        }
        var book = Array(repeating: Array(repeating: -888, count: k + 2), count: n)
        // 核心的状态是 dst 和  k
        return findCheapestPriceDP(graph, src, dst, k + 1, &book)
    }
    // k步内 从src到dst的最短路径
    class func findCheapestPriceDP(_ flights: [Int:[[Int]]],_ src: Int,_ dst: Int,_ k: Int,_ book: inout [[Int]]) -> Int {
        if src == dst {
            return 0
        }
        if k == 0 {
            return -1
        }
        if book[dst][k] != -888 {
            return book[dst][k]
        }
        var res = Int.max
        if let array = flights[dst] {
            for flight in array {
                let from = flight[0]
                let price = flight[2]
                
                let result = findCheapestPriceDP(flights, src, from, k - 1, &book)
                if result != -1 {//说明src --- from 能到    to
                    res = min(res, result + price)
                }
            }
        }
        res = res == Int.max ? -1 : res
        book[dst][k] = res
        return res
    }
    
//    514. 自由之路
//    电子游戏“辐射4”中，任务“通向自由”要求玩家到达名为“Freedom Trail Ring”的金属表盘，并使用表盘拼写特定关键词才能开门。
//    给定一个字符串 ring，表示刻在外环上的编码；给定另一个字符串 key，表示需要拼写的关键词。您需要算出能够拼写关键词中所有字符的最少步数。
//    最初，ring 的第一个字符与12:00方向对齐。您需要顺时针或逆时针旋转 ring 以使 key 的一个字符在 12:00 方向对齐，然后按下中心按钮，以此逐个拼写完 key 中的所有字符。
//    旋转 ring 拼出 key 字符 key[i] 的阶段中：
//    您可以将 ring 顺时针或逆时针旋转一个位置，计为1步。旋转的最终目的是将字符串 ring 的一个字符与 12:00 方向对齐，并且这个字符必须等于字符 key[i] 。
//    如果字符 key[i] 已经对齐到12:00方向，您需要按下中心按钮进行拼写，这也将算作 1 步。按完之后，您可以开始拼写 key 的下一个字符（下一阶段）, 直至完成所有拼写。
//    示例：
//    输入: ring = "godding", key = "gd"
//    输出: 4
//    解释:
//     对于 key 的第一个字符 'g'，已经在正确的位置, 我们只需要1步来拼写这个字符。
//     对于 key 的第二个字符 'd'，我们需要逆时针旋转 ring "godding" 2步使它变成 "ddinggo"。
//     当然, 我们还需要1步进行拼写。
//     因此最终的输出是 4。
//    提示：
//
//    ring 和 key 的字符串长度取值范围均为 1 至 100；
//    两个字符串中都只有小写字符，并且均可能存在重复字符；
//    字符串 key 一定可以由字符串 ring 旋转拼出。
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/freedom-trail
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func findRotateSteps(_ ring: String, _ key: String) -> Int {
        //dp[i][j] 当前位置在i时 走到key[j]需要的最小操作
        let rings = Array(ring)
        var ringDic:[Character : [Int]] = [:]
        var i = 0
        while i < rings.count {
            let ch = rings[i]
            var chArray = ringDic[ch, default: []]
            chArray.append(i)
            ringDic[ch] = chArray
            i += 1
        }
        let keyArray = Array(key)
        var book = Array(repeating: Array(repeating: -1, count: keyArray.count), count: rings.count)
        return findRotateStepsDP(rings, 0, keyArray, 0, ringDic, &book)
    }
    // 当前位置在i时 输入从j开始的key 需要的最少步数
    class func findRotateStepsDP(_ ring: [Character],_ i: Int,_ key: [Character],_ j: Int,_ ringDic:[Character : [Int]],_ book: inout [[Int]]) -> Int {
        if j == key.count {
            return 0
        }
        if book[i][j] != -1 {
            return book[i][j]
        }
        let indexArray = ringDic[key[j]]!
        var res = Int.max
        for targetIndex in indexArray {
            //i走到 targetIndex的最小步数
            var step = abs(i - targetIndex)
            step = min(step, ring.count - step)
            
            //从targetIndex开始，输入从j+ 1开始的key 需要的最少步数
            let nextStep = findRotateStepsDP(ring, targetIndex, key, j + 1, ringDic, &book)
            res = min(res, step + nextStep)
        }
        res += 1
        book[i][j] = res
        return res
    }
    
    
//    174. 地下城游戏
//    一些恶魔抓住了公主（P）并将她关在了地下城的右下角。地下城是由 M x N 个房间组成的二维网格。我们英勇的骑士（K）最初被安置在左上角的房间里，他必须穿过地下城并通过对抗恶魔来拯救公主。
//    骑士的初始健康点数为一个正整数。如果他的健康点数在某一时刻降至 0 或以下，他会立即死亡。
//    有些房间由恶魔守卫，因此骑士在进入这些房间时会失去健康点数（若房间里的值为负整数，则表示骑士将损失健康点数）；其他房间要么是空的（房间里的值为 0），要么包含增加骑士健康点数的魔法球（若房间里的值为正整数，则表示骑士将增加健康点数）。
//    为了尽快到达公主，骑士决定每次只向右或向下移动一步。
//    编写一个函数来计算确保骑士能够拯救到公主所需的最低初始健康点数。
//    例如，考虑到如下布局的地下城，如果骑士遵循最佳路径 右 -> 右 -> 下 -> 下，则骑士的初始健康点数至少为 7。
//    -2 (K) -3    3
//    -5    -10    1
//    10    30    -5 (P)
//    说明:
//    骑士的健康点数没有上限。
//    任何房间都可能对骑士的健康点数造成威胁，也可能增加骑士的健康点数，包括骑士进入的左上角房间以及公主被监禁的右下角房间。
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/dungeon-game
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func calculateMinimumHP(_ dungeon: [[Int]]) -> Int {
        // dp[m][n]  表示从(m,n) 到 终点 所需要的
        // 初始小的路 less = min(dp[m][n + 1] , dp[m + 1][n])
        // dp[m][n] = less - num[m][n] > 0  ? less - num[m][n] : 1
        // 求dp[0][0]
        // base case dp[m][n] = nums[m][n] > 0 ? 1 : 1 - nums[m][n]
        // 降维 一维
        
        var dp = Array(repeating: 0, count: dungeon[0].count)
        let last = dungeon.last!.last!
        dp[dungeon[0].count - 1] = last > 0 ? 1 : 1 - last
        
        var m = dungeon.count - 1
        while m >= 0 {
            var n = dungeon[0].count - 1
            while n >= 0 {
                let num = dungeon[m][n]
                if m == dungeon.count - 1 {
                    if n < dungeon[0].count - 1 {
                        //最后一行
                        dp[n] = dp[n + 1] - num > 0 ? dp[n + 1] - num : 1
                    }
                }else {
                    if n == dungeon[0].count - 1 {
                        //最后一列
                        dp[n] = dp[n] - num > 0 ? dp[n] - num : 1
                    }else {
                        let less = min(dp[n], dp[n + 1])
                        dp[n] = less - num > 0 ? less - num : 1
                    }
                }
                n -= 1
            }
            m -= 1
        }
        return dp[0]
    }
    
    
    
//    64. 最小路径和
//    给定一个包含非负整数的 m x n 网格 grid ，请找出一条从左上角到右下角的路径，使得路径上的数字总和为最小。
//    说明：每次只能向下或者向右移动一步。
//    示例 1：
//    输入：grid = [[1,3,1],
//                [1,5,1],
//                [4,2,1]]
//    输出：7
//    解释：因为路径 1→3→1→1→1 的总和最小。
//    示例 2：
//    输入：grid = [[1,2,3],
//                [4,5,6]]
//    输出：12
//    提示：
//    m == grid.length
//    n == grid[i].length
//    1 <= m, n <= 200
//    0 <= grid[i][j] <= 100
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/minimum-path-sum
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func minPathSum(_ grid: [[Int]]) -> Int {
        // dp[m][n] 到mn的最小路径和
        // 状态转移 dp[m][n] = min(dp[m][n - 1] + dp[m - 1][n]) + grid[m][n]
        // base case  第一行累加
        // 降维打击  一维解决
        
        var dp: [Int] = []
        var sum = 0
        for item in grid[0] {
            sum += item
            dp.append(sum)
        }
        var m = 1
        while m < grid.count {
            var n = 0
            while n < grid[0].count {
                if n - 1 >= 0 {
                    dp[n] = min(dp[n], dp[n - 1])
                }
                dp[n] += grid[m][n]
                n += 1
            }
            m += 1
        }
        return dp.last!
    }
    
//    518. 零钱兑换 II
//    给你一个整数数组 coins 表示不同面额的硬币，另给一个整数 amount 表示总金额。
//    请你计算并返回可以凑成总金额的硬币组合数。如果任何硬币组合都无法凑出总金额，返回 0 。
//    假设每一种面额的硬币有无限个。
//    题目数据保证结果符合 32 位带符号整数。
//    示例 1：
//    输入：amount = 5, coins = [1, 2, 5]
//    输出：4
//    解释：有四种方式可以凑成总金额：
//    5=5
//    5=2+2+1
//    5=2+1+1+1
//    5=1+1+1+1+1
//    示例 2：
//    输入：amount = 3, coins = [2]
//    输出：0
//    解释：只用面额 2 的硬币不能凑成总金额 3 。
//    示例 3：
//    输入：amount = 10, coins = [10]
//    输出：1
//    提示：
//    1 <= coins.length <= 300
//    1 <= coins[i] <= 5000
//    coins 中的所有值 互不相同
//    0 <= amount <= 5000
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/coin-change-2
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func change(_ amount: Int, _ coins: [Int]) -> Int {
        //dp[i][j]  容量为j时，只使用前i种物品，有多少种方法可以装满
        //dp[i - 1][j] 前i-1件可以装满的次数
        //dp[i - 1][j - num] ... dp[i - 1][j - num * n]
        
//        var dp = Array(repeating: 0, count: amount + 1)
//        dp[0] = 1
//        var i = 1
//        while i <= coins.count {
//            let num = coins[i - 1]
//            var j = amount
//            while j >= 0 {
//                if j - num >= 0 {
//                    dp[j] = dp[j]
//                    var k = 1
//                    while j - num * k >= 0 {
//                        dp[j] += dp[j - num * k]
//                        k += 1
//                    }
//                }else {
//                    dp[j] = dp[j]
//                }
//                j -= 1
//            }
//            i += 1
//        }
//        return dp[amount]
        
        
        //不放入i dp[i][j] = dp[i - 1][j]
        //放入i   dp[i][j] = dp[i - 1][j] + dp[i][j - num]
        
        var dp = Array(repeating: 0, count: amount + 1)
        dp[0] = 1
        var i = 1
        while i <= coins.count {
            let num = coins[i - 1]
            var j = 1
            while j <= amount {
                if j - num >= 0 {
                    dp[j] = dp[j] + dp[j - num]
                }else {
                    dp[j] = dp[j]
                }
                j += 1
            }
            i += 1
        }
        return dp[amount]
    }
    
//    494. 目标和
//    给你一个整数数组 nums 和一个整数 target 。
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
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/target-sum
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func findTargetSumWays(_ nums: [Int], _ target: Int) -> Int {
        // 把nums分成A B 两组，表示 + 的数 和 -的数
        // A - B = sum(nums)
        // A + B = target
        //------------------
        // 2A = sum(nums) + target
        // A = (sum(nums) + target) / 2
        // nums中有几种和为A的方式
        
        var sum = 0
        for item in nums {
            sum += item
        }
        if sum < target || (sum + target) % 2 == 1 || -sum > target {
            return 0
        }
        
        let A = (sum + target) / 2
        // 转换为背包问题 dp[i][j] 当容量为j时，前i个元素有几种方式装满 求dp[nums.count][A]
        // 状态转移 dp[i][j] = dp[i - 1][j] + dp[i - 1][j - nums[i - 1]]
        // base case
        // dp[0][...] = 0  dp[...][0] = 1 //表示容量为0只有一种方式就是 不装
        // i = 0...nums.count    j = 0...A
        
        var dp = Array(repeating: 0, count: A + 1)//存上一行
        dp[0] = 1 //base case
        var dp1 = Array(repeating: 0, count: A + 1)
        var i = 1
        while i <= nums.count {
            var j = 0
            let num = nums[i - 1]
            while j <= A{
                dp1[j] = dp[j]
                if j - num >= 0 {
                    dp1[j] += dp[j - num]
                }
                j += 1
            }
            dp = dp1
            dp1[0] = 1
            i += 1
        }
        return dp[A]
    }
//    931. 下降路径最小和
//    给你一个 n x n 的 方形 整数数组 matrix ，请你找出并返回通过 matrix 的下降路径 的 最小和 。
//    下降路径 可以从第一行中的任何元素开始，并从每一行中选择一个元素。在下一行选择的元素和当前行所选元素最多相隔一列（即位于正下方或者沿对角线向左或者向右的第一个元素）。具体来说，位置 (row, col) 的下一个元素应当是 (row + 1, col - 1)、(row + 1, col) 或者 (row + 1, col + 1) 。
//    示例 1：
//    输入：matrix = [[2,1,3],[6,5,4],[7,8,9]]
//    输出：13
//    解释：下面是两条和最小的下降路径，用加粗+斜体标注：
//    [[2,1,3],  1    [[2,1,3], 1
//     [6,5,4],   5    [6,5,4], 4
//     [7,8,9]]    7   [7,8,9]]  8
//    示例 2：
//    输入：matrix = [[-19,57],[-40,-5]]
//    输出：-59
//    解释：下面是一条和最小的下降路径，用加粗+斜体标注：
//    [[-19,57],  -19
//     [-40,-5]] -40
//    示例 3：
//    输入：matrix = [[-48]]
//    输出：-48
//    提示：
//    n == matrix.length
//    n == matrix[i].length
//    1 <= n <= 100
//    -100 <= matrix[i][j] <= 100
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/minimum-falling-path-sum
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func minFallingPathSum(_ matrix: [[Int]]) -> Int {
        //dp[i][j]   第i行j列的最小和+
        // dp[i][j] = min(dp[i-1][j]，dp[i-1][j - 1]，dp[i-1][j + 1]) + matrix[i][j]
        // base case 就是第一行
        // 结果 result min(dp[i][j])
        
        if matrix.count == 1 {
            return matrix[0][0]
        }
        var dp = Array(repeating: Array(repeating: 100, count: matrix.count), count: matrix.count)
        // base case
        var i = 0
        while i < matrix.count {
            dp[0][i] = matrix[0][i]
            i += 1
        }
        i = 1
        while i < matrix.count {
            var j = 0
            while j < matrix.count {
                dp[i][j] = dp[i - 1][j]
                if j - 1 >= 0 {
                    dp[i][j] = min(dp[i][j], dp[i - 1][j - 1])
                }
                if j + 1 < matrix.count {
                    dp[i][j] = min(dp[i][j], dp[i - 1][j + 1])
                }
                dp[i][j] += matrix[i][j]
                j += 1
            }
            i += 1
        }
        
        i = 0
        var minSum = dp[matrix.count - 1][0]
        while i < matrix.count {
            minSum = min(minSum, dp[matrix.count - 1][i])
            i += 1
        }
        return minSum
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
        //rob(root)[0] = max(rob(left)[0],rob(left)[1]) + max(rob(right)[0],rob(right)[1])
        //rob(root)[1] = rob(left)[0] + rob(right)[0] + rootVal
        var book = [String: Int]()
        return max(robHelper(root, true, &book),robHelper(root, false, &book))
    }
    
    class func robHelper(_ root: TreeNode?,_ isRob:Bool,_ book: inout [String: Int]) -> Int {
        guard let node = root else { return 0 }
        var node1 = node
        let ptr = withUnsafePointer(to: &node1) { UnsafeRawPointer($0)}
        let nodeAddress = ptr.load(as: UInt.self)
        let key = "\(nodeAddress)_\(isRob)"
        if let val = book[key] {
            return val
        }
        var val = 0
        if isRob {
            val = robHelper (node.left, false, &book) + robHelper(node.right, false, &book) + node.val
        }else {
            val = max(robHelper(node.left, true, &book),robHelper(node.left, false, &book)) + max(robHelper(node.right, true, &book),robHelper(node.right, false, &book))
        }
        book[key] = val
        return val
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
            //三种情况：只考虑1-(len-1) 0-(len-2)两种情况
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
            //其他：用一组数组解，从i开始抢的最大金额
            
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
            // 转化为背包问题
            //dp[i][j]  当容量为j时，前i个元素有多少种方式装满 求dp[n][sum]
            //i = 0...n  j = 0...sum
            //dp[i][j] = dp[i-1][j] + dp[i-1][j-nums[i - 1]]
            //base case dp[0][...] = 0  dp[...][0] = 1
            var dp = Array(repeating: false, count: sum + 1)//上一行
            dp[0] = true
            var dp1 = Array(repeating: false, count: sum + 1)
            var i = 1
            while i <= nums.count {
                let num = nums[i - 1]
                var j = 0
                while j <= sum {
                    dp1[j] = dp[j]//i-1个数是否已经能装满了
                    if j - num >= 0 && !dp1[j] {
                        dp1[j] = dp[j - num]
                    }
                    j += 1
                }
                dp = dp1
                dp1[0] = true
                i += 1
            }
            return dp[sum]
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
        //纸牌分堆
        //每张牌，只能接在比它大的牌下面
        //没有比它大的，就新开一个牌堆
        //牌堆数就是最长个数
        
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
