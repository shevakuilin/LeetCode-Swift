import UIKit

// 题目：两数相加

// 给出两个 非空 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储 一位 数字。
// 如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。
// 您可以假设除了数字 0 之外，这两个数都不会以 0 开头。

// 示例：
// 输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)
// 输出：7 -> 0 -> 8
// 原因：342 + 465 = 807

class ListNode { // 链表节点
    var val: Int
    var next: ListNode?
    
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class List { // 链表
    var head: ListNode?
    var tail: ListNode?
    
    // 尾插法
    func appendToTail(_ val: Int) {
        if tail == nil {
            tail = ListNode(val)
            head = tail
        } else {
            tail?.next = ListNode(val)
            tail = tail?.next
        }
    }
    
//    func initListNodeFromTail2(_ array: [Int]) -> ListNode {
//        var headNode:ListNode?
//        var tail:ListNode?
//        for data in array {
//            let tempNode = ListNode(data)
//            tempNode.val = data
//            if tail == nil {
//                tail = tempNode
//                headNode = tail
//            } else {
//                tail?.next = tempNode
//                tail = tempNode
//            }
//        }
//        return headNode!
//    }
    
    // 头插法
    func appendToHead(_ val: Int) {
        if head == nil {
            head = ListNode(val)
            tail = head
        } else {
            let temp = ListNode(val)
            temp.next = head
            head = temp
        }
    }
    
//    func initListNodeFromHead2(_ array: [Int]) -> ListNode {
//        var headNode: ListNode?
//        for data in array {
//            let tempNode = ListNode(data)
//            tempNode.val = data
//            if headNode == nil {
//                headNode = tempNode
//            } else {
//                tempNode.next = headNode
//                headNode = tempNode
//            }
//        }
//        return headNode!
//    }
//
//    // 打印
//    func printList(_ list: inout ListNode) {
//        var tempList:ListNode? = list
//        while tempList != nil {
//            print("\(tempList!.val)")
//            if tempList!.next == nil {
//                break
//            }
//            tempList = tempList!.next!
//        }
//    }
}

// 参考: https://www.jianshu.com/p/cf962aeff643
// https://blog.csdn.net/biezhihua/article/details/79437867

// 核心解析：
// 1. 链表对应结点相加时增加前一个结点的进位，并保存下一个结点的进位；除法得进位，模得结果。
// 2. 两个链表长度不一致时，要处理较长链表剩余的高位和进位计算的值；
// 3. 如果最高位计算时还产生进位，则还需要添加一个额外结点。

// 解法
func addTwoNumbers(list1: ListNode?, list2: ListNode?) -> ListNode? {
    var tmp: ListNode?
    var result: ListNode?
    var l1 = list1
    var l2 = list2
    
    var carry: Int = 0
    while l1 != nil || l2 != nil || carry != 0 {
        let sum: Int = (l1 == nil ? 0 : (l1?.val)!) + (l2 == nil ? 0 : (l2?.val)!) + carry
        carry = sum/10
        
        let node = ListNode(sum % 10)
        if tmp == nil {
            tmp = node
            result = tmp!
        } else {
            tmp?.next = node
            tmp = tmp?.next
        }
        
        l1 = l1 == nil ? nil : l1?.next
        l2 = l2 == nil ? nil : l2?.next
    }
    
    return result
}

// 验证
// 输入：[2,4,3]，[5,6,4]
// 输出: [7,0,8]
// 预期结果：[7,0,8]
// https://leetcode-cn.com/problems/add-two-numbers/

// 备注参考
// swift 实现单链表创建、插入、删除 https://www.jianshu.com/p/68de9b3daa13
// Swift 链表 的制作 使用 https://blog.csdn.net/sunzhenglin2016/article/details/52690860

// 本题目的问题在于验证步骤，如何在Swift中以链表的形式进行验证该方法是否可以通过，leetcode-cn上验证可以通过，但是省去了验证输入的步骤，需要重新补上
