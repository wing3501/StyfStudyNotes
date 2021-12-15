//
//  二分查找.swift
//  StyfStudyNotes
//
//  Created by styf on 2021/2/9.
//

//int binary_search(int[] nums, int target) {
//    int left = 0, right = nums.length - 1;
//    while(left <= right) {
//        int mid = left + (right - left) / 2;
//        if (nums[mid] < target) {
//            left = mid + 1;
//        } else if (nums[mid] > target) {
//            right = mid - 1;
//        } else if(nums[mid] == target) {
//            // 直接返回
//            return mid;
//        }
//    }
//    // 直接返回
//    return -1;
//}
//
//int left_bound(int[] nums, int target) {
//    int left = 0, right = nums.length - 1;
//    while (left <= right) {
//        int mid = left + (right - left) / 2;
//        if (nums[mid] < target) {
//            left = mid + 1;
//        } else if (nums[mid] > target) {
//            right = mid - 1;
//        } else if (nums[mid] == target) {
//            // 别返回，锁定左侧边界
//            right = mid - 1;
//        }
//    }
//    // 最后要检查 left 越界的情况
//    if (left >= nums.length || nums[left] != target)
//        return -1;
//    return left;
//}
//
//
//int right_bound(int[] nums, int target) {
//    int left = 0, right = nums.length - 1;
//    while (left <= right) {
//        int mid = left + (right - left) / 2;
//        if (nums[mid] < target) {
//            left = mid + 1;
//        } else if (nums[mid] > target) {
//            right = mid - 1;
//        } else if (nums[mid] == target) {
//            // 别返回，锁定右侧边界
//            left = mid + 1;
//        }
//    }
//    // 最后要检查 right 越界的情况
//    if (right < 0 || nums[right] != target)
//        return -1;
//    return right;
//}

import Foundation

@objcMembers class BinarySearch: NSObject {
    class func test()  {
//        875. 爱吃香蕉的珂珂
//        print(minEatingSpeed([3,6,7,11], 8))//4
//        print(minEatingSpeed([30,11,23,4,20], 5))//30
//        print(minEatingSpeed([30,11,23,4,20], 6))//23
//        print(minEatingSpeed([332484035,524908576,855865114,632922376,222257295,690155293,112677673,679580077,337406589,290818316,877337160,901728858,679284947,688210097,692137887,718203285,629455728,941802184], 823855818))
        
//        1011. 在 D 天内送达包裹的能力
//        print(shipWithinDays([1,2,3,4,5,6,7,8,9,10], 5))//15
//        print(shipWithinDays([3,2,2,4,1,4], 3))//6
//        print(shipWithinDays([1,2,3,1,1], 4))//3
        
//        410. 分割数组的最大值
//        print(splitArray([7,2,5,10,8], 2))//18
//        print(splitArray([1,2,3,4,5], 2))//9
//        print(splitArray([1,4,4], 3))//4
//        print(splitArray([1,4,4], 1))//9
//        print(splitArray([2,3,1,1,1,1,1], 5))//3
        
//        870. 优势洗牌
        print(advantageCount([2,7,11,15], [1,10,4,11]))//[2,11,7,15]
        print(advantageCount([12,24,8,32], [13,25,32,11]))//[24,32,8,12]
    }
//    870. 优势洗牌
//    给定两个大小相等的数组 A 和 B，A 相对于 B 的优势可以用满足 A[i] > B[i] 的索引 i 的数目来描述。
//    返回 A 的任意排列，使其相对于 B 的优势最大化。
//    示例 1：
//    输入：A = [2,7,11,15], B = [1,10,4,11]
//    输出：[2,11,7,15]
//    示例 2：
//    输入：A = [12,24,8,32], B = [13,25,32,11]
//    输出：[24,32,8,12]
//    提示：
//    1 <= A.length = B.length <= 10000
//    0 <= A[i] <= 10^9
//    0 <= B[i] <= 10^9
//    链接：https://leetcode-cn.com/problems/advantage-shuffle
    class func advantageCount(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var nums11: [[Int]] = []
        var nums22: [[Int]] = []
        var resultArr = Array(repeating: -1, count: nums1.count)
        var i = 0
        while i < nums1.count {
            nums11.append([nums1[i],i])
            nums22.append([nums2[i],i])
            i += 1
        }
        //都从大到小排序
        nums11.sort { arr1, arr2 in
            return arr1[0] > arr2[0]
        }
        nums22.sort { arr1, arr2 in
            return arr1[0] > arr2[0]
        }
        
        var left = 0
        var right = nums11.count - 1
        i = 0
        while i < nums22.count {
            let item = nums22[i]
            let val = item[0]
            let index = item[1]
            
            let num = nums11[left][0]
            if num > val {//大和大比，比不过就放最小的
                resultArr[index] = num
                left += 1
            }else {
                resultArr[index] = nums11[right][0]
                right -= 1
            }
            i += 1
        }
        return resultArr
        
        //-------------------------------------
//        var nums11: [[Int]] = []
//        var nums22: [[Int]] = []
//        var reusltArr = Array(repeating: -1, count: nums1.count)
//        var i = 0
//        while i < nums1.count {
//            nums11.append([nums1[i],i])
//            nums22.append([nums2[i],i])
//            i += 1
//        }
//
//        nums11.sort { arr1, arr2 in
//            return arr1[0] > arr2[0]
//        }
//        nums22.sort { arr1, arr2 in
//            return arr1[0] < arr2[0]
//        }
//        var noMoreMin = false
//
//        i = 0
//        while i < nums11.count {
//            let item = nums11[i]
//            let val = item[0]
//            var left = 0
//            var right = nums22.count - 1
//            while left <= right {
//                let mid = left + (right - left) / 2
//                let arr = nums22[mid]
//                let arrVal = arr[0]
//                if val == arrVal {
//                    right = mid - 1
//                }else if val > arrVal {
//                    left = mid + 1
//                }else if val < arrVal {
//                    right = mid - 1
//                }
//            }
//            var target: [Int]?
//            if left != 0 && !noMoreMin {
//                target = nums22[left - 1]
//                while left > 0 && reusltArr[target![1]] != -1 {//这个位置已经被占了
//                    left -= 1
//                    target = nums22[left]
//                }
//            }
//
//            if target == nil || (target != nil && reusltArr[target![1]] != -1) {
//                noMoreMin = true
//                //没有找到比这个元素更小的，就在剩下位置随便放，反正都是输
//                var j = nums22.count - 1
//                while j >= 0 {
//                    let tempTarget = nums22[j]
//                    if reusltArr[tempTarget[1]] == -1 {
//                        target = tempTarget
//                        break
//                    }
//                    j -= 1
//                }
//            }
//            reusltArr[target![1]] = val
//
//            i += 1
//        }
//        return reusltArr
    }
//    410. 分割数组的最大值
//    给定一个非负整数数组 nums 和一个整数 m ，你需要将这个数组分成 m 个非空的连续子数组。
//    设计一个算法使得这 m 个子数组各自和的最大值最小。
//    示例 1：
//    输入：nums = [7,2,5,10,8], m = 2
//    输出：18
//    解释：
//    一共有四种方法将 nums 分割为 2 个子数组。 其中最好的方式是将其分为 [7,2,5] 和 [10,8] 。
//    因为此时这两个子数组各自的和的最大值为18，在所有情况中最小。
//    示例 2：
//    输入：nums = [1,2,3,4,5], m = 2
//    输出：9
//    示例 3：
//    输入：nums = [1,4,4], m = 3
//    输出：4
//    提示：
//    1 <= nums.length <= 1000
//    0 <= nums[i] <= 106
//    1 <= m <= min(50, nums.length)
//    链接：https://leetcode-cn.com/problems/split-array-largest-sum
    class func splitArray(_ nums: [Int], _ m: Int) -> Int {
        //确定一个max,最少能把nums分成m  max取值[max(nums),sum(nums)]
        var leijia: [Int] = []
        var right = 0
        var left = 0
        for item in nums {
            right += item
            leijia.append(right)
            left = max(left, item)
        }
        
        var result = 0
        while left <= right {
            let mid = left + (right - left) / 2
            let tuple = canSplit(leijia, mid, m)
            if tuple.0 > m {
                left = mid + 1
            }else if tuple.0 < m {
                right = mid - 1
                result = tuple.1
            }else {
                right = mid - 1
                result = tuple.1
            }
        }
        
        return result
    }
    
    class func canSplit(_ leijia: [Int],_ val:Int,_ m: Int) -> (Int,Int) {
        var start = 0
        var lastVal = 0
        var count = 0
        var result = 0
        while start < leijia.count - 1 {
            var left = start
            var right = leijia.count - 1
            while left <= right {
                let mid = left + (right - left) / 2
                var cur = leijia[mid]
                if lastVal > 0 {
                    cur -= lastVal
                }
                if cur > val {
                    right = mid - 1
                }else {
                    left = mid + 1
                }
            }
            start = left - 1
            result = max(result, leijia[start] - lastVal)
            lastVal = leijia[start]
            count += 1
            if count > m {
                break
            }
        }
        return (count,result)
    }
    
//    1011. 在 D 天内送达包裹的能力
//    传送带上的包裹必须在 D 天内从一个港口运送到另一个港口。
//    传送带上的第 i 个包裹的重量为 weights[i]。每一天，我们都会按给出重量的顺序往传送带上装载包裹。我们装载的重量不会超过船的最大运载重量。
//    返回能在 D 天内将传送带上的所有包裹送达的船的最低运载能力。
//    示例 1：
//    输入：weights = [1,2,3,4,5,6,7,8,9,10], D = 5
//    输出：15
//    解释：
//    船舶最低载重 15 就能够在 5 天内送达所有包裹，如下所示：
//    第 1 天：1, 2, 3, 4, 5
//    第 2 天：6, 7
//    第 3 天：8
//    第 4 天：9
//    第 5 天：10
//    请注意，货物必须按照给定的顺序装运，因此使用载重能力为 14 的船舶并将包装分成 (2, 3, 4, 5), (1, 6, 7), (8), (9), (10) 是不允许的。
//    示例 2：
//    输入：weights = [3,2,2,4,1,4], D = 3
//    输出：6
//    解释：
//    船舶最低载重 6 就能够在 3 天内送达所有包裹，如下所示：
//    第 1 天：3, 2
//    第 2 天：2, 4
//    第 3 天：1, 4
//    示例 3：
//    输入：weights = [1,2,3,1,1], D = 4
//    输出：3
//    解释：
//    第 1 天：1
//    第 2 天：2
//    第 3 天：3
//    第 4 天：1, 1
//    提示：
//    1 <= D <= weights.length <= 5 * 104
//    1 <= weights[i] <= 500
//    链接：https://leetcode-cn.com/problems/capacity-to-ship-packages-within-d-days
    class func shipWithinDays(_ weights: [Int], _ days: Int) -> Int {
        var left = 0
        var right = 0
        var leijia: [Int] = []
        for item in weights {
            left = max(left, item)
            right += item
            leijia.append(right)
        }
    
        while left < right {
            let mid = left + (right - left) / 2
            if canShip(leijia, days, mid) {
                right = mid
            }else {
                left = mid + 1
            }
        }
        return left
    }
    
    class func canShip(_ leijia: [Int], _ days: Int,_ weight: Int) -> Bool {
        var mydays = 0
        var lastIndex = -1
        var lastVal = -1
        var start = 0
        var left = 0
        while start < leijia.count - 1 {
            var right = leijia.count - 1
            while left <= right {
                let mid = left + (right - left) / 2
                var val = leijia[mid]
                if lastIndex >= 0 {
                    val -= lastVal
                }
                
                if val < weight {
                    left = mid + 1
                }else if val > weight {
                    right = mid - 1
                }else {
                    left = mid + 1
                    break
                }
            }
            lastIndex = left - 1
            lastVal = leijia[left - 1]
            start = left - 1
            mydays += 1
            if mydays > days {
                return false
            }
        }
        return mydays <= days
    }
    
    
//    875. 爱吃香蕉的珂珂
//    珂珂喜欢吃香蕉。这里有 N 堆香蕉，第 i 堆中有 piles[i] 根香蕉。警卫已经离开了，将在 H 小时后回来。
//    珂珂可以决定她吃香蕉的速度 K （单位：根/小时）。每个小时，她将会选择一堆香蕉，从中吃掉 K 根。如果这堆香蕉少于 K 根，她将吃掉这堆的所有香蕉，然后这一小时内不会再吃更多的香蕉。
//    珂珂喜欢慢慢吃，但仍然想在警卫回来前吃掉所有的香蕉。
//    返回她可以在 H 小时内吃掉所有香蕉的最小速度 K（K 为整数）。
//    示例 1：
//    输入: piles = [3,6,7,11], H = 8
//    输出: 4
//    示例 2：
//    输入: piles = [30,11,23,4,20], H = 5
//    输出: 30
//    示例 3：
//    输入: piles = [30,11,23,4,20], H = 6
//    输出: 23
//    链接：https://leetcode-cn.com/problems/koko-eating-bananas
    class func minEatingSpeed(_ piles: [Int], _ h: Int) -> Int {
        var sum = 0
        var right = 0
        for item in piles {
            sum += item
            right = max(right, item)
        }
        var left = Int(ceil(Double(sum) / Double(h)))
        while left < right {
            let mid = left + (right - left) / 2
//            print("\(left) \(right) \(mid)")
            let can = canEat(piles, mid, h)
            if can {
                right = mid
            }else {
                left = mid + 1
            }
        }
        return left
    }
    
    class func canEat(_ piles: [Int],_ eat: Int,_ h: Int) -> Bool {
        var i = 0
        var count = 0
        while i < piles.count {
            let temp = Int(ceil(Double(piles[i]) / Double(eat)))
            count += temp
            i += 1
            if count >= h {
                break
            }
        }
        return count <= h && i == piles.count
    }
}
