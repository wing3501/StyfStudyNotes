//
//  二进制.swift
//  StyfStudyNotes
//
//  Created by styf on 2021/2/26.
//

import Foundation
//移除最后一个 1
//a=n & (n - 1)

//获取最后一个 1
//diff=(n & (n-1)) ^ n

//基本操作
//a=0^a=a^0
//0=a^a
//由上面两个推导出：a=a^b^b

//交换两个数
//a=a^b
//b=a^b
//a=a^b

//大写转小写
//('a' | ' ') = 'a'
//('A' | ' ') = 'a'

//小写转大写
//('b' & '_') = 'b'
//('B' & '_') = 'b'

//大小写互换
//('d' ^ ' ') = 'D'
//('D' ^ ' ') = 'b'

//判断两个数是否异号
// int x = -1,y = 2
// bool f = ((x^y) < 0) //true

//加一
// int n = 1
// n = -~n

//减一
// int n = 2
// n = ~-n


@objcMembers class Math : NSObject {
    class func test() {
        //    172. 阶乘后的零
//        print(trailingZeroes(124))
        //    793. 阶乘函数后 K 个零
        print(preimageSizeFZF(31))
        print(preimageSizeFZF(5))
    }
    
//    793. 阶乘函数后 K 个零
//    f(x) 是 x! 末尾是 0 的数量。（回想一下 x! = 1 * 2 * 3 * ... * x，且 0! = 1 ）
//    例如， f(3) = 0 ，因为 3! = 6 的末尾没有 0 ；而 f(11) = 2 ，因为 11!= 39916800 末端有 2 个 0 。给定 K，找出多少个非负整数 x ，能满足 f(x) = K 。
//    示例 1：
//    输入：K = 0
//    输出：5
//    解释：0!, 1!, 2!, 3!, and 4! 均符合 K = 0 的条件。
//    示例 2：
//    输入：K = 5
//    输出：0
//    解释：没有匹配到这样的 x!，符合 K = 5 的条件。
//    提示：
//    K 是范围在 [0, 10^9] 的整数。
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/preimage-size-of-factorial-zeroes-function
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func preimageSizeFZF(_ k: Int) -> Int {
        // a + b + c = k
        // 25 + 5 + 1 = 31
        // 24 + 4     = 25
        // 6 + 1       = 7
        var left = 0
        var right = Int.max
        while left <= right {
            let mid = left + (right - left) / 2
            let kk = trailingZeroes(mid)
            if kk == k {
                right = mid - 1
            }else if kk < k {
                left = mid + 1
            }else {
                right = mid - 1
            }
        }
        
        let leftBound = left
        left = 0
        right = Int.max
        while left <= right {
            let mid = left + (right - left) / 2
            let kk = trailingZeroes(mid)
            if kk == k {
                left = mid + 1
            }else if kk < k {
                left = mid + 1
            }else {
                right = mid - 1
            }
        }
        let rightBound = right
        
        return rightBound - leftBound + 1
    }
    
//    172. 阶乘后的零
//    给定一个整数 n ，返回 n! 结果中尾随零的数量。
//    提示 n! = n * (n - 1) * (n - 2) * ... * 3 * 2 * 1
//    示例 1：
//    输入：n = 3
//    输出：0
//    解释：3! = 6 ，不含尾随 0
//    示例 2：
//    输入：n = 5
//    输出：1
//    解释：5! = 120 ，有一个尾随 0
//    示例 3：
//    输入：n = 0
//    输出：0
//    提示：
//    0 <= n <= 104
//    进阶：你可以设计并实现对数时间复杂度的算法来解决此问题吗？
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/factorial-trailing-zeroes
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func trailingZeroes(_ n: Int) -> Int {
//        0001 0010 0011 0100 0101 0110 0111 1000 1001 1010
//        1    2    3    4    5    6    7    8    9    10
        // 问题转化为可以分解出多少个5 因为分解出来的2肯定比5多
        
        //一个因子的
        var count = 0
        var lei = 5
        while lei <= n {
            count += (n / lei)
            lei *= 5
        }
        return count
    }
}
