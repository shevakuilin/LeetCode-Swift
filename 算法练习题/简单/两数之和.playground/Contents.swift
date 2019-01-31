import UIKit

// 题目：两数之和
// 难度：简单

// 给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。
// 你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。

// 示例:
// 给定 nums = [2, 7, 11, 15], target = 9
// 因为 nums[0] + nums[1] = 2 + 7 = 9
// 所以返回 [0, 1]

func queryIndex(nums: [Int], target: Int) -> [Int]? {
    var dic = [Int: Int]()
    for i in 0..<nums.count {
        let complement = target - nums[i]
        if dic.keys.contains(complement) {
            return [dic[complement]!, i]
        }
        dic[nums[i]] = i
    }
    return nil
}

// 参考： https://zhuanlan.zhihu.com/p/38094061
// 解法：一遍哈希表：
// 事实证明，我们可以一次完成。在进行迭代并将元素插入到表中的同时，我们还会回过头来检查表中是否已经存在当前元素所对应的目标元素。如果它存在，那我们已经找到了对应解，并立即将其返回。

// 复杂度分析：
// 时间复杂度：O(n)，我们只遍历了包含有 n 个元素的列表一次。在表中进行的每次查找只花费  O(1)  的时间。
// 空间复杂度：O(n)，所需的额外空间取决于哈希表中存储的元素数量，该表最多需要存储  n 个元素。

// 验证
let scanArr = [2, 7, 11, 15]
let result = queryIndex(nums: scanArr, target: 9)

// 改进解法
// 返回参数改进，数组 -> 元组
// 改进内容，空间复杂读降低，省去一个数组的内存空间分配 [实际上只是换种参数传递]
func queryIndex1(nums: [Int], target: Int) -> (Int?, Int)? {
    var dic = [Int: Int]()
    for i in 0..<nums.count {
        let complement = target - nums[i]
        if dic.keys.contains(complement) {
            return (dic[complement], i)
        }
        dic[nums[i]] = i
    }
    return nil
}

// 验证
let result1 = queryIndex1(nums: scanArr, target: 9)

