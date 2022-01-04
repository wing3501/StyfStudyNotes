//
//  排序.swift
//  StyfStudyNotes
//
//  Created by styf on 2021/2/24.
//

import Foundation

@objcMembers class SortTest: NSObject {
    // 洗牌算法
    func shuffle(_ arr: inout [Int]) {
        let n = arr.count
        var i = 0
        while i < n {
            let rand = Int.random(in: i...n-1)
            arr.swapAt(i, rand)
            i += 1
        }
    }
    
    
    class func test() {
//        let array = [88, 44, 53, 41, 16, 6, 70]
//        print(bubbleSort(array: array))
//        print(selectionSort(array: array))
//        print(heapSort(array: array))
//        print(insertionSort(array: array))
//        print(mergeSort(array: array))
//        print(quickSort(array: array))
        
        //        1288. 删除被覆盖区间
//        print(removeCoveredIntervals([[1,4],[3,6],[2,8]]))//2
//        print(removeCoveredIntervals([[3,10],[4,10],[5,11]]))//2
//        print(removeCoveredIntervals([[1,2],[1,4],[3,4]]))//1
        
//        56. 合并区间
//        print(merge([[1,3],[2,6],[8,10],[15,18]]))
//        print(merge([[1,4],[4,5]]))
        
//        986. 区间列表的交集
//        print(intervalIntersection([[0,2],[5,10],[13,23],[24,25]], [[1,5],[8,12],[15,24],[25,26]]))
//        print(intervalIntersection([[1,3],[5,9]], []))
//        print(intervalIntersection([], [[4,8],[10,12]]))
//        print(intervalIntersection([[1,7]], [[3,10]]))
//        print(intervalIntersection([[3,5],[9,20]], [[4,5],[7,10],[11,12],[14,15],[16,20]])) //[[4,5],[9,10],[11,12],[14,15],[16,20]]
        
        
        
    }
    
//    986. 区间列表的交集
//    给定两个由一些 闭区间 组成的列表，firstList 和 secondList ，其中 firstList[i] = [starti, endi] 而 secondList[j] = [startj, endj] 。每个区间列表都是成对 不相交 的，并且 已经排序 。
//    返回这 两个区间列表的交集 。
//    形式上，闭区间 [a, b]（其中 a <= b）表示实数 x 的集合，而 a <= x <= b 。
//    两个闭区间的 交集 是一组实数，要么为空集，要么为闭区间。例如，[1, 3] 和 [2, 4] 的交集为 [2, 3] 。
//    示例 1：
//    输入：firstList = [[0,2],[5,10],[13,23],[24,25]], secondList = [[1,5],[8,12],[15,24],[25,26]]
//    输出：[[1,2],[5,5],[8,10],[15,23],[24,24],[25,25]]
//    示例 2：
//    输入：firstList = [[1,3],[5,9]], secondList = []
//    输出：[]
//    示例 3：
//    输入：firstList = [], secondList = [[4,8],[10,12]]
//    输出：[]
//    示例 4：
//    输入：firstList = [[1,7]], secondList = [[3,10]]
//    输出：[[3,7]]
//    提示：
//    0 <= firstList.length, secondList.length <= 1000
//    firstList.length + secondList.length >= 1
//    0 <= starti < endi <= 109
//    endi < starti+1
//    0 <= startj < endj <= 109
//    endj < startj+1
//    https://leetcode-cn.com/problems/interval-list-intersections/
    class func intervalIntersection(_ firstList: [[Int]], _ secondList: [[Int]]) -> [[Int]] {
        var array: [[Int]] = []
        var index1 = 0
        var index2 = 0
        while index1 < firstList.count && index2 < secondList.count {
            let first = firstList[index1]
            let second = secondList[index2]
            
            if second[1] >= first[0] && second[0] <= first[1] {
                array.append([max(first[0], second[0]),min(first[1], second[1])])
            }
            if second[1] < first[1] {
                index2 += 1
            }else {
                index1 += 1
            }
            
//            if (first[0] >= second[0] && first[0] <= second[1]) || (second[0] >= first[0] && second[0] <= first[1]) {
//                array.append([max(first[0], second[0]),min(first[1], second[1])])
//            }
//
//            if first[0] > second[0] {
//                if first[1] < second[1] {
//                    index1 += 1
//                }else {
//                    index2 += 1
//                }
//            }else if first[0] == second[0] && first[1] > second[1] {
//                index2 += 1
//            }else if first[0] < second[0] {
//                if first[1] > second[1] {
//                    index2 += 1
//                }else {
//                    index1 += 1
//                }
//            }else if first[0] == second[0] && first[1] < second[1] {
//                index1 += 1
//            }else {
//                index1 += 1
//                index2 += 1
//            }
            
        }
        return array
    }
    
//    56. 合并区间
//    以数组 intervals 表示若干个区间的集合，其中单个区间为 intervals[i] = [starti, endi] 。请你合并所有重叠的区间，并返回一个不重叠的区间数组，该数组需恰好覆盖输入中的所有区间。
//    示例 1：
//    输入：intervals = [[1,3],[2,6],[8,10],[15,18]]
//    输出：[[1,6],[8,10],[15,18]]
//    解释：区间 [1,3] 和 [2,6] 重叠, 将它们合并为 [1,6].
//    示例 2：
//    输入：intervals = [[1,4],[4,5]]
//    输出：[[1,5]]
//    解释：区间 [1,4] 和 [4,5] 可被视为重叠区间。
//    提示：
//    1 <= intervals.length <= 104
//    intervals[i].length == 2
//    0 <= starti <= endi <= 104
//    https://leetcode-cn.com/problems/merge-intervals/
    class func merge(_ intervals: [[Int]]) -> [[Int]] {
        let array = intervals.sorted { (arr1, arr2) -> Bool in
            if arr1[0] == arr2[0] {
                return arr1[1] > arr2[1]
            }
            return arr1[0] < arr2[0]
        }
        var i = 1
        var left = array[0][0]
        var right = array[0][1]
        var resultArr: [[Int]] = []
        while i < array.count {
            let cur = array[i]
            if cur[0] > right {//没有交集
                resultArr.append([left,right])
                left = cur[0]
                right = cur[1]
            }else if cur[0] <= right {//有交集
                right = max(right, cur[1])
            }
            i += 1
        }
        resultArr.append([left,right])
        return resultArr
    }
    
    //    1288. 删除被覆盖区间
    //    给你一个区间列表，请你删除列表中被其他区间所覆盖的区间。
    //    只有当 c <= a 且 b <= d 时，我们才认为区间 [a,b) 被区间 [c,d) 覆盖。
    //    在完成所有删除操作后，请你返回列表中剩余区间的数目。
    //    示例：
    //    输入：intervals = [[1,4],[3,6],[2,8]]
    //    输出：2
    //    解释：区间 [3,6] 被区间 [2,8] 覆盖，所以它被删除了。
    //    提示：
    //    1 <= intervals.length <= 1000
    //    0 <= intervals[i][0] < intervals[i][1] <= 10^5
    //    对于所有的 i != j：intervals[i] != intervals[j]
    //    https://leetcode-cn.com/problems/remove-covered-intervals/
        class func removeCoveredIntervals(_ intervals: [[Int]]) -> Int {
            if intervals.count < 2 {
                return intervals.count
            }
            let array = intervals.sorted { (arr1, arr2) -> Bool in
                if arr1[0] > arr2[0] {
                    return true
                }else if arr1[0] < arr2[0] {
                    return false
                }else {
                    return arr1[1] <= arr2[1]
                }
            };
    //        [[3, 6], [2, 8], [1, 4]]
    //        [[5, 11], [4, 10], [3, 10]]
    //        print(array)
            var i = array.count - 2
            var last = array[array.count - 1][1]
            var count = 0
            while i >= 0 {
                let cur = array[i][1]
                if last >= cur {
                    count += 1
                }else {
                    last = cur
                }
                i -= 1
            }
            
            return array.count - count
        }
    
    /// 冒泡排序，两两比较，交换，每一轮确定一个最大的(可优化，提前结束)
    /// 记录每次交换的位置，end = recordIndex + 1
    class func bubbleSort(array: [Int]) -> [Int] {
        var arr = array
        var end = arr.count - 1
        while end > 0 {
            var i = 0
            while i < end {
                if arr[i] > arr[i + 1] {
                    arr.swapAt(i, i + 1)
                }
                i += 1
            }
            end -= 1
        }
        return arr
    }
    //选择排序   扫描一遍，找出最大的和末尾交换位置，下一遍扫描的时候忽略刚刚的那个
    class func selectionSort(array: [Int]) -> [Int] {
        var arr = array
        var end = arr.count - 1
        while end > 0 {
            var maxIndex = 0
            var i = 1
            while i <= end {
                if arr[i] > arr[maxIndex] {
                    maxIndex = i
                }
                i += 1
            }
            arr.swapAt(maxIndex, end)
            end -= 1
        }
        return arr
    }
    
    //堆排序
    class func heapSort(array: [Int]) -> [Int] {
        // 自下而上的下滤
        var arr = array
        var i = array.count / 2 - 1
        while i >= 0  {//前一半元素做下滤操作
            siftDown(array: &arr, i: i,heapSize: arr.count)
            i -= 1
        }
        
        var heapSize = arr.count
        while heapSize > 1 {
            heapSize -= 1
            arr.swapAt(0, heapSize)
            siftDown(array: &arr, i: 0,heapSize: heapSize)
        }
        
        return arr
    }
    
    //下滤
    class func siftDown(array: inout [Int],i: Int,heapSize: Int) {
        var index = i
        let element = array[index]
        let half = heapSize / 2
        while index < half {
            var childIndex = index * 2 + 1
            let rightIndex = childIndex + 1
            if rightIndex < heapSize && array[rightIndex] > array[childIndex] {
                childIndex = rightIndex
            }
            
            if array[childIndex] <= element {
                break
            }
            array[index] = array[childIndex]
            index = childIndex
        }
        array[index] = element
    }
    //上滤
    class func siftUp(array: inout [Int],i: Int) {
        var index = i
        let element = array[index]
        while index > 0 {
            let parentIndex = (index - 1) / 2
            let parent = array[parentIndex]
            if parent >= element {
                break
            }
            array[index] = parent
            index = parentIndex
        }
        array[index] = element
    }
    //插入排序
    class func insertionSort(array: [Int]) -> [Int] {
        var arr = array
        var i = 1
        while i < arr.count {
            var right = i
            let num = arr[i]
            if num < arr[right - 1] {
                var left = 0
                while left < right {
                    let mid = (right + left) / 2
                    if num >= arr[mid] {
                        left = mid + 1
                    }else {
                        right = mid
                    }
                }
            }
            
            var j = i
            while j > right {
                arr.swapAt(j, j - 1)
                j -= 1
            }
            arr[right] = num
            i += 1
        }
        return arr
    }
    //归并排序
    class func mergeSort(array: [Int]) -> [Int] {
        var arr = array
        mergeSort(array: &arr, begin: 0, end: arr.count)
        return arr
    }
    
    class func mergeSort(array: inout [Int],begin: Int, end: Int) {
        if end - begin < 2{
            return
        }
        let mid = (begin + end) / 2
        mergeSort(array: &array, begin: begin, end: mid)
        mergeSort(array: &array, begin: mid, end: end)
        mergeArray(array: &array, begin: begin, mid: mid, end: end)
    }
    class func mergeArray(array: inout [Int],begin: Int,mid: Int, end: Int) {
        let leftArray = Array(array[begin...(mid - 1)])
        var leftArrayIndex = 0
        var rightArrayIndex = mid
        var index = begin
        while leftArrayIndex < leftArray.count && rightArrayIndex < end {
            if leftArray[leftArrayIndex] < array[rightArrayIndex] {
                array[index] = leftArray[leftArrayIndex]
                leftArrayIndex += 1
            }else {
                array[index] = array[rightArrayIndex]
                rightArrayIndex += 1
            }
            index += 1
        }
        while leftArrayIndex < leftArray.count {
            array[index] = leftArray[leftArrayIndex]
            leftArrayIndex += 1
            index += 1
        }
        while rightArrayIndex < end {
            array[index] = array[rightArrayIndex]
            rightArrayIndex += 1
            index += 1
        }
    }
    
    class func quickSort(array: [Int]) -> [Int] {
        var arr = array
        quickSort(array: &arr, begin: 0, end: arr.count)
        return arr
    }
    
    class func quickSort(array: inout [Int],begin: Int,end: Int) {
        if end - begin < 2 {
            return;
        }
        //随机选一个点和begin的点交换 [begin,end)
        let randomIndex = begin + Int.random(in: 0..<(end - begin))
        array.swapAt(randomIndex, begin)
        //快排一遍
        let point = array[begin]
        var left = begin
        var right = end - 1
        while left < right {
            while left < right {
                if array[right] > point {
                    right -= 1
                }else {
                    array[left] = array[right]
                    left += 1
                    break;
                }
            }
            while left < right {
                if array[left] < point {
                    left += 1
                }else {
                    array[right] = array[left]
                    right -= 1
                    break
                }
            }
        }
        array[left] = point
        //对轴点元素分割的两个序列再次快排
        quickSort(array: &array, begin: begin, end: left)
        quickSort(array: &array, begin: left + 1, end: end)
    }
}
