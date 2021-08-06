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
        print(minWindow("a", "b"))
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
