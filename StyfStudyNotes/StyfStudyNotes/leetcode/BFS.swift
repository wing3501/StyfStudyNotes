//
//  BFS.swift
//  StyfStudyNotes
//
//  Created by styf on 2021/2/9.
//

import Foundation

//// 计算从起点 start 到终点 target 的最近距离
//int BFS(Node start, Node target) {
//    Queue<Node> q; // 核心数据结构
//    Set<Node> visited; // 避免走回头路
//
//    q.offer(start); // 将起点加入队列
//    visited.add(start);
//    int step = 0; // 记录扩散的步数
//
//    while (q not empty) {
//        int sz = q.size();
//        /* 将当前队列中的所有节点向四周扩散 */
//        for (int i = 0; i < sz; i++) {
//            Node cur = q.poll();
//            /* 划重点：这里判断是否到达终点 */
//            if (cur is target)
//                return step;
//            /* 将 cur 的相邻节点加入队列 */
//            for (Node x : cur.adj())
//                if (x not in visited) {
//                    q.offer(x);
//                    visited.add(x);
//                }
//        }
//        /* 划重点：更新步数在这里 */
//        step++;
//    }
//}

@objcMembers class BFS: NSObject {
    class func test()  {
//        111. 二叉树的最小深度
//        let node = TreeTest.deserialize("[3,9,20,null,null,15,7]")
//        print(minDepth(node))
//        let node1 = TreeTest.deserialize("[2,null,3,null,4,null,5,null,6]")
//        print(minDepth(node1))
        
//        752. 打开转盘锁
//        print(openLock(["0201","0101","0102","1212","2002"], "0202"))//6
//        print(openLock(["8888"], "0009"))//1
//        print(openLock(["8887","8889","8878","8898","8788","8988","7888","9888"], "8888"))//-1
//        print(openLock(["0000"], "8888"))//-1
        
        //    773. 滑动谜题
//        print(slidingPuzzle([[1,2,3],[4,0,5]]))//1
//        print(slidingPuzzle([[1,2,3],[5,4,0]]))//-1
//        print(slidingPuzzle([[4,1,2],[5,0,3]]))//5
//        print(slidingPuzzle([[3,2,4],
//                             [1,5,0]]))//14
        
        //    200. 岛屿数量
//        print(numIslands([
//            ["1","1","1","1","0"],
//            ["1","1","0","1","0"],
//            ["1","1","0","0","0"],
//            ["0","0","0","0","0"]
//          ]))//1
//        print(numIslands([
//            ["1","1","0","0","0"],
//            ["1","1","0","0","0"],
//            ["0","0","1","0","0"],
//            ["0","0","0","1","1"]
//          ]))//3
        
        //    1254. 统计封闭岛屿的数目
//        print(closedIsland([[1,1,1,1,1,1,1,0],
//                            [1,0,0,0,0,1,1,0],
//                            [1,0,1,0,1,1,1,0],
//                            [1,0,0,0,0,1,0,1],
//                            [1,1,1,1,1,1,1,0]]))//2
//        print(closedIsland([[0,0,1,0,0],
//                            [0,1,0,1,0],
//                            [0,1,1,1,0]]))//1
        
        //    1020. 飞地的数量
//        print(numEnclaves([[0,0,0,0],
//                           [1,0,1,0],
//                           [0,1,1,0],
//                           [0,0,0,0]]))//3
        
        //    1905. 统计子岛屿
//        print(countSubIslands([[1,1,1,0,0],
//                               [0,1,1,1,1],
//                               [0,0,0,0,0],
//                               [1,0,0,0,0],
//                               [1,1,0,1,1]], [[1,1,1,0,0],
//                                              [0,0,1,1,1],
//                                              [0,1,0,0,0],
//                                              [1,0,1,1,0],
//                                              [0,1,0,1,0]]))//3
        
        
        
    }
    
//    1905. 统计子岛屿
//    给你两个 m x n 的二进制矩阵 grid1 和 grid2 ，它们只包含 0 （表示水域）和 1 （表示陆地）。一个 岛屿 是由 四个方向 （水平或者竖直）上相邻的 1 组成的区域。任何矩阵以外的区域都视为水域。
//    如果 grid2 的一个岛屿，被 grid1 的一个岛屿 完全 包含，也就是说 grid2 中该岛屿的每一个格子都被 grid1 中同一个岛屿完全包含，那么我们称 grid2 中的这个岛屿为 子岛屿 。
//    请你返回 grid2 中 子岛屿 的 数目 。
//    示例 1：
//    输入：
//    grid1 = [[1,1,1,0,0],
//             [0,1,1,1,1],
//             [0,0,0,0,0],
//             [1,0,0,0,0],
//             [1,1,0,1,1]],
//    grid2 = [[1,1,1,0,0],
//             [0,0,1,1,1],
//             [0,1,0,0,0],
//             [1,0,1,1,0],
//             [0,1,0,1,0]]
//    输出：3
//    解释：如上图所示，左边为 grid1 ，右边为 grid2 。
//    grid2 中标红的 1 区域是子岛屿，总共有 3 个子岛屿。
//    示例 2：
//    输入：grid1 = [[1,0,1,0,1],[1,1,1,1,1],[0,0,0,0,0],[1,1,1,1,1],[1,0,1,0,1]], grid2 = [[0,0,0,0,0],[1,1,1,1,1],[0,1,0,1,0],[0,1,0,1,0],[1,0,0,0,1]]
//    输出：2
//    解释：如上图所示，左边为 grid1 ，右边为 grid2 。
//    grid2 中标红的 1 区域是子岛屿，总共有 2 个子岛屿。
//    提示：
//    m == grid1.length == grid2.length
//    n == grid1[i].length == grid2[i].length
//    1 <= m, n <= 500
//    grid1[i][j] 和 grid2[i][j] 都要么是 0 要么是 1 。
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/count-sub-islands
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func countSubIslands(_ grid1: [[Int]], _ grid2: [[Int]]) -> Int {
        var table = grid2
        var count = 0
        let steps = [[0,1],[0,-1],[1,0],[-1,0]]
        var i = 0
        while i < table.count {
            var j = 0
            while j < table[0].count {
                let num = table[i][j]
                if num == 1 {
                    var isSub = true
                    if grid1[i][j] != 1 {
                        isSub = false
                    }
                    table[i][j] = 0
                    var stack = [[i,j]]
                    while !stack.isEmpty {
                        let cur = stack.removeLast()
                        for step in steps {
                            let nextI = cur[0] + step[0]
                            let nextJ = cur[1] + step[1]
                            if nextI >= 0 && nextI < table.count && nextJ >= 0 && nextJ < table[0].count && table[nextI][nextJ] == 1 {
                                stack.append([nextI,nextJ])
                                table[nextI][nextJ] = 0
                                if grid1[nextI][nextJ] != 1 {
                                    isSub = false
                                }
                            }
                        }
                    }
                    if isSub {
                        count += 1
                    }
                }
                j += 1
            }
            i += 1
        }
        return count
    }
//    1020. 飞地的数量
//    给出一个二维数组 A，每个单元格为 0（代表海）或 1（代表陆地）。
//    移动是指在陆地上从一个地方走到另一个地方（朝四个方向之一）或离开网格的边界。
//    返回网格中无法在任意次数的移动中离开网格边界的陆地单元格的数量。
//    示例 1：
//    输入：[[0,0,0,0],
//          [1,0,1,0],
//          [0,1,1,0],
//          [0,0,0,0]]
//    输出：3
//    解释：
//    有三个 1 被 0 包围。一个 1 没有被包围，因为它在边界上。
//    示例 2：
//    输入：[[0,1,1,0],
//          [0,0,1,0],
//          [0,0,1,0],
//          [0,0,0,0]]
//    输出：0
//    解释：
//    所有 1 都在边界上或可以到达边界。
//    提示：
//    1 <= A.length <= 500
//    1 <= A[i].length <= 500
//    0 <= A[i][j] <= 1
//    所有行的大小都相同
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/number-of-enclaves
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func numEnclaves(_ grid: [[Int]]) -> Int {
        guard grid.count > 2 && grid[0].count > 2 else { return 0 }
        var table = grid
        var count = 0
        let steps = [[0,1],[0,-1],[1,0],[-1,0]]
        var i = 1
        while i < table.count - 1 {
            var j = 1
            while j < table[0].count - 1 {
                let num = table[i][j]
                if num == 1 {
                    var isClosed = true
                    var stack = [[i,j]]
                    table[i][j] = 0
                    var tempCount = 1
                    while !stack.isEmpty {
                        let cur = stack.removeLast()
                        for step in steps {
                            let nextI = cur[0] + step[0]
                            let nextJ = cur[1] + step[1]
                            if nextI >= 0 && nextI < table.count && nextJ >= 0 && nextJ < table[0].count && table[nextI][nextJ] == 1 {
                                if nextI == 0 || nextI == table.count - 1 || nextJ == 0 || nextJ == table[0].count - 1 {
                                    //和边界相连
                                    isClosed = false
                                }else {
                                    table[nextI][nextJ] = 0
                                    tempCount += 1
                                    stack.append([nextI,nextJ])
                                }
                            }
                        }
                    }
                    if isClosed {
                        count += tempCount
                    }
                }
                j += 1
            }
            i += 1
        }
        return count
    }
//    1254. 统计封闭岛屿的数目
//    有一个二维矩阵 grid ，每个位置要么是陆地（记号为 0 ）要么是水域（记号为 1 ）。
//    我们从一块陆地出发，每次可以往上下左右 4 个方向相邻区域走，能走到的所有陆地区域，我们将其称为一座「岛屿」。
//    如果一座岛屿 完全 由水域包围，即陆地边缘上下左右所有相邻区域都是水域，那么我们将其称为 「封闭岛屿」。
//    请返回封闭岛屿的数目。
//    示例 1：
//    输入：grid = [[1,1,1,1,1,1,1,0],
//                 [1,0,0,0,0,1,1,0],
//                 [1,0,1,0,1,1,1,0],
//                 [1,0,0,0,0,1,0,1],
//                 [1,1,1,1,1,1,1,0]]
//    输出：2
//    解释：
//    灰色区域的岛屿是封闭岛屿，因为这座岛屿完全被水域包围（即被 1 区域包围）。
//    示例 2：
//    输入：grid = [[0,0,1,0,0],
//                 [0,1,0,1,0],
//                 [0,1,1,1,0]]
//    输出：1
//    示例 3：
//    输入：grid = [[1,1,1,1,1,1,1],
//                 [1,0,0,0,0,0,1],
//                 [1,0,1,1,1,0,1],
//                 [1,0,1,0,1,0,1],
//                 [1,0,1,1,1,0,1],
//                 [1,0,0,0,0,0,1],
//                 [1,1,1,1,1,1,1]]
//    输出：2
//    提示：
//    1 <= grid.length, grid[0].length <= 100
//    0 <= grid[i][j] <=1
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/number-of-closed-islands
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func closedIsland(_ grid: [[Int]]) -> Int {
        guard grid.count > 2 && grid[0].count > 2 else { return 0 }
        var table = grid
        var count = 0
        let steps = [[0,1],[0,-1],[1,0],[-1,0]]
        var i = 1
        while i < table.count - 1 {
            var j = 1
            while j < table[0].count - 1 {
                let num = table[i][j]
                if num == 0 {
                    var isClosed = true
                    var stack = [[i,j]]
                    table[i][j] = 1
                    while !stack.isEmpty {
                        let cur = stack.removeLast()
                        for step in steps {
                            let nextI = cur[0] + step[0]
                            let nextJ = cur[1] + step[1]
                            if nextI >= 0 && nextI < table.count && nextJ >= 0 && nextJ < table[0].count && table[nextI][nextJ] == 0 {
                                if nextI == 0 || nextI == table.count - 1 || nextJ == 0 || nextJ == table[0].count - 1 {
                                    //和边界相连
                                    isClosed = false
                                }else {
                                    table[nextI][nextJ] = 1
                                    stack.append([nextI,nextJ])
                                }
                            }
                        }
                    }
                    if isClosed {
                        count += 1
                    }
                }
                j += 1
            }
            i += 1
        }
        return count
    }
//    200. 岛屿数量
//    给你一个由 '1'（陆地）和 '0'（水）组成的的二维网格，请你计算网格中岛屿的数量。
//    岛屿总是被水包围，并且每座岛屿只能由水平方向和/或竖直方向上相邻的陆地连接形成。
//    此外，你可以假设该网格的四条边均被水包围。
//    示例 1：
//    输入：grid = [
//      ["1","1","1","1","0"],
//      ["1","1","0","1","0"],
//      ["1","1","0","0","0"],
//      ["0","0","0","0","0"]
//    ]
//    输出：1
//    示例 2：
//    输入：grid = [
//      ["1","1","0","0","0"],
//      ["1","1","0","0","0"],
//      ["0","0","1","0","0"],
//      ["0","0","0","1","1"]
//    ]
//    输出：3
//    提示：
//    m == grid.length
//    n == grid[i].length
//    1 <= m, n <= 300
//    grid[i][j] 的值为 '0' 或 '1'
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/number-of-islands
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func numIslands(_ grid: [[Character]]) -> Int {
        // 优化点：可以把岛屿淹了，避免维护visited
        var count = 0
        var visited:Set<[Int]> = []
        let steps = [[0,1],[0,-1],[1,0],[-1,0]]
        var i = 0
        while i < grid.count {
            var j = 0
            while j < grid[0].count {
                let num = grid[i][j]
                if num == "1" && !visited.contains([i,j]) {
                    visited.insert([i,j])
                    var stack = [[i,j]]
                    while !stack.isEmpty {
                        let cur = stack.removeLast()
                        for step in steps {
                            let nextI = cur[0] + step[0]
                            let nextJ = cur[1] + step[1]
                            if nextI >= 0 && nextI < grid.count && nextJ >= 0 && nextJ < grid[0].count && !visited.contains([nextI,nextJ]) && grid[nextI][nextJ] == "1" {
                                stack.append([nextI,nextJ])
                                visited.insert([nextI,nextJ])
                            }
                        }
                    }
                    count += 1
                }
                j += 1
            }
            i += 1
        }
        
        return count
    }
//    773. 滑动谜题
//    在一个 2 x 3 的板上（board）有 5 块砖瓦，用数字 1~5 来表示, 以及一块空缺用 0 来表示.
//    一次移动定义为选择 0 与一个相邻的数字（上下左右）进行交换.
//    最终当板 board 的结果是 [[1,2,3],
//                          [4,5,0]] 谜板被解开。
//    给出一个谜板的初始状态，返回最少可以通过多少次移动解开谜板，如果不能解开谜板，则返回 -1 。
//    示例：
//    输入：board = [[1,2,3],
//                  [4,0,5]]
//    输出：1
//    解释：交换 0 和 5 ，1 步完成
//    输入：board = [[1,2,3],[5,4,0]]
//    输出：-1
//    解释：没有办法完成谜板
//    输入：board = [[4,1,2],
//                  [5,0,3]]
//    输出：5
//    解释：
//    最少完成谜板的最少移动次数是 5 ，
//    一种移动路径:
//    尚未移动: [[4,1,2],[5,0,3]]
//    移动 1 次: [[4,1,2],[0,5,3]]
//    移动 2 次: [[0,1,2],[4,5,3]]
//    移动 3 次: [[1,0,2],[4,5,3]]
//    移动 4 次: [[1,2,0],[4,5,3]]
//    移动 5 次: [[1,2,3],[4,5,0]]
//    输入：board = [[3,2,4],[1,5,0]]
//    输出：14
//    提示：
//    board 是一个如上所述的 2 x 3 的数组.
//    board[i][j] 是一个 [0, 1, 2, 3, 4, 5] 的排列.
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/sliding-puzzle
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func slidingPuzzle(_ board: [[Int]]) -> Int {
        // 核心思路： 搜索可以形成的所有局面
        
        if board == [[1,2,3],[4,5,0]] {
            return 0
        }
        var zeroI = 0
        var zeroJ = 0
        var i = 0
        while i < board.count {
            let arr = board[i]
            var j = 0
            while j < arr.count {
                if arr[j] == 0 {
                    zeroI = i
                    zeroJ = j
                    break
                }
                j += 1
            }
            i += 1
        }
        var path: Set<[[Int]]> = [board] //保存局面
        var queue = [board]
        var zeroQueue = [[zeroI,zeroJ]]
        let walks = [[0,1],[0,-1],[1,0],[-1,0]]
        var step = 0
        while !queue.isEmpty {
            let size = queue.count
            var i = 0
            var tempQueue: [[[Int]]] = []
            var tempZeroQueue: [[Int]] = []
            while i < size {
                let curBoard = queue.removeLast()
                let zero = zeroQueue.removeLast()
                for walk in walks {
                    let nextI = zero[0] + walk[0]
                    let nextJ = zero[1] + walk[1]
                    if nextI >= 0 && nextI < board.count && nextJ >= 0 && nextJ < board[0].count {
                        var tempBoard = curBoard
                        let tempVal = tempBoard[nextI][nextJ]
                        tempBoard[nextI][nextJ] = 0
                        tempBoard[zero[0]][zero[1]] = tempVal
                        if path.contains(tempBoard) {
                            continue
                        }
                        path.insert(tempBoard)
                        if tempBoard == [[1,2,3],[4,5,0]] {
                            //到终点了
                            return step + 1
                        }else {
                            //还要继续走
                            tempQueue.append(tempBoard)
                            tempZeroQueue.append([nextI,nextJ])
                        }
                        
                    }
                }
                i += 1
            }
            queue = tempQueue
            zeroQueue = tempZeroQueue
            step += 1
        }
        return -1
    }
    
    
    
//    752. 打开转盘锁
//    你有一个带有四个圆形拨轮的转盘锁。每个拨轮都有10个数字： '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' 。每个拨轮可以自由旋转：例如把 '9' 变为 '0'，'0' 变为 '9' 。每次旋转都只能旋转一个拨轮的一位数字。
//    锁的初始数字为 '0000' ，一个代表四个拨轮的数字的字符串。
//    列表 deadends 包含了一组死亡数字，一旦拨轮的数字和列表里的任何一个元素相同，这个锁将会被永久锁定，无法再被旋转。
//    字符串 target 代表可以解锁的数字，你需要给出解锁需要的最小旋转次数，如果无论如何不能解锁，返回 -1 。
//    示例 1:
//    输入：deadends = ["0201","0101","0102","1212","2002"], target = "0202"
//    输出：6
//    解释：
//    可能的移动序列为 "0000" -> "1000" -> "1100" -> "1200" -> "1201" -> "1202" -> "0202"。
//    注意 "0000" -> "0001" -> "0002" -> "0102" -> "0202" 这样的序列是不能解锁的，
//    因为当拨动到 "0102" 时这个锁就会被锁定。
//    示例 2:
//    输入: deadends = ["8888"], target = "0009"
//    输出：1
//    解释：
//    把最后一位反向旋转一次即可 "0000" -> "0009"。
//    示例 3:
//    输入: deadends = ["8887","8889","8878","8898","8788","8988","7888","9888"], target = "8888"
//    输出：-1
//    解释：
//    无法旋转到目标数字且不被锁定。
//    示例 4:
//    输入: deadends = ["0000"], target = "8888"
//    输出：-1
    class func openLock(_ deadends: [String], _ target: String) -> Int {
        //可以用双向BFS还提高效率
        
        let deadSet = Set<[Int]>(deadends.map { (str) -> [Int] in
            str.map { (ch) -> Int in
                ch.wholeNumberValue!
            }
        })
        let lock = [0,0,0,0]
        var visitedSet = Set<[Int]>([lock])
        let targetArray = target.map { (ch) -> Int in
            ch.wholeNumberValue!
        }
        var quque = [lock]
        var step = 0;
        while quque.count > 0 {
            var i = 0
            let len = quque.count
            while i < len {
                let cur = quque.remove(at: 0)
                if cur == targetArray {
                    return step
                }
                if !deadSet.contains(cur) {
                    var j = 0
                    while j < lock.count {
                        let newlock1 = walkLock(cur, j, true)
                        let newlock2 = walkLock(cur, j, false)
                        if newlock1 == targetArray || newlock2 == targetArray {
                            return step + 1
                        }
                        if !visitedSet.contains(newlock1) && !deadSet.contains(newlock1) {
                            quque.append(newlock1)
                            visitedSet.insert(newlock1)
                        }
                        if !visitedSet.contains(newlock2) && !deadSet.contains(newlock2) {
                            quque.append(newlock2)
                            visitedSet.insert(newlock2)
                        }
                        j += 1
                    }
                }
                i += 1
            }
            step += 1
        }
        return -1
    }
    
    class func walkLock(_ lock: [Int],_ index: Int,_ up: Bool) -> [Int] {
        let value = lock[index] + (up ? 1 : -1)
        var newLock = lock
        if value > 9 {
            newLock[index] = 0
        }else if value < 0 {
            newLock[index] = 9
        }else {
            newLock[index] = value
        }
        return newLock
    }
    
//    111. 二叉树的最小深度
//    给定一个二叉树，找出其最小深度。
//    最小深度是从根节点到最近叶子节点的最短路径上的节点数量。
//    说明：叶子节点是指没有子节点的节点。
//    示例 1：
//    输入：root = [3,9,20,null,null,15,7]
//    输出：2
//    示例 2：
//    输入：root = [2,null,3,null,4,null,5,null,6]
//    输出：5
    class func minDepth(_ root: TreeNode?) -> Int {
        guard let node = root else { return 0 }
        var quque = [node]
        var deep = 1
        while quque.count > 0 {
            let len = quque.count
            var i = 0
            while i < len {
                let cur = quque.remove(at: 0)
                if cur.left == nil && cur.right == nil {
                    return deep
                }
                if let left = cur.left {
                    quque.append(left)
                }
                if let right = cur.right {
                    quque.append(right)
                }
                i += 1
            }
            deep += 1
        }
        return deep
    }
}
