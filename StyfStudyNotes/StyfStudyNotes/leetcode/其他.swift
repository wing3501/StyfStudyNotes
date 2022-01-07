//
//  其他.swift
//  StyfStudyNotes
//
//  Created by styf on 2021/2/26.
//

import Foundation
// 联查表
class UnionFind {
    var count: Int//联通分量个数
    var parent: [Int] //存储树
    var size: [Int] //树中节点个数
    init(n: Int) {
        count = n
        parent = []
        size = []
        for i in 0..<n {
            parent[i] = i //初始化，每个节点指向自己
            size[i] = 1
        }
    }
    //联通节点 p 和 q
    func union(p: Int,q: Int) {
        let rootP = find(p: p)
        let rootQ = find(p: q)
        if rootP == rootQ {
            return
        }
        if size[rootP] > size[rootQ] {
            parent[rootQ] = rootP
            size[rootP] += size[rootQ]
        }else {
            parent[rootP] = rootQ
            size[rootQ] += size[rootP]
        }
        count -= 1
    }
    //两个节点是否联通
    func connected(p: Int,q: Int) -> Bool {
        let rootP = find(p: p)
        let rootQ = find(p: q)
        return rootP == rootQ
    }
    
    //找到根节点
    func find(p: Int) -> Int {
        var x = p
        while(parent[x] != x) {
            parent[x] = parent[parent[x]]
            x = parent[x]
        }
        return x
    }
}
// 不空首位的二叉堆
class Aheap<E: Comparable> {
    private let bigHeap: Bool
    private var array: [E]
    var count: Int {
        return array.count
    }
    var top: E {
        array[0]
    }
    init(_ bigHeap: Bool) {
        self.bigHeap = bigHeap
        array = []
    }
    func push(_ num: E) {
        array.append(num)
        siftUp(i: array.count - 1)
    }
    func pop() -> E {
        let topNum = top
        array[0] = array[count - 1]
        array.removeLast()
        if count > 0 {
            siftDown(i: 0)
        }
        return topNum
    }
    
    private func left(_ i: Int) -> Int {
        return i * 2 + 1
    }
    
    private func right(_ i: Int) -> Int {
        return left(i) + 1
    }
    
    private func parent(_ i: Int) -> Int {
        return (i - 1) / 2
    }
    
    //对i位置元素下滤
    private func siftDown(i: Int) {
        var index = i
        let element = array[index]
        let half = array.count / 2
        while index < half {
            var childIndex = left(index)
            let rightIndex = right(index)
            
            if bigHeap {
                if rightIndex < array.count && array[rightIndex] > array[childIndex] {
                    childIndex = rightIndex
                }
                
                if array[childIndex] <= element {
                    break
                }
            }else {
                if rightIndex < array.count && array[rightIndex] < array[childIndex] {
                    childIndex = rightIndex
                }
                
                if array[childIndex] >= element {
                    break
                }
            }
            array[index] = array[childIndex]
            index = childIndex
        }
        array[index] = element
    }
    //对i位置元素上滤
    private func siftUp(i: Int) {
        var index = i
        let element = array[index]
        while index > 0 {
            let parentIndex = parent(index)
            let parent = array[parentIndex]
            if bigHeap && parent >= element {
                break
            }else if !bigHeap && parent <= element {
                break
            }
    
            array[index] = parent
            index = parentIndex
        }
        array[index] = element
    }
}
/// 空出首位的二叉堆
class BinaryHeap<E:Comparable> {
    private let bigHeap: Bool
    private var array: [E]
    var top: E {
        return array[1]
    }
    var count: Int {
        array.count - 1
    }
    init(_ bigHeap: Bool) {
        self.bigHeap = bigHeap
        array = []
    }
    // 比较：
    // 大顶堆：i < j
    // 小顶堆：i > j
    private func comp(_ i:Int,_ j:Int) -> Bool {
        return bigHeap ? (array[i] < array[j]) : (array[i] > array[j])
    }
    // 上滤
    private func siftUp(_ k: Int) {
        var i = k
        while i > 1 && comp(parent(i), i) {
            array.swapAt(parent(i), i)
            i = parent(i)
        }
    }
    // 下滤
    private func siftDown(_ k: Int) {
        var i = k
        while left(i) <= count {
            var older = left(i)
            if right(i) <= count && comp(older, right(i)) {
                older = right(i)
            }
            if comp(older, i) {
                break
            }
            array.swapAt(older, i)
            i = older
        }
    }
    func push(_ val: E) {
        if count == 0 {
            array.append(val)//首个占位
        }
        array.append(val)
        siftUp(count)
    }
    
    func delTop() -> E {
        let val = top
        array.swapAt(1, count)
        array.removeLast()
        siftDown(1)
        return val
    }
    
    // 父节点索引
    private func parent(_ root: Int) -> Int {
        return root / 2
    }
    // 左子节点索引
    private func left(_ root: Int) -> Int {
        return root * 2
    }
    // 右子节点索引
    private func right(_ root: Int) -> Int {
        return root * 2 + 1
    }
}
// 单调队列
class MonotonicQueue {
    var linkedList: LinkedList<Int>
    init() {
        linkedList = LinkedList()
    }
    // 在队尾添加
    func push(_ val:Int) {
        while let last = linkedList.last,last < val {
            linkedList.removeLast()
        }
        linkedList.push(val)
    }
    //返回当前队伍中最大值
    func max() -> Int {
        if let top = linkedList.top {
            return top
        }
        return -1
    }
    //如果队头是val就移除
    func pop(_ val: Int) {
        if let top = linkedList.top,top == val {
            linkedList.removeTop()
        }
    }
}
// Dijkstra 框架
class DijkstraDemo {
    class State : Comparable{
        
        static func == (lhs: DijkstraDemo.State, rhs: DijkstraDemo.State) -> Bool {
            return lhs.id == rhs.id && lhs.disFromStart == rhs.disFromStart
        }
        
        static func < (lhs: DijkstraDemo.State, rhs: DijkstraDemo.State) -> Bool {
            return lhs.disFromStart < rhs.disFromStart
        }
        
        var id: Int;
        var disFromStart: Int;
        init(_ id: Int,_ disFromStart: Int) {
            self.id = id;
            self.disFromStart = disFromStart;
        }
    }
    
    var graph: [[Int]] = []
    
    // 输入一个起点和一个图，计算start到其他节点的最短距离
    func dijkstra(start: Int,graph: [[Int]]) -> [Int] {
        self.graph = graph
        // 节点个数
        let V = graph.count
        // distTo[i] 表示start到i的最短路径权重
        var distTo = Array(repeating: Int.max, count: V)
        // base case
        distTo[start] = 0
        //优先级队列 distFromStart 小的排前面
        let queue: Aheap<State> = Aheap(false)
        queue.push(State(start, 0))
        while queue.count != 0 {
            let curState = queue.pop()
            let curNodeID = curState.id
            let curDistFromStart = curState.disFromStart
            
            if curDistFromStart > distTo[curNodeID] {
                //已经有一条更短的路径到达curNode节点的路径了
                continue
            }
            // 将curNode的相邻节点放入队列
            for nextNodeID in adj(s: curNodeID) {
                //看看从curNode到nextNode的距离
                let distToNextNode = distTo[curNodeID] + weight(from: curNodeID, to: nextNodeID)
                if distTo[nextNodeID] > distToNextNode {
                    //更新
                    distTo[nextNodeID] = distToNextNode
                    queue.push(State(nextNodeID,distToNextNode))
                }
            }
        }
        
        return distTo
    }
    // 返回节点from 到节点to的边权重
    func weight(from: Int,to: Int) -> Int {
        return graph[from][to]
    }
    // 返回节点s的相邻节点
    func adj(s: Int) -> [Int] {
        return graph[s]
    }
}
// 拓扑排序：后续遍历的反转结果

@objcMembers class Other : NSObject {
    class func test() {
        
//        146. LRU 缓存机制
//        let lRUCache = LRUCache(2)
//        lRUCache.put(1, 1); // 缓存是 {1=1}
//        lRUCache.put(2, 2); // 缓存是 {1=1, 2=2}
//        print(lRUCache.get(1))   // 返回 1
//        lRUCache.put(3, 3); // 该操作会使得关键字 2 作废，缓存是 {1=1, 3=3}
//        print(lRUCache.get(2))    // 返回 -1 (未找到)
//        lRUCache.put(4, 4); // 该操作会使得关键字 1 作废，缓存是 {4=4, 3=3}
//        print(lRUCache.get(1))    // 返回 -1 (未找到)
//        print(lRUCache.get(3))    // 返回 3
//        print(lRUCache.get(4))    // 返回 4
        
//        let lRUCache = LRUCache(2)
//        print(lRUCache.get(2))//-1
//        lRUCache.put(2, 6) //[2,6]
//        print(lRUCache.get(1))//-1
//        lRUCache.put(1, 5)
//        lRUCache.put(1, 2)//[1,2]
//        print(lRUCache.get(1))//2
//        print(lRUCache.get(2))//6
////        ["LRUCache","get","put","get","put","put","get","get"]
////        [null,-1,null,-1,null,null,2,6]
        
//        testCache(["put","put","put","put","put","get","put","get","get","put","get","put","put","put","get","put","get","get","get","get","put","put","get","get","get","put","put","get","put","get","put","get","get","get","put","put","put","get","put","get","get","put","put","get","put","put","put","put","get","put","put","get","put","put","get","put","put","put","put","put","get","put","put","get","put","get","get","get","put","get","get","put","put","put","put","get","put","put","put","put","get","get","get","put","put","put","get","put","put","put","get","put","put","put","get","get","get","put","put","put","put","get","put","put","put","put","put","put","put"], [[10,13],[3,17],[6,11],[10,5],[9,10],[13],[2,19],[2],[3],[5,25],[8],[9,22],[5,5],[1,30],[11],[9,12],[7],[5],[8],[9],[4,30],[9,3],[9],[10],[10],[6,14],[3,1],[3],[10,11],[8],[2,14],[1],[5],[4],[11,4],[12,24],[5,18],[13],[7,23],[8],[12],[3,27],[2,12],[5],[2,9],[13,4],[8,18],[1,7],[6],[9,29],[8,21],[5],[6,30],[1,12],[10],[4,15],[7,22],[11,26],[8,17],[9,29],[5],[3,4],[11,30],[12],[4,29],[3],[9],[6],[3,4],[1],[10],[3,29],[10,28],[1,20],[11,13],[3],[3,12],[3,8],[10,9],[3,26],[8],[7],[5],[13,17],[2,27],[11,15],[12],[9,19],[2,15],[3,16],[1],[12,17],[9,1],[6,19],[4],[5],[5],[8,1],[11,7],[5,2],[9,28],[1],[2,2],[7,4],[4,22],[7,24],[9,26],[13,28],[11,26]])

        //    460. LFU 缓存
        //    ["LFUCache", "put", "put", "get", "put", "get", "get", "put", "get", "get", "get"]
        //    [[2], [1, 1], [2, 2], [1], [3, 3], [2], [3], [4, 4], [1], [3], [4]]
        //    输出：
        //    [null, null, null, 1, null, -1, 3, null, -1, 3, 4]
//        testLFU(["put", "put", "get", "put", "get", "get", "put", "get", "get", "get"], [ [1, 1], [2, 2], [1], [3, 3], [2], [3], [4, 4], [1], [3], [4]])
        
//        testLFU(["put","get"], [[0,0],[0]])
        
//        494. 目标和
//        print(findTargetSumWays([1, 1, 1, 1, 1], 3))
//        print(findTargetSumWays([0,0,0,0,0,0,0,0,1], 1))//256
        
        
//        797. 所有可能的路径
//        print(allPathsSourceTarget([[1,2],[3],[3],[]]))//[[0,1,3],[0,2,3]]
//        print(allPathsSourceTarget([[4,3,1],[3,2,4],[3],[4],[]]))//[[0,4],[0,3,4],[0,1,3,4],[0,1,2,3,4],[0,1,4]]
//        print(allPathsSourceTarget([[1],[]]))//[[0,1]]
//        print(allPathsSourceTarget([[1,2,3],[2],[3],[]]))//[[0,1,2,3],[0,2,3],[0,3]]
//        print(allPathsSourceTarget([[1,3],[2],[3],[]]))//[[0,1,2,3],[0,3]]
//        print(allPathsSourceTarget([[3,1],[4,6,7,2,5],[4,6,3],[6,4],[7,6,5],[6],[7],[]]))
//        print(allPathsSourceTarget([[5,4,1,2,3],[2,5],[4,5,3],[6,5,4],[5,6],[6],[]]))
        
//        207. 课程表
//        print(canFinish(2, [[1,0]]))//true
//        print(canFinish(2, [[1,0],[0,1]]))//false
//        210. 课程表 II
//        print(findOrder(2, [[1,0]]))//[0,1]
//        print(findOrder(4, [[1,0],[2,0],[3,1],[3,2]]))//[0,2,1,3]
//        print(findOrder(1, []))//[0]
        
//        130. 被围绕的区域
//        var board: [[Character]] = [["X","X","X","X"],["X","O","O","X"],["X","X","O","X"],["X","O","X","X"]]
//        var board: [[Character]] = [["X","O","X","O","X","O"],
//                                    ["O","X","O","X","O","X"],
//                                    ["X","O","X","O","X","O"],
//                                    ["O","X","O","X","O","X"]]
//        solve(&board)
//        print(board)
        
//        895. 最大频率栈
//        let s = FreqStack()
//        s.push(5)
//        s.push(7)
//        s.push(5)
//        s.push(7)
//        s.push(4)
//        s.push(5)
//        print(s.pop())
//        print(s.pop())
//        print(s.pop())
//        print(s.pop())
        
////        295. 数据流的中位数
//        let s = MedianFinder()
////        s.addNum(1)
////        s.addNum(2)
////        print(s.findMedian())
////        s.addNum(3)
////        print(s.findMedian())
//
//        s.addNum(1)
//        s.addNum(2)
//        s.addNum(3)
//        print(s.findMedian())
//        s.addNum(4)
//        print(s.findMedian())

//        496. 下一个更大元素 I
//        print(nextGreaterElement([4,1,2], [1,3,4,2]))//[-1,3,-1]
//        503. 下一个更大元素 II
//        print(nextGreaterElements([1,2,1]))//[2,-1,2]
        
//        239. 滑动窗口最大值
//        print(maxSlidingWindow([1,3,-1,-3,5,3,6,7], 3))
        
//        743. 网络延迟时间
//        print(networkDelayTime([[2,1,1],[2,3,1],[3,4,1]], 4, 2))//2
//        print(networkDelayTime([[1,2,1]], 2, 1))//1
//        print(networkDelayTime([[1,2,1]], 2, 2))//-1
        
//        1631. 最小体力消耗路径
//        print(minimumEffortPath([[1,2,2],[3,8,2],[5,3,5]]))//2
//        print(minimumEffortPath([[1,2,3],[3,8,4],[5,3,5]]))//1
//        print(minimumEffortPath([[1,2,1,1,1],[1,2,1,2,1],[1,2,1,2,1],[1,2,1,2,1],[1,1,1,2,1]]))//0
        
//        1514. 概率最大的路径
//        print(maxProbability(3, [[0,1],[1,2],[0,2]], [0.5,0.5,0.2], 0, 2))//0.25
//        print(maxProbability(3, [[0,1],[1,2],[0,2]], [0.5,0.5,0.3], 0, 2))//0.3
//        print(maxProbability(3, [[0,1]], [0.5], 0, 2))//0.0
        
//        710. 黑名单中的随机数
//        let a = Solution123(2, [0])
//        a.pick()
//        a.pick()
//        a.pick()
//        a.pick()
//        a.pick()
//        a.pick()
//        a.pick()
//        a.pick()
//        a.pick()
//        a.pick()
//        a.pick()
        
//        316. 去除重复字母
//        print(removeDuplicateLetters("bcabc"))//"abc"
//        print(removeDuplicateLetters("cbacdcbc"))//"acdb"
//        print(removeDuplicateLetters("abacb"))//"abc"
     
        //    215. 数组中的第K个最大元素
//        print(findKthLargest([3,2,1,5,6,4], 2))//5
//        print(findKthLargest([3,2,3,1,2,4,5,5,6], 4))//4
//        print(findKthLargest([-1,-1], 2))//-1
        
//        241. 为运算表达式设计优先级
//        print(diffWaysToCompute("2-1-1"))
//        print(diffWaysToCompute("2*3-4*5"))
        
        //    659. 分割数组为连续子序列
//        print(isPossible([1,2,3,3,4,5]))//True
//        print(isPossible([1,2,3,3,4,4,5,5]))//True
//        print(isPossible([1,2,3,4,4,5]))//False
//        print(isPossible([1,2,3,5,5,6,7]))//False
        
        //    42. 接雨水
//        print(trap([0,1,0,2,1,0,1,3,2,1,2,1]))//6
//        print(trap([4,2,0,3,2,5]))//9
        
//        921. 使括号有效的最少添加
//        print(minAddToMakeValid("())"))//1
//        print(minAddToMakeValid("((("))//3
//        print(minAddToMakeValid("()"))//0
//        print(minAddToMakeValid("()))(("))//4
        
        //    1541. 平衡括号字符串的最少插入次数
//        print(minInsertions("(()))"))//1
//        print(minInsertions("())"))//0
//        print(minInsertions("))())("))//3
//        print(minInsertions("(((((("))//12
//        print(minInsertions(")))))))"))//5
//        print(minInsertions("(()))(()))()())))"))//4
//        print(minInsertions("))(()()))()))))))()())()(())()))))()())(()())))()("))//16

        //    391. 完美矩形
//        print(isRectangleCover([[1,1,3,3],[3,1,4,2],[3,2,4,4],[1,3,2,4],[2,3,3,4]]))//true
//        print(isRectangleCover([[1,1,2,3],[1,3,2,4],[3,1,4,2],[3,2,4,4]]))
//        print(isRectangleCover([[1,1,3,3],[3,1,4,2],[1,3,2,4],[3,2,4,4]]))
//        print(isRectangleCover([[1,1,3,3],[3,1,4,2],[1,3,2,4],[2,2,4,4]]))
//        print(isRectangleCover([[0,0,4,1],[7,0,8,2],[6,2,8,3],[5,1,6,3],[4,0,5,1],[6,0,7,2],[4,2,5,3],[2,1,4,3],[0,1,2,2],[0,2,2,3],[4,1,5,2],[5,0,6,1]]))//true
//        print(isRectangleCover([[0,0,3,3],[1,1,2,2],[1,1,2,2]]))//重复区域问题
//        print(isRectangleCover([[0,0,1,1],[0,2,1,3],[1,1,2,2],[2,0,3,1],[2,2,3,3],[1,0,2,3],[0,1,3,2]]))
//        print(isRectangleCover([[0,0,2,1],[0,1,2,2],[0,2,1,3],[1,0,2,1]]))
//        3
//        2 x x
//        1 x   x
//        x 1 2 3
        
        //    面试题 08.10. 颜色填充
//        print(floodFill([[1,1,1],[1,1,0],[1,0,1]], 1, 1, 2))
    }

//    面试题 08.10. 颜色填充
//    编写函数，实现许多图片编辑软件都支持的「颜色填充」功能。
//    待填充的图像用二维数组 image 表示，元素为初始颜色值。初始坐标点的行坐标为 sr 列坐标为 sc。需要填充的新颜色为 newColor 。
//    「周围区域」是指颜色相同且在上、下、左、右四个方向上存在相连情况的若干元素。
//    请用新颜色填充初始坐标点的周围区域，并返回填充后的图像。
//    示例：
//    输入：
//    image = [[1,1,1],
//             [1,1,0],
//             [1,0,1]]
//    sr = 1, sc = 1, newColor = 2
//    输出：[[2,2,2],
//          [2,2,0],
//          [2,0,1]]
//    解释:
//    初始坐标点位于图像的正中间，坐标 (sr,sc)=(1,1) 。
//    初始坐标点周围区域上所有符合条件的像素点的颜色都被更改成 2 。
//    注意，右下角的像素没有更改为 2 ，因为它不属于初始坐标点的周围区域。
//    提示：
//    image 和 image[0] 的长度均在范围 [1, 50] 内。
//    初始坐标点 (sr,sc) 满足 0 <= sr < image.length 和 0 <= sc < image[0].length 。
//    image[i][j] 和 newColor 表示的颜色值在范围 [0, 65535] 内。
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/color-fill-lcci
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func floodFill(_ image: [[Int]], _ sr: Int, _ sc: Int, _ newColor: Int) -> [[Int]] {
        var visited: Set<[Int]> = [[sr,sc]]
        var table = image
        var stack: [[Int]] = [[sr,sc]]
        let orgColor = image[sr][sc]
        let steps = [[0,1],[0,-1],[1,0],[-1,0]]
        while !stack.isEmpty {
            let obj = stack.removeLast()
            let x = obj[0]
            let y = obj[1]
            table[x][y] = newColor
            for step in steps {
                let nextX = x + step[0]
                let nextY = y + step[1]
                if nextX >= 0 && nextX < table.count && nextY >= 0 && nextY < table[0].count && !visited.contains([nextX,nextY]) && table[nextX][nextY] == orgColor {
                    visited.insert([nextX,nextY])
                    stack.append([nextX,nextY])
                }
            }
        }
        return table
    }
    
    /**
     * Your ExamRoom object will be instantiated and called as such:
     * let obj = ExamRoom(n)
     * let ret_1: Int = obj.seat()
     * obj.leave(p)
     */
    
//    391. 完美矩形
//    给你一个数组 rectangles ，其中 rectangles[i] = [xi, yi, ai, bi] 表示一个坐标轴平行的矩形。这个矩形的左下顶点是 (xi, yi) ，右上顶点是 (ai, bi) 。
//    如果所有矩形一起精确覆盖了某个矩形区域，则返回 true ；否则，返回 false 。
//    示例 1：
//    输入：rectangles = [[1,1,3,3],[3,1,4,2],[3,2,4,4],[1,3,2,4],[2,3,3,4]]
//    输出：true
//    解释：5 个矩形一起可以精确地覆盖一个矩形区域。
//    示例 2：
//    输入：rectangles = [[1,1,2,3],[1,3,2,4],[3,1,4,2],[3,2,4,4]]
//    输出：false
//    解释：两个矩形之间有间隔，无法覆盖成一个矩形。
//    示例 3：
//    输入：rectangles = [[1,1,3,3],[3,1,4,2],[1,3,2,4],[3,2,4,4]]
//    输出：false
//    解释：图形顶端留有空缺，无法覆盖成一个矩形。
//    示例 4：
//    输入：rectangles = [[1,1,3,3],[3,1,4,2],[1,3,2,4],[2,2,4,4]]
//    输出：false
//    解释：因为中间有相交区域，虽然形成了矩形，但不是精确覆盖。
//    提示：
//    1 <= rectangles.length <= 2 * 104
//    rectangles[i].length == 4
//    -105 <= xi, yi, ai, bi <= 105
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/perfect-rectangle
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func isRectangleCover(_ rectangles: [[Int]]) -> Bool {
        // 核心思路
        // 判定条件：
        // 1.面积相等
        // 2.只有4个角
        // 3.角坐标位置能对应上
        
        
        // 思路1的基础上，加上面积判断
        var pointsDic: [[Int]:Int] = [:]// 坐标对应 -- 坐标个数
        var leftBottom: [Int]?
        var rightTop: [Int]?
        var set: Set<[Int]> = [] //处理漏洞
        var mianjiSum = 0
        for item in rectangles {
            let x1 = item[0]
            let y1 = item[1]
            let x2 = item[2]
            let y2 = item[3]
            pointsDic[[x1,y1],default: 0] += 1
            pointsDic[[x2,y2],default: 0] += 1
            pointsDic[[x2,y1],default: 0] += 1
            pointsDic[[x1,y2],default: 0] += 1

            if set.contains(item) {
                return false
            }else {
                set.insert(item)
            }
            mianjiSum += (x2 - x1) * (y2 - y1)

            if leftBottom == nil || (leftBottom != nil && leftBottom![0] >= x1 && leftBottom![1] >= y1) {
                leftBottom = [x1, y1]
            }
            if rightTop == nil || (rightTop != nil && rightTop![0] <= x2 && rightTop![1] <= y2) {
                rightTop = [x2, y2]
            }
        }
        
        let totleMianji = (rightTop![0] - leftBottom![0]) * (rightTop![1] - leftBottom![1])
        if totleMianji != mianjiSum {
            return false
        }
        
        let leftTop = [leftBottom![0],rightTop![1]]
        let rightBottom = [rightTop![0],leftBottom![1]]
        
        for (key,value) in pointsDic {
            if key == leftTop || key == rightBottom || key == leftBottom! || key == rightTop! {
                guard value == 1 else {
                    return false }
            }else {
                guard value >= 2 else {
                    return false}
            }
        }
        return true
        
        //我的思路2 表格法  超时
//        var minX = rectangles[0][0]
//        var minY = rectangles[0][1]
//        var maxX = rectangles[0][2]
//        var maxY = rectangles[0][3]
//
//        var set: Set<[Int]> = [] //处理漏洞
//        for item in rectangles {
//            let x1 = item[0]
//            let y1 = item[1]
//            let x2 = item[2]
//            let y2 = item[3]
//
//            if set.contains(item) {
//                return false
//            }else {
//                set.insert(item)
//            }
//
//            minX = min(minX, x1)
//            minY = min(minY, y1)
//            maxX = max(maxX, x2)
//            maxY = max(maxY, y2)
//        }
//        let leftBottom: [Int] = [minX,minY]
//        let rightTop: [Int] = [maxX,maxY]
//
//        //建表
//        let w = rightTop[0] - leftBottom[0]
//        let h = rightTop[1] - leftBottom[1]
//        var table: [[Bool]] = Array(repeating: Array(repeating: false, count: h), count: w)
//        var count = 0;
//        let x = leftBottom[0]
//        let y = leftBottom[1]
//        for item in rectangles {
//            let x1 = item[0] - x
//            let y1 = item[1] - y
//            let x2 = item[2] - x
//            let y2 = item[3] - y
//
//            var xx = x1
//            while xx < x2 {
//                var yy = y1
//                while yy < y2 {
//                    if table[xx][yy] == true {
//                        return false
//                    }else {
//                        table[xx][yy] = true
//                        count += 1
//                    }
//                    yy += 1
//                }
//                xx += 1
//            }
//        }
//
//        return count == (w * h)
        
        
        //我的思路1，除了四个角的点，其他点都应该存在多份   覆盖问题没有解决
//        var pointsDic: [[Int]:Int] = [:]// 坐标对应 -- 坐标个数
//        var leftBottom: [Int]?
//        var rightTop: [Int]?
//        var set: Set<[Int]> = [] //处理漏洞
//        for item in rectangles {
//            let x1 = item[0]
//            let y1 = item[1]
//            let x2 = item[2]
//            let y2 = item[3]
//            pointsDic[[x1,y1],default: 0] += 1
//            pointsDic[[x2,y2],default: 0] += 1
//            pointsDic[[x2,y1],default: 0] += 1
//            pointsDic[[x1,y2],default: 0] += 1
//
//            if set.contains(item) {
//                return false
//            }else {
//                set.insert(item)
//            }
//
//            if leftBottom == nil || (leftBottom != nil && leftBottom![0] >= x1 && leftBottom![1] >= y1) {
//                leftBottom = [x1, y1]
//            }
//            if rightTop == nil || (rightTop != nil && rightTop![0] <= x2 && rightTop![1] <= y2) {
//                rightTop = [x2, y2]
//            }
//        }
//        let leftTop = [leftBottom![0],rightTop![1]]
//        let rightBottom = [rightTop![0],leftBottom![1]]
//        for (key,value) in pointsDic {
//            if key == leftTop || key == rightBottom || key == leftBottom! || key == rightTop! {
//                guard value == 1 else {
//                    return false }
//            }else {
//                guard value >= 2 else {
//                    return false}
//            }
//        }
//        return true
    }
    
//    1541. 平衡括号字符串的最少插入次数
//    给你一个括号字符串 s ，它只包含字符 '(' 和 ')' 。一个括号字符串被称为平衡的当它满足：
//    任何左括号 '(' 必须对应两个连续的右括号 '))' 。
//    左括号 '(' 必须在对应的连续两个右括号 '))' 之前。
//    比方说 "())"， "())(())))" 和 "(())())))" 都是平衡的， ")()"， "()))" 和 "(()))" 都是不平衡的。
//    你可以在任意位置插入字符 '(' 和 ')' 使字符串平衡。
//    请你返回让 s 平衡的最少插入次数。
//    示例 1：
//    输入：s = "(()))"
//    输出：1
//    解释：第二个左括号有与之匹配的两个右括号，但是第一个左括号只有一个右括号。我们需要在字符串结尾额外增加一个 ')' 使字符串变成平衡字符串 "(())))" 。
//    示例 2：
//    输入：s = "())"
//    输出：0
//    解释：字符串已经平衡了。
//    示例 3：
//    输入：s = "))())("
//    输出：3
//    解释：添加 '(' 去匹配最开头的 '))' ，然后添加 '))' 去匹配最后一个 '(' 。
//    示例 4：
//    输入：s = "(((((("
//    输出：12
//    解释：添加 12 个 ')' 得到平衡字符串。
//    示例 5：
//    输入：s = ")))))))"
//    输出：5
//    解释：在字符串开头添加 4 个 '(' 并在结尾添加 1 个 ')' ，字符串变成平衡字符串 "(((())))))))" 。
//    提示：
//    1 <= s.length <= 10^5
//    s 只包含 '(' 和 ')' 。
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/minimum-insertions-to-balance-a-parentheses-string
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func minInsertions(_ s: String) -> Int {
        //其他思路 通过一个need来记录对)的需求数
        var res = 0
        var need = 0
        let array = Array(s)
        var i = 0
        while i < array.count {
            if array[i] == "(" {
                need += 2
                if need % 2 == 1 {
                    //前面还少一个)
                    res += 1
                    need -= 1
                }
            }else {
                need -= 1
                if need == -1 {
                    //)太多了
                    res += 1
                    need = 1
                }
            }
            i += 1
        }
        
        return res + need
        
        
//        let array = Array(s)
//        var stack: [Character] = []
//        var count = 0
//
//        for item in array {
//            if item == "(" {
//                if stack.count > 0 && stack.last! == ")" {//
//                    if stack.count > 1 {//()(
//                        //说明欠一个)
//                        count += 1
//                        stack.removeLast()
//                        stack.removeLast()
//                    }else {// )(
//                        count += 2
//                        stack.removeLast()
//                    }
//                }
//                stack.append(item)
//            }else {
//                if stack.count > 0 {
//                    if stack.last! == ")" {
//                        if stack.count > 1 {//())
//                            //凑齐
//                            stack.removeLast()
//                            stack.removeLast()
//                        }else {// ))
//                            //前面只有一个),加上当前，需要补一个(
//                            stack.removeLast()
//                            count += 1
//                        }
//                    }else {
//                        stack.append(item)//()
//                    }
//                }else {
//                    stack.append(item)//)
//                }
//            }
//        }
//        if stack.count > 0 {
//            // (((((
//            // )
//            // ()
//            if stack.last! == ")" {
//                if stack.count > 1 {// ((()
//                    count += 1
//                    stack.removeLast()
//                    stack.removeLast()
//                    //剩余都是(
//                    count += stack.count * 2
//                }else {// )
//                    count += 2
//                }
//            }else {
//                //剩余都是(
//                count += stack.count * 2
//            }
//        }
//        return count
    }
//    921. 使括号有效的最少添加
//    给定一个由 '(' 和 ')' 括号组成的字符串 S，我们需要添加最少的括号（ '(' 或是 ')'，可以在任何位置），以使得到的括号字符串有效。
//    从形式上讲，只有满足下面几点之一，括号字符串才是有效的：
//    它是一个空字符串，或者
//    它可以被写成 AB （A 与 B 连接）, 其中 A 和 B 都是有效字符串，或者
//    它可以被写作 (A)，其中 A 是有效字符串。
//    给定一个括号字符串，返回为使结果字符串有效而必须添加的最少括号数。
//    示例 1：
//    输入："())"
//    输出：1
//    示例 2：
//    输入："((("
//    输出：3
//    示例 3：
//    输入："()"
//    输出：0
//    示例 4：
//    输入："()))(("
//    输出：4
//    提示：
//    S.length <= 1000
//    S 只包含 '(' 和 ')' 字符。
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/minimum-add-to-make-parentheses-valid
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func minAddToMakeValid(_ s: String) -> Int {
        let array = Array(s)
        var stack: [Character] = []
        var count = 0
        for item in array {
            if item == "(" {
                stack.append(item)
            }else {
                if stack.count > 0 {
                    stack.removeLast()
                }else {
                    count += 1
                }
            }
        }
        count += stack.count
        return count
    }
//    42. 接雨水
//    给定 n 个非负整数表示每个宽度为 1 的柱子的高度图，计算按此排列的柱子，下雨之后能接多少雨水。
//    输入：height = [0,1,0,2,1,0,1,3,2,1,2,1]
//    输出：6
//    解释：上面是由数组 [0,1,0,2,1,0,1,3,2,1,2,1] 表示的高度图，在这种情况下，可以接 6 个单位的雨水（蓝色部分表示雨水）。
//    示例 2：
//    输入：height = [4,2,0,3,2,5]
//    输出：9
//    提示：
//    n == height.length
//    1 <= n <= 2 * 104
//    0 <= height[i] <= 105
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/trapping-rain-water
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func trap(_ height: [Int]) -> Int {
        // 优化：双指针法
        // 可以看到 下标i位置的水只和 min(左边最高柱，右边最高柱) 两者中最低的有关。 当 左边最高柱<右边的高柱  右边的高柱是不是最高的不重要
        
        // 核心思想： 下标i位置的水 = min(左边最高柱，右边最高柱) - height[i]
        // water[i] = min(max(0...i-1),max(i+1...end)) - height[i]
        // max[0...i] = max(max[0...i-1],height[i])
        // max[i...end] = max(max[i+1...end],height[i])
        
        guard height.count > 2 else { return 0 }
        var rightArray = Array(repeating: 0, count: height.count)
        var i = height.count - 2
        while i >= 0 {
            rightArray[i] = max(rightArray[i + 1], height[i + 1])
            i -= 1
        }
        var left = 1
        var sum = 0
        var leftMax = height[0]
        while left < height.count - 1 {
            let water = min(leftMax, rightArray[left]) - height[left]
            sum += max(water, 0)
            leftMax = max(leftMax, height[left])
            left += 1
        }
        return sum
    }
    
//    659. 分割数组为连续子序列
//    给你一个按升序排序的整数数组 num（可能包含重复数字），请你将它们分割成一个或多个长度至少为 3 的子序列，其中每个子序列都由连续整数组成。
//    如果可以完成上述分割，则返回 true ；否则，返回 false 。
//    示例 1：
//    输入: [1,2,3,3,4,5]
//    输出: True
//    解释:
//    你可以分割出这样两个连续子序列 :
//    1, 2, 3
//    3, 4, 5
//    示例 2：
//    输入: [1,2,3,3,4,4,5,5]
//    输出: True
//    解释:
//    你可以分割出这样两个连续子序列 :
//    1, 2, 3, 4, 5
//    3, 4, 5
//    示例 3：
//    输入: [1,2,3,4,4,5]
//    输出: False
//    提示：
//    1 <= nums.length <= 10000
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/split-array-into-consecutive-subsequences
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func isPossible(_ nums: [Int]) -> Bool {
        //其他解法
        // 两个hashmap, 一个存数字出现的次数 num->count  一个存需要的个数 num->count
        //
        
        //试一下牌堆法
        var heaps: [[Int]] = []
        for item in nums {
            var heap: [Int]?
            var i = heaps.count - 1
            while i >= 0 {
                let tempHeap = heaps[i]
                if item - tempHeap.last! == 1 {
                    heap = tempHeap
                    break
                }
                i -= 1
            }
            if heap != nil {
                heap!.append(item)
                heaps[i] = heap!
            }else {
                heaps.append([item])
            }
        }
        
        var i = heaps.count - 1
        while i >= 0 {
            if heaps[i].count < 3 {
                return false
            }
            i -= 1
        }
        
        return true
    }
    
//    241. 为运算表达式设计优先级
//    给定一个含有数字和运算符的字符串，为表达式添加括号，改变其运算优先级以求出不同的结果。你需要给出所有可能的组合的结果。有效的运算符号包含 +, - 以及 * 。
//    示例 1:
//    输入: "2-1-1"
//    输出: [0, 2]
//    解释:
//    ((2-1)-1) = 0
//    (2-(1-1)) = 2
//    示例 2:
//    输入: "2*3-4*5"
//    输出: [-34, -14, -10, -10, 10]
//    解释:
//    (2*(3-(4*5))) = -34  x
//    ((2*3)-(4*5)) = -14
//    ((2*(3-4))*5) = -10  x
//    (2*((3-4)*5)) = -10  x
//    (((2*3)-4)*5) = 10   x
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/different-ways-to-add-parentheses
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func diffWaysToCompute(_ expression: String) -> [Int] {
        var numArray: [Int] = []
        var fuArray: [Character] = []
        let array = Array(expression)
        var i = 0
        while i < array.count {
            let ch = array[i]
            if ch == "+" || ch == "-" || ch == "*" {
                fuArray.append(ch)
                i += 1
            }else {
                var string = String(ch)
                i += 1
                while i < array.count {
                    let nextCh = array[i]
                    if nextCh != "+" && nextCh != "-" && nextCh != "*" {
                        string.append(nextCh)
                        i += 1
                    }else {
                        break
                    }
                }
                numArray.append(Int(string)!)
            }
        }
        
        return diffWaysToComputeHelper(numArray, fuArray, 0, numArray.count - 1)
    }
    
    class func diffWaysToComputeHelper(_ numArray: [Int],_ fuArray: [Character],_ start: Int,_ end: Int) -> [Int] {
        
        //可以加个备忘录，再优化一下
        if start == end {
            return [numArray[start]]
        }
        var i = start
        var resArray: [Int] = []
        while i < end {
            let leftResArr = diffWaysToComputeHelper(numArray, fuArray, start, i)
            let rightResArr = diffWaysToComputeHelper(numArray, fuArray, i + 1, end)
            let fu = fuArray[i]
            for item in leftResArr {
                for item1 in rightResArr {
                    if fu == "+" {
                        resArray.append(item + item1)
                    }else if fu == "-" {
                        resArray.append(item - item1)
                    }else {
                        resArray.append(item * item1)
                    }
                }
            }
            i += 1
        }
        return resArray
    }
    
//    215. 数组中的第K个最大元素
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
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/kth-largest-element-in-an-array
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var targetIndex = nums.count - k
        var arr = nums
        var result: Int?
        findKthLargestQuick(&arr, &targetIndex, 0, nums.count - 1, &result)
        return result!
    }
    
    class func findKthLargestQuick(_ array: inout [Int],_ targetIndex: inout Int,_ start: Int,_ end: Int,_ result: inout Int?) {
        if end - start < 1 {
            if start == targetIndex {
                result = array[start]
            }
            return 
        }
        let ramdonIndex = Int.random(in: start...end)
        array.swapAt(start, ramdonIndex)
        let mid = array[start]
        var left = start
        var right = end
        while left < right {
            while left < right {
                if array[right] > mid {
                    right -= 1
                }else {
                    array[left] = array[right]
                    left += 1
                    break
                }
            }
            
            while left < right {
                if array[left] <= mid {
                    left += 1
                }else {
                    array[right] = array[left]
                    right -= 1
                    break
                }
            }
        }
        array[left] = mid
        
        if left == targetIndex {
            result = array[left]
        }else if left > targetIndex {//start...targetIndex...left...
            findKthLargestQuick(&array, &targetIndex, start, left - 1, &result)
        }else {//start...left...targetIndex
            findKthLargestQuick(&array, &targetIndex, left + 1, end, &result)
        }
    }
    
    
//    1081. 不同字符的最小子序列
//    返回 s 字典序最小的子序列，该子序列包含 s 的所有不同字符，且只包含一次。
//    注意：该题与 316 https://leetcode.com/problems/remove-duplicate-letters/ 相同
//    示例 1：
//    输入：s = "bcabc"
//    输出："abc"
//    示例 2：
//    输入：s = "cbacdcbc"
//    输出："acdb"
//    提示：
//    1 <= s.length <= 1000
//    s 由小写英文字母组成
    class func smallestSubsequence(_ s: String) -> String {
        return ""
    }
    
//    316. 去除重复字母
//    给你一个字符串 s ，请你去除字符串中重复的字母，使得每个字母只出现一次。需保证 返回结果的字典序最小（要求不能打乱其他字符的相对位置）。
//    注意：该题与 1081 https://leetcode-cn.com/problems/smallest-subsequence-of-distinct-characters 相同
//    示例 1：
//    输入：s = "bcabc"
//    输出："abc"
//    示例 2：
//    输入：s = "cbacdcbc"
//    输出："acdb"
//    提示：
//    1 <= s.length <= 104
//    s 由小写英文字母组成
//    链接：https://leetcode-cn.com/problems/remove-duplicate-letters
    class func removeDuplicateLetters(_ s: String) -> String {
        let array = Array(s)
        var stack: [Character] = [] //单调栈
        var inStack = Array(repeating: false, count: 256);
        var chCountArray = Array(repeating: 0, count: 256);
        for ch in array {
            chCountArray[Int(ch.asciiValue!)] += 1
        }
        for ch in array {
            let chIndex = Int(ch.asciiValue!)
            chCountArray[chIndex] -= 1
            if inStack[chIndex] {
                continue//栈里已经有了
            }
            
            while !stack.isEmpty, let last = stack.last,last > ch {//比当前的大的，pop掉
                let lastIndex = Int(last.asciiValue!)
                if chCountArray[lastIndex] == 0 {//后续没有了，就不pop
                    break;
                }
                let removeCh = stack.removeLast()
                inStack[Int(removeCh.asciiValue!)] = false
            }
            stack.append(ch)
            inStack[chIndex] = true
        }
        
        return String(stack)
    }
    
//    710. 黑名单中的随机数
//    给定一个包含 [0，n) 中不重复整数的黑名单 blacklist ，写一个函数从 [0, n) 中返回一个不在 blacklist 中的随机整数。
//    对它进行优化使其尽量少调用系统方法 Math.random() 。
//    提示:
//    1 <= n <= 1000000000
//    0 <= blacklist.length < min(100000, N)
//    [0, n) 不包含 n ，详细参见 interval notation 。
//    示例 1：
//    输入：
//    ["Solution","pick","pick","pick"]
//    [[1,[]],[],[],[]]
//    输出：[null,0,0,0]
//    示例 2：
//    输入：
//    ["Solution","pick","pick","pick"]
//    [[2,[]],[],[],[]]
//    输出：[null,1,1,1]
//    示例 3：
//    输入：
//    ["Solution","pick","pick","pick"]
//    [[3,[1]],[],[],[]]
//    输出：[null,0,0,2]
//    示例 4：
//    输入：
//    ["Solution","pick","pick","pick"]
//    [[4,[2]],[],[],[]]
//    输出：[null,1,3,1]
//    输入语法说明：
//    输入是两个列表：调用成员函数名和调用的参数。Solution的构造函数有两个参数，n 和黑名单 blacklist。pick 没有参数，输入参数是一个列表，即使参数为空，也会输入一个 [] 空列表。
//     链接：https://leetcode-cn.com/problems/random-pick-with-blacklist
    class Solution123 {
        //我的思路：每次pick的时候，如果随机数是一个黑名单数，就对 [0,n)区间进行拆分
        //另一个思路：在初始化的时候，建立黑名单的映射，映射到正常的数。两个问题：1.映射过去的还是黑名单数 2.超过(N - blacklist.count)的黑名单数不用管
        var qujians: [[Int]]
        var blackSet: Set<Int>
        init(_ n: Int, _ blacklist: [Int]) {
            qujians = [[0,n]]
            blackSet = Set(blacklist)
        }
        
        func pick() -> Int {
            var quijanIndex = 0
            var qujian = qujians[quijanIndex]
            if qujians.count > 1 { //先随机出一个区间
                quijanIndex = Int.random(in: 0..<qujians.count)
                qujian = qujians[quijanIndex]
            }
            let left = qujian[0]
            let right = qujian[1]
            let randomNum = Int.random(in: left..<right)
            if blackSet.contains(randomNum) {//是个黑名单数，需要再拆分
                if quijanIndex != qujians.count - 1 {
                    //不是最后一个就交换到最后一个
                    qujians.swapAt(quijanIndex, qujians.count - 1)
                }
                qujians.removeLast()
                if left != randomNum {
                    qujians.append([left,randomNum])
                }
                if randomNum + 1 != right {
                    qujians.append([randomNum + 1,right])
                }
                blackSet.remove(randomNum)
                return pick()
            }else {
               return randomNum
            }
        }
    }
    
//    380. O(1) 时间插入、删除和获取随机元素
//    实现RandomizedSet 类：
//    RandomizedSet() 初始化 RandomizedSet 对象
//    bool insert(int val) 当元素 val 不存在时，向集合中插入该项，并返回 true ；否则，返回 false 。
//    bool remove(int val) 当元素 val 存在时，从集合中移除该项，并返回 true ；否则，返回 false 。
//    int getRandom() 随机返回现有集合中的一项（测试用例保证调用此方法时集合中至少存在一个元素）。每个元素应该有 相同的概率 被返回。
//    你必须实现类的所有函数，并满足每个函数的 平均 时间复杂度为 O(1) 。
//    示例：
//    输入
//    ["RandomizedSet", "insert", "remove", "insert", "getRandom", "remove", "insert", "getRandom"]
//    [[], [1], [2], [2], [], [1], [2], []]
//    输出
//    [null, true, false, true, 2, true, false, 2]
//    解释
//    RandomizedSet randomizedSet = new RandomizedSet();
//    randomizedSet.insert(1); // 向集合中插入 1 。返回 true 表示 1 被成功地插入。
//    randomizedSet.remove(2); // 返回 false ，表示集合中不存在 2 。
//    randomizedSet.insert(2); // 向集合中插入 2 。返回 true 。集合现在包含 [1,2] 。
//    randomizedSet.getRandom(); // getRandom 应随机返回 1 或 2 。
//    randomizedSet.remove(1); // 从集合中移除 1 ，返回 true 。集合现在包含 [2] 。
//    randomizedSet.insert(2); // 2 已在集合中，所以返回 false 。
//    randomizedSet.getRandom(); // 由于 2 是集合中唯一的数字，getRandom 总是返回 2 。
//    提示：
//    -231 <= val <= 231 - 1
//    最多调用 insert、remove 和 getRandom 函数 2 * 105 次
//    在调用 getRandom 方法时，数据结构中 至少存在一个 元素。
//    链接：https://leetcode-cn.com/problems/insert-delete-getrandom-o1
    class RandomizedSet {
        private var valToIndex: [Int: Int] //存下标
        private var array: [Int]
        init() {
            valToIndex = [:]
            array = []
        }
        
        func insert(_ val: Int) -> Bool {
            if let _ = valToIndex[val] {
                return false
            }
            array.append(val)
            valToIndex[val] = array.count - 1
            return true
        }
        
        func remove(_ val: Int) -> Bool {
            guard let index = valToIndex[val] else { return false }
            //核心：交换到数组最后再删
            valToIndex.removeValue(forKey: val)
            if index != array.count - 1 {
                let lastVal = array[array.count - 1]
                valToIndex[lastVal] = index
                array.swapAt(index, array.count - 1)
            }
            array.removeLast()
            return true
        }
        
        func getRandom() -> Int {
            let index = Int.random(in: 0..<array.count)
            return array[index]
        }
    }
    
//    1514. 概率最大的路径
//    给你一个由 n 个节点（下标从 0 开始）组成的无向加权图，该图由一个描述边的列表组成，其中 edges[i] = [a, b] 表示连接节点 a 和 b 的一条无向边，且该边遍历成功的概率为 succProb[i] 。
//    指定两个节点分别作为起点 start 和终点 end ，请你找出从起点到终点成功概率最大的路径，并返回其成功概率。
//    如果不存在从 start 到 end 的路径，请 返回 0 。只要答案与标准答案的误差不超过 1e-5 ，就会被视作正确答案。
//    示例 1：
//    输入：n = 3, edges = [[0,1],[1,2],[0,2]], succProb = [0.5,0.5,0.2], start = 0, end = 2
//    输出：0.25000
//    解释：从起点到终点有两条路径，其中一条的成功概率为 0.2 ，而另一条为 0.5 * 0.5 = 0.25
//    示例 2：
//    输入：n = 3, edges = [[0,1],[1,2],[0,2]], succProb = [0.5,0.5,0.3], start = 0, end = 2
//    输出：0.30000
//    示例 3：
//    输入：n = 3, edges = [[0,1]], succProb = [0.5], start = 0, end = 2
//    输出：0.00000
//    解释：节点 0 和 节点 2 之间不存在路径
//    提示：
//    2 <= n <= 10^4
//    0 <= start, end < n
//    start != end
//    0 <= a, b < n
//    a != b
//    0 <= succProb.length == edges.length <= 2*10^4
//    0 <= succProb[i] <= 1
//    每两个节点之间最多有一条边
//    链接：https://leetcode-cn.com/problems/path-with-maximum-probability
    class ProbabilityNode : Comparable{
        static func < (lhs: Other.ProbabilityNode, rhs: Other.ProbabilityNode) -> Bool {
            return lhs.val < rhs.val
        }
        
        static func == (lhs: Other.ProbabilityNode, rhs: Other.ProbabilityNode) -> Bool {
            return lhs.index == rhs.index
        }
        
        var index: Int
        var val: Double
        init(index:Int,val: Double) {
            self.index = index
            self.val = val
        }
        
    }
    class func maxProbability(_ n: Int, _ edges: [[Int]], _ succProb: [Double], _ start: Int, _ end: Int) -> Double {
        var graph: [Int:[(Int,Double)]] = [:]
        var i = 0
        while i < edges.count {
            let edge = edges[i]
            let p1 = edge[0]
            let p2 = edge[1]
            let val = succProb[i]
            var array1 = graph[p1, default: []]
            array1.append((p2, val))
            graph[p1] = array1;
            var array2 = graph[p2, default: []]
            array2.append((p1,val))
            graph[p2] = array2;
            i += 1
        }
        var toVals = Array(repeating: 0.0, count: n)
        toVals[start] = 1
        let queue = LinkedList<ProbabilityNode>()
        queue.push(ProbabilityNode(index: start, val: 1))
        while queue.count != 0 {
            let node = queue.removeTop()!
            if toVals[node.index] > node.val {
                continue
            }

            if let nexts = graph[node.index] {
                for nextItem in nexts {
                    let nextIndex = nextItem.0
                    let nodeToNextVal = nextItem.1
                    let startToNextVal = toVals[node.index] * nodeToNextVal;
                    if startToNextVal > toVals[nextIndex] {
                        toVals[nextIndex] = startToNextVal
                        queue.push(ProbabilityNode(index: nextIndex, val: startToNextVal))
                    }
                }
            }
        }
        return toVals[end]
    }
    
//    1631. 最小体力消耗路径
//    你准备参加一场远足活动。给你一个二维 rows x columns 的地图 heights ，其中 heights[row][col] 表示格子 (row, col) 的高度。一开始你在最左上角的格子 (0, 0) ，且你希望去最右下角的格子 (rows-1, columns-1) （注意下标从 0 开始编号）。你每次可以往 上，下，左，右 四个方向之一移动，你想要找到耗费 体力 最小的一条路径。
//
//    一条路径耗费的 体力值 是路径上相邻格子之间 高度差绝对值 的 最大值 决定的。
//
//    请你返回从左上角走到右下角的最小 体力消耗值 。
//    示例 1：
//    输入：heights = [[1,2,2],[3,8,2],[5,3,5]]
//    输出：2
//    解释：路径 [1,3,5,3,5] 连续格子的差值绝对值最大为 2 。
//    这条路径比路径 [1,2,2,2,5] 更优，因为另一条路径差值最大值为 3 。
//    示例 2：
//    输入：heights = [[1,2,3],[3,8,4],[5,3,5]]
//    输出：1
//    解释：路径 [1,2,3,4,5] 的相邻格子差值绝对值最大为 1 ，比路径 [1,3,5,3,5] 更优。
//    示例 3：
//    输入：heights = [[1,2,1,1,1],[1,2,1,2,1],[1,2,1,2,1],[1,2,1,2,1],[1,1,1,2,1]]
//    输出：0
//    解释：上图所示路径不需要消耗任何体力。
//    提示：
//    rows == heights.length
//    columns == heights[i].length
//    1 <= rows, columns <= 100
//    1 <= heights[i][j] <= 106
//    链接：https://leetcode-cn.com/problems/path-with-minimum-effort
    class PathClass : Comparable {
        static func < (lhs: Other.PathClass, rhs: Other.PathClass) -> Bool {
            return lhs.disFromStart < rhs.disFromStart
        }
        
        static func == (lhs: Other.PathClass, rhs: Other.PathClass) -> Bool {
            return lhs.x == rhs.x && lhs.y == rhs.y && lhs.disFromStart == rhs.disFromStart
        }
        
        var x: Int
        var y: Int
        var disFromStart: Int
        init(_ i :Int,_ j :Int,_ disFromStart: Int) {
            self.x = i
            y = j
            self.disFromStart = disFromStart
        }
    }
    class func minimumEffortPath(_ heights: [[Int]]) -> Int {
        let w = heights.count
        let h = heights[0].count
        var dist = Array(repeating: Array(repeating: -1, count: h), count: w)
        dist[0][0] = 0
        let queue = LinkedList<PathClass>()
        let move = [[0,-1],[0,1],[-1,0],[1,0]]
        queue.push(PathClass(0,0, dist[0][0]))
        while queue.count != 0 {
            let path = queue.removeTop()!
            let x = path.x
            let y = path.y
            let dis = path.disFromStart
            
            if dist[x][y] != -1 && dist[x][y] < dis {
                continue
            }
            for item in move {
                let nextX = x + item[0]
                let nextY = y + item[1]
                if nextX >= 0 && nextX < w && nextY >= 0 && nextY < h {
                    var  nextDis = abs((heights[x][y] - heights[nextX][nextY]))
                    nextDis = max(nextDis, dist[x][y])
                    if dist[nextX][nextY] == -1 || dist[nextX][nextY] > nextDis  {
                        dist[nextX][nextY] = nextDis
                        queue.push(PathClass(nextX, nextY, nextDis))
                    }
                }
            }
        }
        return dist[w - 1][h - 1]
    }
    
//    743. 网络延迟时间
//    有 n 个网络节点，标记为 1 到 n。
//    给你一个列表 times，表示信号经过 有向 边的传递时间。 times[i] = (ui, vi, wi)，其中 ui 是源节点，vi 是目标节点， wi 是一个信号从源节点传递到目标节点的时间。
//    现在，从某个节点 K 发出一个信号。需要多久才能使所有节点都收到信号？如果不能使所有节点收到信号，返回 -1
//    示例 1：
//    输入：times = [[2,1,1],[2,3,1],[3,4,1]], n = 4, k = 2
//    输出：2
//    示例 2：
//    输入：times = [[1,2,1]], n = 2, k = 1
//    输出：1
//    示例 3：
//    输入：times = [[1,2,1]], n = 2, k = 2
//    输出：-1
//    提示：
//    1 <= k <= n <= 100
//    1 <= times.length <= 6000
//    times[i].length == 3
//    1 <= ui, vi <= n
//    ui != vi
//    0 <= wi <= 100
//    所有 (ui, vi) 对都 互不相同（即，不含重复边）
//    链接：https://leetcode-cn.com/problems/network-delay-time
    class TimeState : Comparable{
        
        static func == (lhs: TimeState, rhs: TimeState) -> Bool {
            return lhs.id == rhs.id && lhs.disFromStart == rhs.disFromStart
        }
        
        static func < (lhs: TimeState, rhs: TimeState) -> Bool {
            return lhs.disFromStart < rhs.disFromStart
        }
        
        var id: Int;
        var disFromStart: Int;
        init(_ id: Int,_ disFromStart: Int) {
            self.id = id;
            self.disFromStart = disFromStart;
        }
    }
    
    class func networkDelayTime(_ times: [[Int]], _ n: Int, _ k: Int) -> Int {
        var distFromStart = Array(repeating: -1, count: n + 1)
        distFromStart[k] = 0
        var canGoDic:[Int : [[Int]]] = [:]
        for item in times {
            let from = item[0]
            let to = item[1]
            let time = item[2]
            if var array = canGoDic[from] {
                array.append([to,time])
                canGoDic[from] = array
            }else {
                canGoDic[from] = [[to,time]]
            }
        }
        
        let quque: LinkedList<TimeState> = LinkedList()
        quque.push(TimeState(k, 0))
        while quque.count != 0 {
            let item = quque.removeTop()!
            let index = item.id
            let time = item.disFromStart
            
            let dist = distFromStart[index]
            if dist != -1 && dist < time {
                continue
            }
            distFromStart[index] = time
            if let array = canGoDic[index] {
                for item in array {
                    let to = item[0]
                    let time1 = item[1]
                    let distToNext = distFromStart[index] + time1
                    let toTime = distFromStart[to]
                    if toTime > distToNext || toTime == -1 {
                        quque.push(TimeState(to,distToNext))
                    }
                }
            }
        }
        var maxTime = -1
        var i = 1
        while i <= n {
            let time = distFromStart[i]
            if time == -1 {
                return -1
            }
            maxTime = max(maxTime, time)
            i += 1
        }
        return maxTime
    }
    
//    239. 滑动窗口最大值
//    给你一个整数数组 nums，有一个大小为 k 的滑动窗口从数组的最左侧移动到数组的最右侧。你只可以看到在滑动窗口内的 k 个数字。滑动窗口每次只向右移动一位。
//    返回滑动窗口中的最大值。
//    示例 1：
//    输入：nums = [1,3,-1,-3,5,3,6,7], k = 3
//    输出：[3,3,5,5,6,7]
//    解释：
//    滑动窗口的位置                最大值
//    ---------------               -----
//    [1  3  -1] -3  5  3  6  7       3
//     1 [3  -1  -3] 5  3  6  7       3
//     1  3 [-1  -3  5] 3  6  7       5
//     1  3  -1 [-3  5  3] 6  7       5
//     1  3  -1  -3 [5  3  6] 7       6
//     1  3  -1  -3  5 [3  6  7]      7
//    示例 2：
//    输入：nums = [1], k = 1
//    输出：[1]
//    示例 3：
//    输入：nums = [1,-1], k = 1
//    输出：[1,-1]
//    示例 4：
//    输入：nums = [9,11], k = 2
//    输出：[11]
//    示例 5：
//    输入：nums = [4,-2], k = 2
//    输出：[4]
//    提示：
//    1 <= nums.length <= 105
//    -104 <= nums[i] <= 104
//    1 <= k <= nums.length
//    链接：https://leetcode-cn.com/problems/sliding-window-maximum
    class func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        let monotonicQueue = MonotonicQueue()
        var result: [Int] = []
        var i = 0
        while i < nums.count {
            let num = nums[i]
            if i < k - 1 {
                monotonicQueue.push(num)
            }else {
                monotonicQueue.push(num)
                result.append(monotonicQueue.max())
                monotonicQueue.pop(nums[i - (k - 1)])
            }
            i += 1
        }
        return result
    }
    
//    503. 下一个更大元素 II
//    给定一个循环数组（最后一个元素的下一个元素是数组的第一个元素），输出每个元素的下一个更大元素。数字 x 的下一个更大的元素是按数组遍历顺序，这个数字之后的第一个比它更大的数，这意味着你应该循环地搜索它的下一个更大的数。如果不存在，则输出 -1。
//    示例 1:
//    输入: [1,2,1]
//    输出: [2,-1,2]
//    解释: 第一个 1 的下一个更大的数是 2；
//    数字 2 找不到下一个更大的数；
//    第二个 1 的下一个最大的数需要循环搜索，结果也是 2。
//    注意: 输入数组的长度不会超过 10000。
//    链接：https://leetcode-cn.com/problems/next-greater-element-ii
    class func nextGreaterElements(_ nums: [Int]) -> [Int] {
//        1,2,1 1,2,1
        var i = nums.count - 1
        var stack: [Int] = []
        while i >= 0 {
            stack.append(nums[i])
            i -= 1
        }
        i = nums.count - 1
        var res = Array(repeating: -1, count: nums.count)
        while i >= 0 {
            let item = nums[i]
            while !stack.isEmpty && item >= stack.last! {
                stack.removeLast()
            }
            res[i] = stack.isEmpty ? -1 : stack.last!
            stack.append(item)
            i -= 1
        }
        return res
    }
//    496. 下一个更大元素 I
//    给你两个 没有重复元素 的数组 nums1 和 nums2 ，其中nums1 是 nums2 的子集。
//    请你找出 nums1 中每个元素在 nums2 中的下一个比其大的值。
//    nums1 中数字 x 的下一个更大元素是指 x 在 nums2 中对应位置的右边的第一个比 x 大的元素。如果不存在，对应位置输出 -1 。
//    示例 1:
//    输入: nums1 = [4,1,2], nums2 = [1,3,4,2].
//    输出: [-1,3,-1]
//    解释:
//        对于 num1 中的数字 4 ，你无法在第二个数组中找到下一个更大的数字，因此输出 -1 。
//        对于 num1 中的数字 1 ，第二个数组中数字1右边的下一个较大数字是 3 。
//        对于 num1 中的数字 2 ，第二个数组中没有下一个更大的数字，因此输出 -1 。
//    示例 2:
//    输入: nums1 = [2,4], nums2 = [1,2,3,4].
//    输出: [3,-1]
//    解释:
//        对于 num1 中的数字 2 ，第二个数组中的下一个较大数字是 3 。
//        对于 num1 中的数字 4 ，第二个数组中没有下一个更大的数字，因此输出 -1 。
//    提示：
//    1 <= nums1.length <= nums2.length <= 1000
//    0 <= nums1[i], nums2[i] <= 104
//    nums1和nums2中所有整数 互不相同
//    nums1 中的所有整数同样出现在 nums2 中
//    进阶：你可以设计一个时间复杂度为 O(nums1.length + nums2.length) 的解决方案吗？
//    链接：https://leetcode-cn.com/problems/next-greater-element-i
    class func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var stack: [Int] = []
        var dic: [Int : Int] = [:]
        var i = nums2.count - 1
        while i >= 0 {
            let item = nums2[i]
            while !stack.isEmpty && stack.last! <= item {
                stack.removeLast()
            }
            dic[item] = stack.isEmpty ? -1 : stack.last!
            stack.append(item)
            i -= 1
        }
        let result: [Int] = nums1.map {
            dic[$0]!
        }
        return result
    }
    
//    295. 数据流的中位数
//    中位数是有序列表中间的数。如果列表长度是偶数，中位数则是中间两个数的平均值。
//    例如，
//    [2,3,4] 的中位数是 3
//    [2,3] 的中位数是 (2 + 3) / 2 = 2.5
//    设计一个支持以下两种操作的数据结构：
//    void addNum(int num) - 从数据流中添加一个整数到数据结构中。
//    double findMedian() - 返回目前所有元素的中位数。
//    示例：
//    addNum(1)
//    addNum(2)
//    findMedian() -> 1.5
//    addNum(3)
//    findMedian() -> 2
//    进阶:
//    如果数据流中所有整数都在 0 到 100 范围内，你将如何优化你的算法？
//    如果数据流中 99% 的整数都在 0 到 100 范围内，你将如何优化你的算法？
//    https://leetcode-cn.com/problems/find-median-from-data-stream/
    class MedianFinder {
        var leftHeap: Aheap<Int> //大顶堆
        var rightHeap: Aheap<Int> //小顶堆

        init() {
            leftHeap = Aheap(true)
            rightHeap = Aheap(false)
        }
        
        func addNum(_ num: Int) {
            if leftHeap.count == 0 {
                leftHeap.push(num)
            }else if rightHeap.count == 0 {
                let leftMax = leftHeap.top
                if leftMax <= num {
                    rightHeap.push(num)
                }else {
                    rightHeap.push(leftHeap.pop())
                    leftHeap.push(num)
                }
            }else {
                let leftMax = leftHeap.top
                let rightMin = rightHeap.top
                if leftHeap.count <= rightHeap.count {
                    //左边
                    if num > rightMin {
                        leftHeap.push(rightHeap.pop())
                        rightHeap.push(num)
                    }else {
                        leftHeap.push(num)
                    }
                }else {
                    if num < leftMax {
                        rightHeap.push(leftHeap.pop())
                        leftHeap.push(num)
                    }else {
                        rightHeap.push(num)
                    }
                }
            }
        }
        
        func findMedian() -> Double {
            if leftHeap.count == 0 && rightHeap.count == 0 {
                return 0
            }
            if leftHeap.count == rightHeap.count {
                return Double((leftHeap.top + rightHeap.top)) * 0.5
            }else {
                if leftHeap.count > rightHeap.count {
                    return Double(leftHeap.top)
                }
                return Double(rightHeap.top)
            }
        }
    }
    
//    895. 最大频率栈
//    实现 FreqStack，模拟类似栈的数据结构的操作的一个类。
//
//    FreqStack 有两个函数：
//
//    push(int x)，将整数 x 推入栈中。
//    pop()，它移除并返回栈中出现最频繁的元素。
//    如果最频繁的元素不只一个，则移除并返回最接近栈顶的元素。
//    示例：
//
//    输入：
//    ["FreqStack","push","push","push","push","push","push","pop","pop","pop","pop"],
//    [[],[5],[7],[5],[7],[4],[5],[],[],[],[]]
//    输出：[null,null,null,null,null,null,null,5,7,5,4]
//    解释：
//    执行六次 .push 操作后，栈自底向上为 [5,7,5,7,4,5]。然后：
//    pop() -> 返回 5，因为 5 是出现频率最高的。
//    栈变成 [5,7,5,7,4]。
//    pop() -> 返回 7，因为 5 和 7 都是频率最高的，但 7 最接近栈顶。
//    栈变成 [5,7,5,4]。
//    pop() -> 返回 5 。
//    栈变成 [5,7,4]。
//    pop() -> 返回 4 。
//    栈变成 [5,7]。
//    提示：
//
//    对 FreqStack.push(int x) 的调用中 0 <= x <= 10^9。
//    如果栈的元素数目为零，则保证不会调用  FreqStack.pop()。
//    单个测试样例中，对 FreqStack.push 的总调用次数不会超过 10000。
//    单个测试样例中，对 FreqStack.pop 的总调用次数不会超过 10000。
//    所有测试样例中，对 FreqStack.push 和 FreqStack.pop 的总调用次数不会超过 150000。
//    链接：https://leetcode-cn.com/problems/maximum-frequency-stack
    class FreqStack {
        // 最大频次 maxFreg
        var maxFreg = 0;
        // val->频次
        var valToFreg: [Int: Int] = [:]
        // 频次->stack
        var fregToVal: [Int: [Int]] = [:]
        
        init() {

        }
        
        func push(_ val: Int) {
            var freg = valToFreg[val, default: 0]
            freg += 1
            valToFreg[val] = freg
            if freg > maxFreg {
                maxFreg = freg
            }
            var stack = fregToVal[freg, default: []]
            stack.append(val)
            fregToVal[freg] = stack
        }
        
        func pop() -> Int {
            var stack = fregToVal[maxFreg]!
            let val = stack.removeLast()
            fregToVal[maxFreg] = stack
            let freg = valToFreg[val]!
            valToFreg[val] = freg - 1
            if stack.count == 0 {
                maxFreg -= 1
            }
            return val
        }
    }
    
//    130. 被围绕的区域
//    给你一个 m x n 的矩阵 board ，由若干字符 'X' 和 'O' ，找到所有被 'X' 围绕的区域，并将这些区域里所有的 'O' 用 'X' 填充。
//    示例 1：
//    输入：board = [["X","X","X","X"],["X","O","O","X"],["X","X","O","X"],["X","O","X","X"]]
//    输出：[["X","X","X","X"],["X","X","X","X"],["X","X","X","X"],["X","O","X","X"]]
//    解释：被围绕的区间不会存在于边界上，换句话说，任何边界上的 'O' 都不会被填充为 'X'。 任何不在边界上，或不与边界上的 'O' 相连的 'O' 最终都会被填充为 'X'。如果两个元素在水平或垂直方向相邻，则称它们是“相连”的。
//    示例 2：
//    输入：board = [["X"]]
//    输出：[["X"]]
//    提示：
//    m == board.length
//    n == board[i].length
//    1 <= m, n <= 200
//    board[i][j] 为 'X' 或 'O'
//    链接：https://leetcode-cn.com/problems/surrounded-regions
    class func solve(_ board: inout [[Character]]) {
        //连接表
        
        
        
        return
        //一般做法
        guard board.count > 2 else {
            return
        }
        guard board[0].count > 2 else {
            return
        }
        var needDealArray: [(Int,Int)] = []
        var i = 0
        while i < board[0].count {
            //上下两行
            if board[0][i] == "O" {
                solveDFS(&board, &needDealArray, (0,i))
            }
            
            if board[board.count - 1][i] == "O" {
                solveDFS(&board, &needDealArray, (board.count - 1,i))
            }
            i += 1
        }
        i = 0
        while i < board.count {
            if board[i][0] == "O" {
                solveDFS(&board, &needDealArray, (i,0))
            }
            
            if board[i][board[0].count - 1] == "O" {
                solveDFS(&board, &needDealArray, (i,board[0].count - 1))
            }
            i += 1
        }
        
        var y = 1
        while y < board.count {
            var x = 1
            while x < board[0].count {
                if board[y][x] == "O" {
                    board[y][x] = "X"
                }
                x += 1
            }
            y += 1
        }
        
        for item in needDealArray {
            board[item.0][item.1] = "O"
        }
    }
    
    class func solveDFS(_ board: inout [[Character]],_ needDealArray: inout [(Int,Int)] ,_ location: (Int,Int)) {
        var stack: [(Int,Int)] = [location]
        var visited: Set<[Int]> = Set(arrayLiteral: [location.0,location.1])
        let goArray = [[0,-1],[0,1],[-1,0],[1,0]]
        while stack.count > 0 {
            let item = stack.removeLast()
            board[item.0][item.1] = "#"
            needDealArray.append(item)
            
            for go in goArray {
                let x = item.0 + go[0]
                let y = item.1 + go[1]
                if x >= 0 && x < board.count && y >= 0 && y < board[0].count{
                    let ch = board[x][y]
                    if !visited.contains([x,y]) && ch == "O" {
                        stack.append((x,y))
                        visited.insert([x,y])
                    }
                }
            }
        }
    }
    
//    210. 课程表 II
//    现在你总共有 numCourses 门课需要选，记为 0 到 numCourses - 1。给你一个数组 prerequisites ，其中 prerequisites[i] = [ai, bi] ，表示在选修课程 ai 前 必须 先选修 bi 。
//    例如，想要学习课程 0 ，你需要先完成课程 1 ，我们用一个匹配来表示：[0,1] 。
//    返回你为了学完所有课程所安排的学习顺序。可能会有多个正确的顺序，你只要返回 任意一种 就可以了。如果不可能完成所有课程，返回 一个空数组 。
//    示例 1：
//    输入：numCourses = 2, prerequisites = [[1,0]]
//    输出：[0,1]
//    解释：总共有 2 门课程。要学习课程 1，你需要先完成课程 0。因此，正确的课程顺序为 [0,1] 。
//    示例 2
//    输入：numCourses = 4, prerequisites = [[1,0],[2,0],[3,1],[3,2]]
//    输出：[0,2,1,3]
//    解释：总共有 4 门课程。要学习课程 3，你应该先完成课程 1 和课程 2。并且课程 1 和课程 2 都应该排在课程 0 之后。
//    因此，一个正确的课程顺序是 [0,1,2,3] 。另一个正确的排序是 [0,2,1,3] 。
//    示例 3：
//    输入：numCourses = 1, prerequisites = []
//    输出：[0]
//    提示：
//    1 <= numCourses <= 2000
//    0 <= prerequisites.length <= numCourses * (numCourses - 1)
//    prerequisites[i].length == 2
//    0 <= ai, bi < numCourses
//    ai != bi
//    所有[ai, bi] 匹配 互不相同
//    拓展：
//
//    这个问题相当于查找一个循环是否存在于有向图中。如果存在循环，则不存在拓扑排序，因此不可能选取所有课程进行学习。
//    通过 DFS 进行拓扑排序 - 一个关于Coursera的精彩视频教程（21分钟），介绍拓扑排序的基本概念。
//    拓扑排序也可以通过 BFS 完成。
//    链接：https://leetcode-cn.com/problems/course-schedule-ii
    class func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        var graph: [[Int]] = Array(repeating: [], count: numCourses)
        for array in prerequisites {
            let from = array[1]
            let to = array[0]
            graph[from].append(to)
        }
        
        var visited: [Bool] = Array(repeating: false, count: numCourses)
        var path: [Bool] = Array(repeating: false, count: numCourses)
        var order: [Int] = []
        var hasCircle = false
        var s = 0
        while s < graph.count {
            bianli1(graph, s: s, visited: &visited, path: &path, hasCircle: &hasCircle,order: &order)
            s += 1
        }
        if !hasCircle {
            return order.reversed()
        }
        return []
    }
    
    class func bianli1(_ graph: [[Int]],s : Int ,visited: inout [Bool], path: inout [Bool], hasCircle: inout Bool, order: inout [Int]) {
        if path[s] {
            hasCircle = true
        }
        if hasCircle || visited[s] {
            return
        }
        path[s] = true
        visited[s] = true
        
        let arr = graph[s]
        for item in arr {
            bianli1(graph, s: item, visited: &visited, path: &path, hasCircle: &hasCircle,order: &order)
        }
        order.append(s)
        path[s] = false
    }
    
    
    
//    207. 课程表
//    你这个学期必须选修 numCourses 门课程，记为 0 到 numCourses - 1 。
//    在选修某些课程之前需要一些先修课程。 先修课程按数组 prerequisites 给出，其中 prerequisites[i] = [ai, bi] ，表示如果要学习课程 ai 则 必须 先学习课程  bi 。
//    例如，先修课程对 [0, 1] 表示：想要学习课程 0 ，你需要先完成课程 1 。
//    请你判断是否可能完成所有课程的学习？如果可以，返回 true ；否则，返回 false 。
//    示例 1：
//    输入：numCourses = 2, prerequisites = [[1,0]]
//    输出：true
//    解释：总共有 2 门课程。学习课程 1 之前，你需要完成课程 0 。这是可能的。
//    示例 2：
//    输入：numCourses = 2, prerequisites = [[1,0],[0,1]]
//    输出：false
//    解释：总共有 2 门课程。学习课程 1 之前，你需要先完成​课程 0 ；并且学习课程 0 之前，你还应先完成课程 1 。这是不可能的。
//    提示：
//    1 <= numCourses <= 105
//    0 <= prerequisites.length <= 5000
//    prerequisites[i].length == 2
//    0 <= ai, bi < numCourses
//    prerequisites[i] 中的所有课程对 互不相同
//    https://leetcode-cn.com/problems/course-schedule/
    class func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        var graph: [[Int]] = Array(repeating: [], count: numCourses)
        var visited: [Bool] = Array(repeating: false, count: numCourses)
        var path: [Bool] = Array(repeating: false, count: numCourses)
        for array in prerequisites {
            let from = array[1]
            let to = array[0]
            graph[from].append(to)
        }
        
        //遍历
        var hasCircle = false
        var s = 0
        while s < graph.count {
            bianli(graph, s: s, visited: &visited, path: &path, hasCircle: &hasCircle)
            s += 1
        }
        if hasCircle {
            return false
        }else {
            for item in visited {
                if !item {
                    return false
                }
            }
            return true
        }
    }
    
    class func bianli(_ graph: [[Int]],s : Int ,visited: inout [Bool], path: inout [Bool], hasCircle: inout Bool) {
        if path[s] {
            hasCircle = true
        }
        if hasCircle || visited[s] {
            return
        }
        path[s] = true
        visited[s] = true
        let arr = graph[s]
        for item in arr {
            bianli(graph, s: item, visited: &visited, path: &path, hasCircle: &hasCircle)
        }
        path[s] = false
    }
    
    
//    797. 所有可能的路径
//    给你一个有 n 个节点的 有向无环图（DAG），请你找出所有从节点 0 到节点 n-1 的路径并输出（不要求按特定顺序）
//    二维数组的第 i 个数组中的单元都表示有向图中 i 号节点所能到达的下一些节点，空就是没有下一个结点了。
//    译者注：有向图是有方向的，即规定了 a→b 你就不能从 b→a 。
//    示例 1：
//    输入：graph = [[1,2],[3],[3],[]]
//    输出：[[0,1,3],[0,2,3]]
//    解释：有两条路径 0 -> 1 -> 3 和 0 -> 2 -> 3
//    示例 2：
//    输入：graph = [[4,3,1],[3,2,4],[3],[4],[]]
//    输出：[[0,4],[0,3,4],[0,1,3,4],[0,1,2,3,4],[0,1,4]]
//    示例 3：
//    输入：graph = [[1],[]]
//    输出：[[0,1]]
//    示例 4：
//    输入：graph = [[1,2,3],[2],[3],[]]
//    输出：[[0,1,2,3],[0,2,3],[0,3]]
//    示例 5：
//    输入：graph = [[1,3],[2],[3],[]]
//    输出：[[0,1,2,3],[0,3]]
//    提示：
//    n == graph.length
//    2 <= n <= 15
//    0 <= graph[i][j] < n
//    graph[i][j] != i（即，不存在自环）
//    graph[i] 中的所有元素 互不相同
//    保证输入为 有向无环图（DAG）
//    链接：https://leetcode-cn.com/problems/all-paths-from-source-to-target
    class func allPathsSourceTarget(_ graph: [[Int]]) -> [[Int]] {
        if graph.count <= 1 {
            return graph
        }
        var result: [[Int]] = []
        var dic: [Int:[[Int]]] = [:]
        let firstArr = graph[0]
        var stack: [Int] = []
        allPathsSourceTargetHelper(&stack, graph, firstArr, &result, &dic)
        return result
    }
    
    class func allPathsSourceTargetHelper(_ stack: inout [Int],_ graph: [[Int]],_ array: [Int],_ result: inout [[Int]],_ dic: inout [Int:[[Int]]]) {
        for item in array {
            if item == graph.count - 1 {
                stack.append(item)
                var res = [0]
                res.append(contentsOf: stack)
                result.append(res)
                if dic[stack[0]] == nil {
                    dic[stack[0]] = []
                }
                dic[stack[0]]!.append(stack)
                stack.removeLast()
            }else {
                if let cacheArray = dic[item] {
                    for arr in cacheArray {
                        var temp = stack
                        temp.append(contentsOf: arr)
                        
                        var res = [0]
                        res.append(contentsOf: temp)
                        result.append(res)
                        if dic[stack[0]] == nil {
                            dic[stack[0]] = []
                        }
                        dic[stack[0]]!.append(temp)
                    }
                }else {
                    let indexArray = graph[item]
                    if !indexArray.isEmpty {
                        stack.append(item)
                        allPathsSourceTargetHelper(&stack, graph, indexArray, &result, &dic)
                        stack.removeLast()
                    }
                }
            }
        }
    }
    
//    494. 目标和
//    给定一个非负整数数组，a1, a2, ..., an, 和一个目标数，S。现在你有两个符号 + 和 -。对于数组中的任意一个整数，你都可以从 + 或 -中选择一个符号添加在前面。
//    返回可以使最终数组和为目标数 S 的所有添加符号的方法数。
//    示例：
//    输入：nums: [1, 1, 1, 1, 1], S: 3
//    输出：5
//    解释：
//    -1+1+1+1+1 = 3
//    +1-1+1+1+1 = 3
//    +1+1-1+1+1 = 3
//    +1+1+1-1+1 = 3
//    +1+1+1+1-1 = 3
//    一共有5种方法让最终目标和为3。
//    提示：
//    数组非空，且长度不会超过 20 。
//    初始的数组的和不会超过 1000 。
//    保证返回的最终结果能被 32 位整数存下。
//    链接：https://leetcode-cn.com/problems/target-sum
    class func findTargetSumWays(_ nums: [Int], _ S: Int) -> Int {
        //f(i,S) = f(i-1,S-num[i]) + f(i-1,S+num[i])
//           0  1  2  3  4 5 6 7 8 9 10
//          -5 -4 -3 -2 -1 0 1 2 3 4 5
//        0  0             2         0
//        1  0           1   1       0
//        2  0  0  0  1  0 2 0 1
//        3  0  0  1  0  3 0 3 0 1 0 0
//        4  0  1  0  4  0 6 0 4 0 1 0
//        5  1  0  5  0 10 0 100 5 0  1
        
//        [0,0,0,0,0,0,0,0,1], 1
//           0 1 2
//          -1 0 1
//        0  0 2 0
//        1  0 4 0
//        2
//        3
//        4
//        5
//        6
//        7
//        8
//        9
        if nums.count == 1 {
            return nums[0] == S || nums[0] == -S ? 1 : 0
        }
        
        var maxLen = 0
        for num in nums {
            maxLen += num
        }
        if maxLen < S || -maxLen > -S {
            return 0
        }
        
        let len = maxLen * 2 + 1
        var dp = Array(repeating: Array(repeating: 0, count: len), count: nums.count + 1)
        dp[0][maxLen] = 2
        if nums[0] == 0 {
            dp[1][maxLen] = 2
        }else {
            dp[1][maxLen - nums[0]] = 1
            dp[1][maxLen + nums[0]] = 1
        }
        
        var i = 2
        while i <= nums.count {
            let num = nums[i - 1]
            var j = 0
            while j < len {
                let s = -maxLen + j
                var left = 0
                if s - num >= -maxLen  {
                    let leftIndex = (s - num) + maxLen
                    left = dp[i - 1][leftIndex]
                }
                var right = 0
                if s + num <= maxLen {
                    let rightIndex = (s + num) + maxLen
                    right = dp[i - 1][rightIndex]
                }
                dp[i][j] = left + right
                j += 1
            }
            i += 1
        }
        return dp[nums.count][S + maxLen]
        
        
        //超时
//        var count = 0
//        findTargetSumWays(nums, S, 0, 0, &count)
//        return count
    }
    
    class func findTargetSumWays(_ nums: [Int], _ S: Int,_ index: Int,_ result: Int,_ count: inout Int) {
        if index == nums.count {
            if result == S {
                count += 1
            }
            return
        }
        let num = nums[index]
        findTargetSumWays(nums, S, index + 1, result + num, &count)
        findTargetSumWays(nums, S, index + 1, result - num, &count)
    }
    
    class func testLFU(_ array: [String],_ array1: [[Int]]) {
        let lFUCache = LFUCache(0)
        var i = 0
        var result = ""
        while i < array.count {
            let str = array[i]
            let tuple = array1[i]
            
            if str == "put" {
                print("操作---\(i + 1) put[\(tuple[0]),\(tuple[1])]")
                lFUCache.put(tuple[0], tuple[1])
                result.append("null,")
            }else {
                print("操作---\(i + 1) get[\(tuple[0])]")
                result.append("\(lFUCache.get(tuple[0])),")
            }
            i += 1
        }
        print("结果：" + result)
    }
    
    
    class func testCache(_ array: [String],_ array1: [[Int]]) {
        let lRUCache = LRUCache(10)
        var i = 0
        while i < array.count {
            let str = array[i]
            let tuple = array1[i]
            
            if str == "put" {
                print("操作---\(i + 1) put[\(tuple[0]),\(tuple[1])]")
                lRUCache.put(tuple[0], tuple[1])
            }else {
                print("操作---\(i + 1) get[\(tuple[0])]")
                _ = lRUCache.get(tuple[0])
            }
            i += 1
        }
    }
//    460. LFU 缓存
//    请你为 最不经常使用（LFU）缓存算法设计并实现数据结构。
//    实现 LFUCache 类：
//    LFUCache(int capacity) - 用数据结构的容量 capacity 初始化对象
//    int get(int key) - 如果键存在于缓存中，则获取键的值，否则返回 -1。
//    void put(int key, int value) - 如果键已存在，则变更其值；如果键不存在，请插入键值对。当缓存达到其容量时，则应该在插入新项之前，使最不经常使用的项无效。在此问题中，当存在平局（即两个或更多个键具有相同使用频率）时，应该去除 最久未使用 的键。
//    注意「项的使用次数」就是自插入该项以来对其调用 get 和 put 函数的次数之和。使用次数会在对应项被移除后置为 0 。
//    为了确定最不常使用的键，可以为缓存中的每个键维护一个 使用计数器 。使用计数最小的键是最久未使用的键。
//    当一个键首次插入到缓存中时，它的使用计数器被设置为 1 (由于 put 操作)。对缓存中的键执行 get 或 put 操作，使用计数器的值将会递增。
//    示例：
//    输入：
//    ["LFUCache", "put", "put", "get", "put", "get", "get", "put", "get", "get", "get"]
//    [[2], [1, 1], [2, 2], [1], [3, 3], [2], [3], [4, 4], [1], [3], [4]]
//    输出：
//    [null, null, null, 1, null, -1, 3, null, -1, 3, 4]
//    解释：
//    // cnt(x) = 键 x 的使用计数
//    // cache=[] 将显示最后一次使用的顺序（最左边的元素是最近的）
//    LFUCache lFUCache = new LFUCache(2);
//    lFUCache.put(1, 1);   // cache=[1,_], cnt(1)=1
//    lFUCache.put(2, 2);   // cache=[2,1], cnt(2)=1, cnt(1)=1
//    lFUCache.get(1);      // 返回 1
//                          // cache=[1,2], cnt(2)=1, cnt(1)=2
//    lFUCache.put(3, 3);   // 去除键 2 ，因为 cnt(2)=1 ，使用计数最小
//                          // cache=[3,1], cnt(3)=1, cnt(1)=2
//    lFUCache.get(2);      // 返回 -1（未找到）
//    lFUCache.get(3);      // 返回 3
//                          // cache=[3,1], cnt(3)=2, cnt(1)=2
//    lFUCache.put(4, 4);   // 去除键 1 ，1 和 3 的 cnt 相同，但 1 最久未使用
//                          // cache=[4,3], cnt(4)=1, cnt(3)=2
//    lFUCache.get(1);      // 返回 -1（未找到）
//    lFUCache.get(3);      // 返回 3
//                          // cache=[3,4], cnt(4)=1, cnt(3)=3
//    lFUCache.get(4);      // 返回 4
//                          // cache=[3,4], cnt(4)=2, cnt(3)=3
//    提示：
//    0 <= capacity, key, value <= 104
//    最多调用 105 次 get 和 put 方法
//    进阶：你可以为这两种操作设计时间复杂度为 O(1) 的实现吗？
//    链接：https://leetcode-cn.com/problems/lfu-cache
    class LFUCache {
        class LFUNode {
            var key: Int
            var val: Int
            var prev: LFUNode?
            var next: LFUNode?
            init(_ key: Int, _ value: Int) {
                self.key = key
                self.val = value
            }
        }
        
        class LFULinkedHashMap {
            var hashmap: [Int: LFUNode] = [:]
            var head: LFUNode?
            var tail: LFUNode?
            var size = 0
            
            func put(key: Int,value: Int) {
                if let node = hashmap[key] {
                    node.val = value
                }else {
                    let node = LFUNode(key, value)
                    if size == 0 {
                        head = node
                        tail = node
                    }else {
                        tail?.next = node
                        node.prev = tail
                        tail = node
                    }
                    hashmap[key] = node
                    size += 1
                }
            }
            
            func remove(key: Int) {
                if let node = hashmap[key] {
                    if size == 1 {
                        head = nil
                        tail = nil
                    }else if node.key == head?.key {
                        head = node.next
                        head?.prev = nil
                    }else if node.key == tail?.key {
                        tail = node.prev
                        tail?.next = nil
                    }else {
                        node.prev?.next = node.next
                        node.next?.prev = node.prev
                    }
                    hashmap.removeValue(forKey: key)
                    size -= 1
                }
            }
        }
        var KeyToValue: [Int: Int] = [:]
        var KeyToCount: [Int: Int] = [:]
        var CountToKey: [Int: LFULinkedHashMap] = [:]
        var minCount = 0
        var capacity: Int

        init(_ capacity: Int) {
            self.capacity = capacity
        }
        
        func get(_ key: Int) -> Int {
            if let val = KeyToValue[key] {
                increaseCount(key)//更新节点的次数
                return val
            }
            return -1
        }
        
        func put(_ key: Int, _ value: Int) {
            guard capacity > 0 else {
                return
            }
            if let count = KeyToCount[key] {
                //已经存在，更新节点的值
                KeyToValue[key] = value
                let linkedHashMap = CountToKey[count]
                linkedHashMap?.put(key: key, value: value)
                increaseCount(key)//更新节点的次数
                return
            }
            //不存在
            //已经满了
            if KeyToValue.count == capacity {
                //删除不常使用的节点
                removeMinKey()
            }
            KeyToValue[key] = value
            KeyToCount[key] = 1
            var linkedHashMap: LFULinkedHashMap?
            if CountToKey[1] == nil {
                linkedHashMap = LFULinkedHashMap()
            }else {
                linkedHashMap = CountToKey[1]
            }
            linkedHashMap?.put(key: key, value: value)
            CountToKey[1] = linkedHashMap
            minCount = 1
        }
        //增加一个节点的使用次数
        func increaseCount(_ key: Int) {
            let count = KeyToCount[key]!//原来的次数
            let value = KeyToValue[key]!
            KeyToCount[key] = count + 1
            //从原来的链表移除
            var linkedHashMap = CountToKey[count]
            linkedHashMap?.remove(key: key)
            if linkedHashMap?.size == 0 {
                CountToKey.removeValue(forKey: count)
                if self.minCount == count {
                    self.minCount += 1
                }
            }
            //加入新的链表
            linkedHashMap = CountToKey[count + 1]
            if linkedHashMap == nil {
                linkedHashMap = LFULinkedHashMap()
            }
            linkedHashMap?.put(key: key, value: value)
            CountToKey[count + 1] = linkedHashMap
        }
        //删除不常使用的节点
        func removeMinKey() {
            let linkedHashMap = CountToKey[self.minCount]!
            let key = linkedHashMap.head!.key
            linkedHashMap.remove(key: key)
            if linkedHashMap.size == 0 {
                CountToKey.removeValue(forKey: self.minCount)
            }
            KeyToCount.removeValue(forKey: key)
            KeyToValue.removeValue(forKey: key)
        }
    }
    
//    146. LRU 缓存机制
//    运用你所掌握的数据结构，设计和实现一个  LRU (最近最少使用) 缓存机制 。
//    实现 LRUCache 类：
//    LRUCache(int capacity) 以正整数作为容量 capacity 初始化 LRU 缓存
//    int get(int key) 如果关键字 key 存在于缓存中，则返回关键字的值，否则返回 -1 。
//    void put(int key, int value) 如果关键字已经存在，则变更其数据值；如果关键字不存在，则插入该组「关键字-值」。当缓存容量达到上限时，它应该在写入新数据之前删除最久未使用的数据值，从而为新的数据值留出空间。
//    进阶：你是否可以在 O(1) 时间复杂度内完成这两种操作？
//    示例：
//    输入
//    ["LRUCache", "put", "put", "get", "put", "get", "put", "get", "get", "get"]
//    [[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]
//    输出
//    [null, null, null, 1, null, -1, null, -1, 3, 4]
//
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
//    0 <= key <= 3000
//    0 <= value <= 104
//    最多调用 3 * 104 次 get 和 put
//    链接：https://leetcode-cn.com/problems/lru-cache
    class LRUCache {
        class LRUNode {
            var key: Int
            var val: Int
            var next: LRUNode?
            var prev: LRUNode?
            init(_ key: Int, _ value: Int) {
                self.key = key
                self.val = value
            }
        }
        class LRULinkedHashMap {
            var hashmap: Dictionary<Int, LRUNode> = [:]
            var head: LRUNode?
            var tail: LRUNode?
            var size: Int = 0
            
            func get(_ key: Int) -> Int {
                if let node = hashmap[key] {
                    return node.val
                }
                return -1
            }
            
            func add(_ key: Int, _ value: Int) {
                if let node = hashmap[key] {
                    //已经存在，更新
                    node.val = value
                    bringToTail(node)
                }else {
                    let node = LRUNode(key, value)
                    if tail == nil {
                        head = node
                        tail = node
                    }else {
                        bringToTail(node)
                    }
                    hashmap[key] = node
                    size += 1
                }
            }
            
            func bringToTail(_ key: Int) {
                if let node = hashmap[key] {
                    bringToTail(node)
                }
            }
            
            func bringToTail(_ node: LRUNode) {
                if node.key != tail?.key {
                    if node.key == head?.key {
                        node.next?.prev = nil
                        head = node.next
                    }
                    node.prev?.next = node.next
                    node.next?.prev = node.prev
                    tail?.next = node
                    node.prev = tail
                    node.next = nil
                    tail = node
                }
            }
            
            func deleteHeadIfNeeded(_ key: Int) {
                guard hashmap[key] == nil else {
                    return
                }
                if let node = head {
                    delete(node.key)
                }
            }
            
            func delete(_ key: Int) {
                if let node = hashmap[key] {
                    if node.key == head?.key {
                        head = node.next
                        if node.key == tail?.key {
                            tail = node.prev
                        }
                    }else {
                        if node.key == tail?.key {
                            tail = node.prev
                        }else {
                            node.prev?.next = node.next
                        }
                    }
                    hashmap.removeValue(forKey: key)
                    size -= 1
                }
            }
            func printNode() {
                var node = head
                var str = ""
                while node != nil {
                    str += "[\(node!.key),\(node!.val)]"
                    node = node?.next
                }
                print(str)
            }
        }
        
        var capacity: Int
        var linkedHashMap: LRULinkedHashMap = LRULinkedHashMap()

        init(_ capacity: Int) {
            self.capacity = capacity
        }
        
        func get(_ key: Int) -> Int {
            let val = linkedHashMap.get(key)
            linkedHashMap.bringToTail(key)
//            linkedHashMap.printNode()
            return val
        }
        
        func put(_ key: Int, _ value: Int) {
            if linkedHashMap.size == capacity {
                //删除最老的
                linkedHashMap.deleteHeadIfNeeded(key)
            }
            linkedHashMap.add(key, value)
//            linkedHashMap.printNode()
        }
    }
}
