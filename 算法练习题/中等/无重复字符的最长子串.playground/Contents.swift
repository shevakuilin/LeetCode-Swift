import UIKit

// 题目：无重复字符的最长子串
// 难度：中等

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
    for (index, char) in s.enumerated() { // 使用 enumerated(）时需要注意，下面会加以说明
        if usedChar.keys.contains(char) && start <= usedChar[char]! {
            start = usedChar[char]! + 1
        } else {
            maxLength = max(maxLength, index - start + 1)
        }
        usedChar[char] = index
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

// 关于 enumerated()
// 这个函数会返回一个新的序列，包含了初始序列里的所有元素，以及与元素相对应的编号。
// 大家都认为它返回的是每一个元素和元素的索引值，但实际上并不是这样的。因为它可以适用于所有序列，而序列是不能保证有索引的，由此可知它返回的并不是索引值。
// 上面的 index 总是一个整型，从 0 开始，间隔为 1，跟每一个元素逐一对应。对于 Array，这刚好跟它的索引值完全一致，但除此之外的其他所有类型，都不会有这种巧合发生。
// 所以，仅推荐在 Array 中或者想把它作为一个数字去使用。
// 当然，针对 String 的直接遍历可以看做是一个数组遍历操作，所以这里使用没有问题。

// 不使用 enumerated() 的实现方式 [原理和enumerated()是相同的]：
func otherFunc(_ s: String) -> Int {
    var start: Int = 0
    var maxLength: Int = 0
    var usedChar: [Character:Int] = [:]
    var index: Int = 0
    for char in s { // 使用 enumerated(）时需要注意，下面会加以说明
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

// 验证
otherFunc("pwwkew")


