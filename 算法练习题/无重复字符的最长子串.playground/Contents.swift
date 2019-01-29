import UIKit

// 题目：无重复字符的最长子串

// 给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度。

// 示例 1:
// 输入: "abcabcbb"
// 输出: 3
// 解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。

// 示例 2:
// 输入: "bbbbb"
// 输出: 1
// 解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。

// 示例 3:
// 输入: "pwwkew"
// 输出: 3
// 解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
// 请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。

func lengthOfLongestSubstring(_ s: String) -> Int {
    var start: Int = 0
    var maxLength: Int = 0
    var usedChar: [Character:Int] = [:]
    var index: Int = 0

    for char in s {
        if usedChar.keys.contains(char) && start <= usedChar[char]! {
            start = usedChar[char]! + 1
        } else {
            maxLength = max(maxLength, index - start + 1)
        }
        usedChar[char] = index
        index += 1
    }
    return maxLength
}

// 参考：https://blog.csdn.net/qq_17550379/article/details/80547777
// https://zhuanlan.zhihu.com/p/35364681
// 解析
// 重点是 「最长」，这一点一定要注意，所以光筛选出不含重复的子串长度是没有用的，还要找出最长的子串
// 也就是说，如果筛选出第一个不含重复的子串的长度后，如果之后没有（再找到重复的字符）更长的就不需要再更新这个长度了，如果有更长的就替换当前的长度即可
// 可以利用之前「两数之和」中使用hash表的思想
// 时间复杂度是O(n)，空间复杂度也是O(n)

// 验证
lengthOfLongestSubstring("pwwkew")
