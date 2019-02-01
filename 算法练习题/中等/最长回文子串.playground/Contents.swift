import UIKit

// 题目：最长回文子串
// 难度：中等

// 给定一个字符串 s，找到 s 中最长的回文子串。你可以假设 s 的最大长度为 1000。

// 示例 1：
// 输入: "babad"
// 输出: "bab"
// 注意: "aba" 也是一个有效答案。

// 示例 2：
// 输入: "cbbd"
// 输出: "bb"

func longestPalindrome(_ s: String) -> String {
    guard s != "" else { // 注意空字符串的处理
        return s
    }
    var start = 0, end = 0
    for i in 0..<s.count {
        let len1 = expandAroundCenter(s, i, i)
        let len2 = expandAroundCenter(s, i, i + 1)
        let len = max(len1, len2)
        if len > end - start {
            start = i - (len - 1) / 2
            end = i + len / 2
        }
    }
    let length = end + 1 - start
    return s.subString(start: start, length: length)
}

func expandAroundCenter(_ s: String, _ left: Int, _ right: Int) -> Int {
    var L = left, R = right
    while L >= 0 && R < s.count && s.charAt(at: L) == s.charAt(at: R) { // 这里在超长字符下会非常耗时
        L -= 1
        R += 1
    }
    return R - L - 1
}

extension String {
    // charAt(at:) returns a character at an integer (zero-based) position.
    // example:
    // let str = "hello"
    // var second = str.charAt(at: 1)
    //  -> "e"
    func charAt(at: Int) -> Character {
        let charIndex = self.index(self.startIndex, offsetBy: at)
        return self[charIndex]
    }
    
    // 根据开始位置和长度截取字符串
    func subString(start:Int, length:Int = -1) -> String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy: start)
        let en = self.index(st, offsetBy: len)
        return String(self[st ..< en])
    }
}

// 分析
// 注意理解什么是回文，回文是一个正读和反读都相同的字符串，例如，“aba” 是回文，而  “abc”  不是。
// 并且回文中心的两侧互为镜像。因此，回文可以从它的中心展开，并且只有 2n−1 个这样的中心。
// 为什么会是 2n−1 个，而不是 n 个中心？原因在于所含字母数为偶数的回文的中心可以处于两字母之间（例如 “abba”  的中心在两个 ‘b’ 之间）。
// 时间复杂度：O(n^2)， 由于围绕中心来扩展回文会耗去  O(n) 的时间，所以总的复杂度为 O(n^2)。

// 参考 https://zhuanlan.zhihu.com/p/38251499
// https://www.zhihu.com/question/40965749
// https://segmentfault.com/a/1190000008484167

// 验证
longestPalindrome("abcbf")


// Manacher算法，复杂度O(n)
// 参考 https://articles.leetcode.com/longest-palindromic-substring-part-ii/
// https://www.felix021.com/blog/read.php?2040

func preProcess(_ s: String) -> String {
    let n = s.count
    guard n > 0 else {
        return "^$"
    }
    var ret = "^"
    for i in 0..<n {
        ret += "#" + s.subString(start: i, length: 1)
    }
    ret += "#$"
    return ret
}

func longestPalindrome1(_ s: String) -> String {
    let T = preProcess(s)
    let n = T.count
    var P = Array(repeating: 0, count: n)
    var C = 0, R = 0
    for i in 1..<n-1 {
        let i_mirror = 2 * C - i // 等价于 i' = C - (i-C)
        P[i] = (R > i) ? min(R-i, P[i_mirror]) : 0
        // 尝试扩大以 i 为中心的回文数据
        while T.charAt(at: i + 1 + P[i]) == T.charAt(at: i - 1 - P[i]) {
            P[i] += 1
        }
        // 如果以 i 为中心的回文扩展到 R, 根据扩展的回文调整中心
        if i + P[i] > R {
            C = i
            R = i + P[i]
        }
    }
    
    // 找到 P 中的最大元素
    var maxLen = 0
    var centerIndex = 0
    for i in 1..<n - 1 {
        if P[i] > maxLen {
            maxLen = P[i]
            centerIndex = i
        }
    }
    return s.subString(start: (centerIndex - 1 - maxLen)/2, length: maxLen)
}

// 验证
longestPalindrome1("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabcaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
