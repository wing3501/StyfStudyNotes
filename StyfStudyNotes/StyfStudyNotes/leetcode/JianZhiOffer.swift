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
            var left = -1
            var right = -1
            for ch in array {
                
            }
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

