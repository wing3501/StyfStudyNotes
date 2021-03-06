//
//  双指针.swift
//  StyfStudyNotes
//
//  Created by styf on 2021/2/9.
//

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
        print(longestPalindrome("babad"))//"bab"
        print(longestPalindrome("cbbd"))//"bb"
        print(longestPalindrome("a"))//"a"
        print(longestPalindrome("ac"))//"a"
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
