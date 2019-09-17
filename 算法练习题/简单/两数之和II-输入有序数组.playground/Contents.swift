import UIKit

// 题目:
// 给定一个已按照升序排列 的有序数组，找到两个数使得它们相加之和等于目标数。
// 函数应该返回这两个下标值 index1 和 index2，其中 index1 必须小于 index2。

// 说明:
// 1. 返回的下标值（index1 和 index2）不是从零开始的。
// 2. 你可以假设每个输入只对应唯一的答案，而且你不可以重复使用相同的元素。

// 示例:
// 输入: numbers = [2, 7, 11, 15], target = 9
// 输出: [1,2]
// 解释: 2 与 7 之和等于目标数 9 。因此 index1 = 1, index2 = 2 。

// 解1，二分法：

class Solution {
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        /// 输入数组为空，返回空数组
        guard numbers.count > 0 else { return [] }
        /// 二分查找
//        let len = numbers.count
//        for left in 0..<numbers.count - 1 {
//            let right = binarySearch(nums: numbers, left: left + 1, right: len - 1, target: target - numbers[left])
//            if right != -1 {
//                return [left + 1, right + 1]
//            }
//        }
        
        /// 双指针
        var low = 0
        var high = numbers.count - 1
        while low < high {
            let sum = numbers[low] + numbers[high]
            if sum == target {
                return [low + 1, high + 1]
            } else if sum < target {
                low = low + 1
            } else {
                high = high - 1
            }
        }
        
        return [-1, -1]
    }
    
    /// 二分查找
    func binarySearch(nums: [Int], left: Int, right: Int, target: Int) -> Int {
        var theLeft = left
        var theRight = right
        while theLeft < theRight {
            /// 向右位移一位
            let mid = (theLeft + theRight) >> 1
            if nums[mid] < target {
                theLeft = mid + 1
            } else {
                theRight = mid
            }
        }
        if nums[theLeft] == target {
            return theLeft
        }
        return -1
    }
}


// 参考：
// 二分法：https://segmentfault.com/a/1190000008699980
