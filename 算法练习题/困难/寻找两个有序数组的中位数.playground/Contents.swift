import UIKit

// 题目：寻找两个有序数组的中位数
// 难度：困难

// 给定两个大小为 m 和 n 的有序数组 nums1 和 nums2。
// 请你找出这两个有序数组的中位数，并且要求算法的时间复杂度为 O(log(m + n))。
// 你可以假设 nums1 和 nums2 不会同时为空。

// 示例 1:
// nums1 = [1, 3]
// nums2 = [2]
// 则中位数是 2.0

// 示例 2:
// nums1 = [1, 2]
// nums2 = [3, 4]
// 则中位数是 (2 + 3)/2 = 2.5


func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    let mergeNums = nums1 + nums2
    let sortedNums = mergeNums.sorted()
    var median: Double = 0.0
    if sortedNums.count % 2 == 0 {
        let lastIndex = sortedNums.count / 2 - 1
        let nextIndex = lastIndex + 1
        median = Double(sortedNums[lastIndex] + sortedNums[nextIndex]) / Double(2)
    } else {
        let medianIndex = sortedNums.count / 2
        median = Double(sortedNums[medianIndex])
    }
    return median
}

// 思路，将两个数组的内容合并到一个数组中，然后进行升序排列，合并后的数组长度能被2整除就是中间两个数/2，不能被2整除就是中间一位数的值，如何获取中间的位数的下标，就是合并后的数组长度/2
// 如果能被2整除，那么中位数就是（中位数下标-1）+ （中位数下标+1）/ 2 ，也就是需要获得中位数值的前一个和后一个数
// 不能被2整除的更简单，直接数组长度/2即可获取到中卫数的index

// 验证

let result = findMedianSortedArrays([1, 2], [3, 4])

// 当然，这看上去很简单，但是题目要求将时间复杂度降为 O(log(m + n))，上面的解法仅仅能达到 O(nlogn)
// 需要注意的是这道题的题目描述上的重点：给定的m和n是两个有序数组，这是很重要的前提条件，否则复杂度降为O(log(m + n))是根本无法完成的，也就是说如果不是有序的，上面的这个答案就是最优解了
// 第二个要点是这个复杂度，既然出现了log，那么就肯定是和分治法相关的了


// 参考资料：
// https://zhuanlan.zhihu.com/p/39129143
// https://www.cnblogs.com/zichi/p/leetcode-4-median-of-two-sorted-arrays.html
// https://blog.csdn.net/qq_41014682/article/details/79812181
// https://blog.csdn.net/qq_14821023/article/details/50806849

// 解法二：采用中位数划分的方式，时间复杂度 O(log(m + n))
// 首先，查找的区间是 [0,m]。 而该区间的长度在每次循环之后都会减少为原来的一半。
// 所以，我们只需要执行  \log(m) 次循环。由于我们在每次循环中进行常量次数的操作，所以时间复杂度为 O(\log(m))。
// 由于  m\leq n，所以时间复杂度是 O(\log(\min(m,n))) 。

func otherMethod(_ nums1: [Int], _ nums2: [Int]) -> Double {
    var A = nums1
    var B = nums2
    var m = A.count
    var n = B.count
    if m > n { // m 小于等于 n
        let temp = A
        A = B
        B = temp
        let tmp = m
        m = n
        n = tmp
    }
    var iMin = 0, iMax = m, halfLen = (m + n + 1) / 2
    while iMin <= iMax {
        let i = (iMin + iMax) / 2
        let j = halfLen - i
        if i < iMax && B[j - 1] > A[i] {
            iMin = i + 1 // i 太小
        } else if i > iMin && A[i - 1] > B[j] {
            iMax = i - 1 // i 太大
        } else { // i 正好合适
            var maxLeft = 0
            if i == 0 {
                maxLeft = B[j - 1]
            } else if j == 0 {
                maxLeft = A[i - 1]
            } else {
                maxLeft = max(A[i - 1], B[j - 1])
            }
            if (m + n) % 2 == 1 { // 如果不能被整除
                return Double(maxLeft)
            }
            
            var minRight = 0
            if i == m {
                minRight = B[j]
            } else if j == n {
                minRight = A[i]
            } else {
                minRight = min(B[j], A[i])
            }
            return Double(maxLeft + minRight) / 2.0
        }
    }
    
    return 0.0
}

// 验证
otherMethod([1, 2], [3, 4])
