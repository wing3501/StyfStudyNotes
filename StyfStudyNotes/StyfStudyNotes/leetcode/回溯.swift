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
//        print(generateParenthesis(3))
//        print(generateParenthesis(1))
//        37. 解数独
        var board: [[Character]] = [["5","3",".",".","7",".",".",".","."],
                         ["6",".",".","1","9","5",".",".","."],
                         [".","9","8",".",".",".",".","6","."],
                         ["8",".",".",".","6",".",".",".","3"],
                         ["4",".",".","8",".","3",".",".","1"],
                         ["7",".",".",".","2",".",".",".","6"],
                         [".","6",".",".",".",".","2","8","."],
                         [".",".",".","4","1","9",".",".","5"],
                         [".",".",".",".","8",".",".","7","9"]]
        solveSudoku(&board)
        print(board)
    }
    //    37. 解数独
    //    编写一个程序，通过填充空格来解决数独问题。
    //    数独的解法需 遵循如下规则：
    //    数字 1-9 在每一行只能出现一次。
    //    数字 1-9 在每一列只能出现一次。
    //    数字 1-9 在每一个以粗实线分隔的 3x3 宫内只能出现一次。（请参考示例图）
    //    数独部分空格内已填入了数字，空白格用 '.' 表示。
    //    示例：
//        输入：
//    board = [["5","3",".",".","7",".",".",".","."],
//             ["6",".",".","1","9","5",".",".","."],
//             [".","9","8",".",".",".",".","6","."],
//             ["8",".",".",".","6",".",".",".","3"],
//             ["4",".",".","8",".","3",".",".","1"],
//             ["7",".",".",".","2",".",".",".","6"],
//             [".","6",".",".",".",".","2","8","."],
//             [".",".",".","4","1","9",".",".","5"],
//             [".",".",".",".","8",".",".","7","9"]]
    //    输出：[["5","3","4","6","7","8","9","1","2"],["6","7","2","1","9","5","3","4","8"],["1","9","8","3","4","2","5","6","7"],["8","5","9","7","6","1","4","2","3"],["4","2","6","8","5","3","7","9","1"],["7","1","3","9","2","4","8","5","6"],["9","6","1","5","3","7","2","8","4"],["2","8","7","4","1","9","6","3","5"],["3","4","5","2","8","6","1","7","9"]]
    //    解释：输入的数独如上图所示，唯一有效的解决方案如下所示：
    //    提示：
    //    board.length == 9
    //    board[i].length == 9
    //    board[i][j] 是一位数字或者 '.'
    //    题目数据 保证 输入数独仅有一个解
    //    来源：力扣（LeetCode）
    //    链接：https://leetcode-cn.com/problems/sudoku-solver
    //    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func solveSudoku(_ board: inout [[Character]]) {
        var row: [[Bool]] = Array(repeating: Array(repeating: false, count: 9), count: 9) //row[i] 第i行的数字使用情况
        var col: [[Bool]] = Array(repeating: Array(repeating: false, count: 9), count: 9) //col[i] 第i列的数字使用情况
        var sql: [[Bool]] = Array(repeating: Array(repeating: false, count: 9), count: 9) //sql[i] 第i个方块的数字使用情况
        //构建数据
        var i = 0
        while i < 9 {
            var j = 0
            while j < 9 {
                let ch = board[i][j]
                if ch != "." {
                    setSudoNum(&board, &row, &col, &sql, i, j, ch.wholeNumberValue!)
                }
                j += 1
            }
            i += 1
        }
        //开始放置
        _ = solveSudokuBacktrace(&board, &row, &col, &sql, 0, 0)
    }
    class func solveSudokuBacktrace(_ board: inout [[Character]],_ row: inout [[Bool]],_ col: inout [[Bool]],_ sql: inout [[Bool]],_ i: Int,_ j: Int) -> Bool {
        //找到可以放的位置
        var nextI = i
        var nextJ = j
        var finded = false
        while nextI < 9 {
            while nextJ < 9 {
                if board[nextI][nextJ] == "." {
                    finded = true
                    break
                }
                nextJ += 1
            }
            if finded {
                break
            }
            nextI += 1
            nextJ = 0
        }
        if !finded {
            //放完了，结束了
            return true
        }
        //做选择
        var k = 1
        while k <= 9 {
            if canSetSudoNum(&row, &col, &sql, nextI, nextJ, k) {
                setSudoNum(&board, &row, &col, &sql, nextI, nextJ, k)
                if solveSudokuBacktrace(&board, &row, &col, &sql, nextI, nextJ) {
                    return true
                }
                setSudoNum(&board, &row, &col, &sql, nextI, nextJ, -1)
            }
            k += 1
        }
        return false
    }

    class func canSetSudoNum(_ row: inout [[Bool]],_ col: inout [[Bool]],_ sql: inout [[Bool]],_ i: Int,_ j: Int,_ num: Int) -> Bool  {
        return !row[i][num - 1] && !col[j][num - 1] && !sql[i / 3 * 3 + (j / 3)][num - 1]
    }

    class func setSudoNum(_ board: inout [[Character]],_ row: inout [[Bool]],_ col: inout [[Bool]],_ sql: inout [[Bool]],_ i: Int,_ j: Int,_ num: Int)  {
        if num == -1 {//表示移除
            let orgNum = board[i][j].wholeNumberValue!
            board[i][j] = Character(".")
            row[i][orgNum - 1] = false
            col[j][orgNum - 1] = false
            sql[i / 3 * 3 + (j / 3)][orgNum - 1] = false
        }else {
            board[i][j] = Character("\(num)")
            row[i][num - 1] = true
            col[j][num - 1] = true
            sql[i / 3 * 3 + (j / 3)][num - 1] = true
        }
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
