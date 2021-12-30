//
//  回溯.swift
//  StyfStudyNotes
//
//  Created by styf on 2021/2/9.
//

import Foundation

//result = []
//def backtrack(路径, 选择列表):
//    if 满足结束条件:
//        result.add(路径)
//        return
//
//    for 选择 in 选择列表:
//        做选择
//        backtrack(路径, 选择列表)
//        撤销选择

@objcMembers class HuiSu: NSObject {
    class func test()  {
        //    698. 划分为k个相等的子集
//        print(canPartitionKSubsets ([1,1,1,1,2,2,2,2], 4))
        //    22. 括号生成
        print(generateParenthesis(3))
        print(generateParenthesis(1))
    }
    
//    22. 括号生成
//    数字 n 代表生成括号的对数，请你设计一个函数，用于能够生成所有可能的并且 有效的 括号组合。
//    示例 1：
//    输入：n = 3
//    输出：["((()))","(()())","(())()","()(())","()()()"]
//    示例 2：
//    输入：n = 1
//    输出：["()"]
//    提示：
//    1 <= n <= 8
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/generate-parentheses
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func generateParenthesis(_ n: Int) -> [String] {
        var leftCount = n
        var rightCount = n
        var res : [String] = []
        var string: [Character] = []
        generateParenthesisBacktrace(&leftCount, &rightCount, &res, &string)
        return res
    }
    class func generateParenthesisBacktrace(_ left: inout Int,_ right: inout Int,_ res: inout [String],_ string: inout [Character]) {
        if left == 0 && right == 0 {
            res.append(String(string))
            return
        }
        //做选择
        if left == right || left > 0 {
            string.append("(")
            left -= 1
            generateParenthesisBacktrace(&left, &right, &res, &string)
            left += 1
            string.removeLast()
        }
        if left < right && right > 0 {
            string.append(")")
            right -= 1
            generateParenthesisBacktrace(&left, &right, &res, &string)
            right += 1
            string.removeLast()
        }
    }
    
//    698. 划分为k个相等的子集
//    给定一个整数数组  nums 和一个正整数 k，找出是否有可能把这个数组分成 k 个非空子集，其总和都相等。
//    示例 1：
//    输入： nums = [4, 3, 2, 3, 5, 2, 1], k = 4
//    输出： True
//    说明： 有可能将其分成 4 个子集（5），（1,4），（2,3），（2,3）等于总和。
//    提示：
//    1 <= k <= len(nums) <= 16
//    0 < nums[i] < 10000
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/partition-to-k-equal-sum-subsets
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func canPartitionKSubsets(_ nums: [Int], _ k: Int) -> Bool {
        // 两个视角
        // 数字视角 n个数放进k个桶
        // 桶视角 每个桶遍历n个数
        var sum = 0
        var maxVal = 0
        for item in nums {
            sum += item
            maxVal = max(maxVal, item)
        }
        if sum % k != 0 {
            return false
        }
        let val = sum / k
        if maxVal > val {
            return false
        }
        var visited = Array(repeating: false, count: nums.count)
        var curSum = 0
        var curCount = 0
        return canPartitionKSubsetsBacktrace(nums, 0, &visited, &curSum, val, &curCount, k)
    }
    
    class func canPartitionKSubsetsBacktrace(_ nums: [Int],_ start:Int,_ visited: inout [Bool],_ sum: inout Int,_ val: Int,_ curCount:inout Int,_ k:Int) -> Bool {
        if curCount == k {
            return true
        }
        var i = start
        while i < nums.count {
            if !visited[i] && sum + nums[i] <= val {
                visited[i] = true
                sum += nums[i]
                if sum == val {
                    curCount += 1
                    var temp = 0
                    let flag = canPartitionKSubsetsBacktrace(nums, 0, &visited, &temp, val, &curCount, k)
                    if flag {
                        return true
                    }else {
                        curCount -= 1
                    }
                }else {
                    let flag = canPartitionKSubsetsBacktrace(nums, i + 1, &visited, &sum, val, &curCount, k)
                    if flag {
                        return true
                    }
                }
                visited[i] = false
                sum -= nums[i]
            }
            i += 1
        }
        return false
    }
}
