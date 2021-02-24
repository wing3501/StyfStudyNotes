//
//  排序.swift
//  StyfStudyNotes
//
//  Created by styf on 2021/2/24.
//

import Foundation

@objcMembers class SortTest: NSObject {
    
    class func test() {
        let array = [88, 44, 53, 41, 16, 6, 70]
        print(bubbleSort(array: array))
        print(selectionSort(array: array))
        print(heapSort(array: array))
        print(insertionSort(array: array))
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
}
