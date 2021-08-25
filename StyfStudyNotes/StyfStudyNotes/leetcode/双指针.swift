//
//  双指针.swift
//  StyfStudyNotes
//
//  Created by styf on 2021/2/9.
//

//1.快慢指针
//     1.1判断是否有环
//     1.2环起点:从相遇点开始，让其中任一个指针重新指向头节点，让他俩同速前进，再次相遇就是环起点
//     1.3寻找链表中点：快两步，慢一步。快指针到达终点的时候，慢指针就在中点（奇数时在中点偏右）
//     1.4寻找链表倒数第k元素：快指针先走k步，再同速一起走，快指针到达末尾null时，慢指针就是第k元素
//2.左右指针
//     2.1二分搜索
//     2.2两数之和
//     2.3翻转数组
//     2.4滑动窗口

/* 滑动窗口算法框架 */
//void slidingWindow(string s, string t) {
//    unordered_map<char, int> need, window;
//    for (char c : t) need[c]++;
//
//    int left = 0, right = 0;
//    int valid = 0;
//    while (right < s.size()) {
//        // c 是将移入窗口的字符
//        char c = s[right];
//        // 右移窗口
//        right++;
//        // 进行窗口内数据的一系列更新
//        ...
//
//        /*** debug 输出的位置 ***/
//        printf("window: [%d, %d)\n", left, right);
//        /********************/
//
//        // 判断左侧窗口是否要收缩
//        while (window needs shrink) {
//            // d 是将移出窗口的字符
//            char d = s[left];
//            // 左移窗口
//            left++;
//            // 进行窗口内数据的一系列更新
//            ...
//        }
//    }
//}

import Foundation

@objcMembers class TwoPtr: NSObject {
    class func test()  {
//        5. 最长回文子串
//        print(longestPalindrome("babad"))//"bab"
//        print(longestPalindrome("cbbd"))//"bb"
//        print(longestPalindrome("a"))//"a"
//        print(longestPalindrome("ac"))//"a"
        
        //    76. 最小覆盖子串
//        print(minWindow("ADOBECODEBANC", "ABC"))
//        print(minWindow("a", "a"))
//        print(minWindow("a", "aa"))
//        print(minWindow("a", "b"))
        
//        567. 字符串的排列
//        print(checkInclusion("ab", "eidbaooo"))
//        print(checkInclusion("ab", "eidboaoo"))
//        print(checkInclusion("hello", "ooolleoooleh"))
//        print(checkInclusion("h", "jrfrspuz"))
//        print(checkInclusion("ky", "ainwkckifykxlribaypk"))
//        print(checkInclusion("ab", "dacbd"))
        
//        438. 找到字符串中所有字母异位词
//        print(findAnagrams("cbaebabacd", "abc"))//[0,6]
//        print(findAnagrams("abab", "ab"))//[0,1,2]
//        print(findAnagrams("baa", "aa"))
        
//        3. 无重复字符的最长子串
//        print(lengthOfLongestSubstring("abcabcbb"))//3
//        print(lengthOfLongestSubstring("bbbbb"))//1
//        print(lengthOfLongestSubstring("pwwkew"))//3
//        print(lengthOfLongestSubstring(""))//0
//        print(lengthOfLongestSubstring(" "))//1
//        print(lengthOfLongestSubstring("au"))//2
//        print(lengthOfLongestSubstring("abba"))//2
        
//        1. 两数之和
//        print(twoSum([2,7,11,15], 9))//[0,1]
//        print(twoSum([3,2,4], 6))//[1,2]
//        print(twoSum([3,3], 6))//[0,1]
        
        //    15. 三数之和
//        print(threeSum([-1,0,1,2,-1,-4]))//[[-1,-1,2],[-1,0,1]]
//        print(threeSum([]))
//        print(threeSum([0]))
//        print(threeSum([0,0,0]))
        
//        18. 四数之和
        print(fourSum([1,0,-1,0,-2,2], 0))
        print(fourSum([2,2,2,2,2], 8))
    }
    
//    18. 四数之和
//    给你一个由 n 个整数组成的数组 nums ，和一个目标值 target 。请你找出并返回满足下述全部条件且不重复的四元组 [nums[a], nums[b], nums[c], nums[d]] ：
//    0 <= a, b, c, d < n
//    a、b、c 和 d 互不相同
//    nums[a] + nums[b] + nums[c] + nums[d] == target
//    你可以按 任意顺序 返回答案 。
//    示例 1：
//    输入：nums = [1,0,-1,0,-2,2], target = 0
//    输出：[[-2,-1,1,2],[-2,0,0,2],[-1,0,0,1]]
//    示例 2：
//    输入：nums = [2,2,2,2,2], target = 8
//    输出：[[2,2,2,2]]
//    提示：
//    1 <= nums.length <= 200
//    -109 <= nums[i] <= 109
//    -109 <= target <= 109
//    https://leetcode-cn.com/problems/4sum/
    class func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        if nums.count < 4 {
            return []
        }
        let array = nums.sorted()
        var set = Set<[Int]>()
        for (index,item) in array.enumerated() {
            let t1 = target - item
            if index < array.count - 3 {
                let l = index + 1
                let r = array.count - 1
                var set1 = Set<[Int]>()
                var i = l
                while i <= r {
                    let num = array[i]
                    let t2 = t1 - num
                    if i < array.count - 2 {
                        var left = i + 1
                        var right = r
                        while left < right {
                            let leftNum = array[left]
                            let rightNum = array[right]
                            if leftNum + rightNum < t2 {
                                while left < nums.count && leftNum == array[left] {
                                    left += 1
                                }
                            }else if leftNum + rightNum > t2 {
                                while right >= 0 && rightNum == array[right] {
                                    right -= 1
                                }
                            }else {
                                set1.insert([leftNum,rightNum,num])
                                while left < nums.count && leftNum == array[left] {
                                    left += 1
                                }
                                while right >= 0 && rightNum == array[right] {
                                    right -= 1
                                }
                            }
                        }
                    }
                    i += 1
                }
                for item1 in set1 {
                    var arr = item1
                    arr.append(item)
                    set.insert(arr)
                }
            }
        }
        
        return Array(set)
    }
    
//    15. 三数之和
//    给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有和为 0 且不重复的三元组。
//    注意：答案中不可以包含重复的三元组。
//    示例 1：
//    输入：nums = [-1,0,1,2,-1,-4]
//    输出：[[-1,-1,2],[-1,0,1]]
//    示例 2：
//    输入：nums = []
//    输出：[]
//    示例 3：
//    输入：nums = [0]
//    输出：[]
//    提示：
//    0 <= nums.length <= 3000
//    -105 <= nums[i] <= 105
//    https://leetcode-cn.com/problems/3sum/
    class func threeSum(_ nums: [Int]) -> [[Int]] {
        if nums.count < 3 {
            return []
        }
        let array = nums.sorted()
        var set = Set<[Int]>()
        for (index,target) in array.enumerated() {
            if index < array.count - 2 {
                var left = index + 1
                var right = array.count - 1
                while left < right {
                    let leftNum = array[left]
                    let rightNum = array[right]
                    if leftNum + rightNum > -target {
                        while right >= 0 && array[right] == rightNum {
                            right -= 1
                        }
                    }else if leftNum + rightNum < -target {
                        while left < array.count && array[left] == leftNum {
                            left += 1
                        }
                    }else {
                        set.insert([leftNum,rightNum,target])
                        while left < array.count && array[left] == leftNum {
                            left += 1
                        }
                        while right >= 0 && array[right] == rightNum {
                            right -= 1
                        }
                    }
                }
            }
        }
        return Array(set)
    }
    
//    1. 两数之和
//    给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 target  的那 两个 整数，并返回它们的数组下标。
//    你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。
//    你可以按任意顺序返回答案。
//    示例 1：
//    输入：nums = [2,7,11,15], target = 9
//    输出：[0,1]
//    解释：因为 nums[0] + nums[1] == 9 ，返回 [0, 1] 。
//    示例 2：
//    输入：nums = [3,2,4], target = 6
//    输出：[1,2]
//    示例 3：
//    输入：nums = [3,3], target = 6
//    输出：[0,1]
//    提示：
//    2 <= nums.length <= 104
//    -109 <= nums[i] <= 109
//    -109 <= target <= 109
//    只会存在一个有效答案
//    进阶：你可以想出一个时间复杂度小于 O(n2) 的算法吗？
//    https://leetcode-cn.com/problems/two-sum/
    class func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var array: [[Int]] = []
        for (index,item) in nums.enumerated() {
            array.append([item,index])
        }
        array.sort { (arr1, arr2) -> Bool in
            return arr1[0] < arr2[0]
        }
        
        var left = 0
        var right = array.count - 1
//        var result: [Int] = []
        while left < right {
            let leftE = array[left]
            let rightE = array[right]
            if leftE[0] + rightE[0] < target {
                while leftE[0] == array[left][0] {
                    left += 1
                }
            }else if leftE[0] + rightE[0] > target {
                while rightE[0] == array[right][0] {
                    right -= 1
                }
            }else {
//                result.append([leftNum,rightNum])
                return [leftE[1],rightE[1]]
//                while leftNum == array[left] {
//                    left += 1
//                }
//                while rightNum == array[right] {
//                    right -= 1
//                }
            }
        }

        return []
    }
    
//    3. 无重复字符的最长子串
//    给定一个字符串 s ，请你找出其中不含有重复字符的 最长子串 的长度。
//    示例 1:
//    输入: s = "abcabcbb"
//    输出: 3
//    解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
//    示例 2:
//    输入: s = "bbbbb"
//    输出: 1
//    解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
//    示例 3:
//    输入: s = "pwwkew"
//    输出: 3
//    解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
//         请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。
//    示例 4:
//    输入: s = ""
//    输出: 0
//    提示：
//    0 <= s.length <= 5 * 104
//    s 由英文字母、数字、符号和空格组成
    class func lengthOfLongestSubstring(_ s: String) -> Int {
        var window = [Character: Int]()
        var left = 0
        var right = 0
        var maxLen = 0
        let array = Array(s)
        while right < array.count {
            let ch = array[right]
            right += 1
            window[ch,default: 0] += 1
            
            while window[ch,default: 0] > 1 {
                let leftch = array[left]
                left += 1
                window[leftch,default: 0] -= 1
            }
            maxLen = max(maxLen, right - left)
        }
        
//        var window = [Character: Int]()
//        var left = 0
//        var right = 0
//        var maxLen = 0
//        let array = Array(s)
//        while right < array.count {
//            let ch = array[right]
//            if let index = window[ch] {
//                maxLen = max(maxLen, right - left)
//                while left <= index {
//                    let leftch = array[left]
//                    window[leftch] = nil
//                    left += 1
//                }
//            }
//            window[ch] = right
//            right += 1
//        }
//        maxLen = max(maxLen, right - left)
        return maxLen
    }
    
//    438. 找到字符串中所有字母异位词
//    给定两个字符串 s 和 p，找到 s 中所有 p 的 异位词 的子串，返回这些子串的起始索引。不考虑答案输出的顺序。
//    异位词 指字母相同，但排列不同的字符串。
//    示例 1:
//    输入: s = "cbaebabacd", p = "abc"
//    输出: [0,6]
//    解释:
//    起始索引等于 0 的子串是 "cba", 它是 "abc" 的异位词。
//    起始索引等于 6 的子串是 "bac", 它是 "abc" 的异位词。
//     示例 2:
//    输入: s = "abab", p = "ab"
//    输出: [0,1,2]
//    解释:
//    起始索引等于 0 的子串是 "ab", 它是 "ab" 的异位词。
//    起始索引等于 1 的子串是 "ba", 它是 "ab" 的异位词。
//    起始索引等于 2 的子串是 "ab", 它是 "ab" 的异位词。
//    提示:
//    1 <= s.length, p.length <= 3 * 104
//    s 和 p 仅包含小写字母
    class func findAnagrams(_ s: String, _ p: String) -> [Int] {
        var need = [Character: Int]()
        var window = [Character: Int]()
        for ch in p {
            need[ch,default: 0] += 1
        }
        var left = 0
        var right = 0
        var valid = 0
        let array = Array(s)
        let len = p.count
        var result = [Int]()
        while right < array.count {
            let ch = array[right]
            right += 1
            if need[ch,default: 0] > 0 {
                window[ch,default: 0] += 1
                if need[ch,default: 0] == window[ch,default: 0] {
                    valid += 1
                }
            }
            while right - left >= len {
                if valid == need.count {
                    result.append(left)
                }
                let leftch = array[left]
                left += 1
                if window[leftch,default: 0] > 0 {
                    if need[leftch,default: 0] == window[leftch,default: 0] {
                        valid -= 1
                    }
                    window[leftch,default: 0] -= 1
                }
            }
        }
        return result
    }
    
//    567. 字符串的排列
//    给你两个字符串 s1 和 s2 ，写一个函数来判断 s2 是否包含 s1 的排列。
//    换句话说，s1 的排列之一是 s2 的 子串 。
//    示例 1：
//    输入：s1 = "ab" s2 = "eidbaooo"
//    输出：true
//    解释：s2 包含 s1 的排列之一 ("ba").
//    示例 2：
//    输入：s1= "ab" s2 = "eidboaoo"
//    输出：false
//    提示：
//    1 <= s1.length, s2.length <= 104
//    s1 和 s2 仅包含小写字母
    class func checkInclusion(_ s1: String, _ s2: String) -> Bool {
        let len = s1.count
        var need = [Character : Int]()
        for ch in s1 {
            need[ch, default:0] += 1
        }
        let array = Array(s2)
        var left = 0
        var right = 0
        var window = [Character : Int]()
        var valid = 0
        while right < array.count {
            let ch = array[right]
            right += 1
            if need[ch,default: 0] > 0 {
                window[ch, default: 0] += 1
                if window[ch]! == need[ch]! {
                    valid += 1
                }
            }
            
            while right - left >= len {
                if valid == need.count {
                    return true
                }
                let leftch = array[left]
                left += 1
                if window[leftch,default: 0] > 0 {
                    if window[leftch]! == need[leftch]! {
                        valid -= 1
                    }
                    window[leftch, default: 0] -= 1
                }
            }
        }
        return false
        
//        var need = [Character : Int]()
//        for ch in s1 {
//            need[ch, default:0] += 1
//        }
//        let array = Array(s2)
//        var left = 0
//        var right = 0
//        var window = [Character : Int]()
//        var valid = 0
//        while right < array.count {
//            let ch = array[right]
//            right += 1
//            if need[ch,default: 0] > 0 {
//                print("添加\(ch)")
//                window[ch, default: 0] += 1
//                if window[ch]! == need[ch]! {
//                    valid += 1
//                }
//            }else {
//                if window.count > 0 {
//                    print("移除所有")
//                    window.removeAll()
//                    valid = 0
//                    left = right
//                    continue
//                }
//            }
//
//
//
//            var leftCh = array[left]
//            while left < right && (need[leftCh,default: 0] == 0 || window[leftCh,default: 0] > need[leftCh,default: 0]) {
//                left += 1
//                if window[leftCh,default: 0] > need[leftCh,default: 0] {
//                    print("移除\(leftCh)")
//                    window[leftCh,default: 0] -= 1
//                }else {
//                    print("跳过\(leftCh)")
//                }
//
//                if left < array.count {
//                    leftCh = array[left]
//                }else {
//                    break
//                }
//            }
//
//            if valid == need.count {
//                if right - left == s1.count {
//                    return true
//                }
//            }
//        }
//        return false
    }
    
    
//    76. 最小覆盖子串
//    给你一个字符串 s 、一个字符串 t 。返回 s 中涵盖 t 所有字符的最小子串。如果 s 中不存在涵盖 t 所有字符的子串，则返回空字符串 "" 。
//    注意：
//    对于 t 中重复字符，我们寻找的子字符串中该字符数量必须不少于 t 中该字符数量。
//    如果 s 中存在这样的子串，我们保证它是唯一的答案。
//    示例 1：
//    输入：s = "ADOBECODEBANC", t = "ABC"
//    输出："BANC"
//    示例 2：
//    输入：s = "a", t = "a"
//    输出："a"
//    示例 3:
//    输入: s = "a", t = "aa"
//    输出: ""
//    解释: t 中两个字符 'a' 均应包含在 s 的子串中，
//    因此没有符合条件的子字符串，返回空字符串。
//    提示：
//    1 <= s.length, t.length <= 105
//    s 和 t 由英文字母组成
//    进阶：你能设计一个在 o(n) 时间内解决此问题的算法吗？
    class func minWindow(_ s: String, _ t: String) -> String {
        let ss = Array(s)
        let tt = Array(t)
        if ss.count < tt.count {
            return ""
        }
        
        
        var need = [Character : Int]()
        for ch in tt {
            let count = need[ch,default: 0]
            need[ch] = count + 1
        }
        var hasCount = 0
        var window = [Character : Int]()
        var left = 0
        var right = 0
        var minLeft = 0
        var minRight = 0
        
        while right < ss.count {
            let ch = ss[right]
            right += 1
            
            if window[ch,default: 0] < need[ch,default: 0] {
                hasCount += 1
            }
            window[ch,default: 0] += 1
            
            var leftch = ss[left]
            while window[leftch,default: 0] > need[leftch,default: 0] {
                window[leftch,default: 0] -= 1
                left += 1
                if left < ss.count {
                    leftch = ss[left]
                }else {
                    break
                }
            }
            if hasCount == tt.count && (minRight - minLeft >= right - left || minRight - minLeft < tt.count){
                minLeft = left
                minRight = right
            }
        }
        
        if hasCount == t.count {
            return String(ss[minLeft..<minRight])
        }
        return ""
    }
    
    
//    5. 最长回文子串
//    给你一个字符串 s，找到 s 中最长的回文子串。
//    示例 1：
//    输入：s = "babad"
//    输出："bab"
//    解释："aba" 同样是符合题意的答案。
//    示例 2：
//    输入：s = "cbbd"
//    输出："bb"
//    示例 3：
//    输入：s = "a"
//    输出："a"
//    示例 4：
//    输入：s = "ac"
//    输出："a"
//    提示：
//    1 <= s.length <= 1000
//    s 仅由数字和英文字母（大写和/或小写）组成
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/longest-palindromic-substring
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    class func longestPalindrome(_ s: String) -> String {
        let array = Array(s);
        var i = 0
        var left = 0
        var right = 0
        while i < array.count {
            let tuple1 = checkLongestPalindrome(array, i - 1, i)
            if tuple1.1 - tuple1.0 > (right - left) {
                left = tuple1.0
                right = tuple1.1
            }
            let tuple2 = checkLongestPalindrome(array, i, i)
            if tuple2.1 - tuple2.0 > (right - left) {
                left = tuple2.0
                right = tuple2.1
            }
            i += 1
        }
        return String(array[left...right])
    }
    class func checkLongestPalindrome(_ array: Array<Character>,_ left: Int,_ right: Int) -> (Int, Int) {
        if left < 0 {
            return (right, right)
        }
        if right == array.count {
            return (left, left)
        }
        var l = left
        var r = right
        while l >= 0 && r < array.count && array[l] == array[r] {
            l -= 1
            r += 1
        }
        return (l + 1, r - 1)
    }
}
