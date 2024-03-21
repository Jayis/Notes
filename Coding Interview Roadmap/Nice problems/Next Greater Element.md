# Next Greater Element
## Problem Statement
Given an array, print the Next Greater Element (NGE) for every element.

The Next Greater Element for an element `x` is the first greater element on the right side of `x` in the array.

Elements for which no greater element exist, consider the next greater element as -1.

## Examples
### Examples 1
```
 Input: [4, 5, 2, 25]
 Output: [5, 25, 25, -1]
 Explanation: The NGE for 4 is 5, 5 is 25, 2 is 25, and there is no NGE for 25.
```
### Examples 2
```
 Input: [13, 7, 6, 12]
 Output: [-1, 12, 12, -1]
```
### Examples 3
```
 Input: [1, 2, 3, 4, 5]
 Output: [2, 3, 4, 5, -1]
```

## My solution
```python
class Solution:
    def nextLargerElement(self, arr):
        """
        [4, 2, 3, 5]
        
        st = []
        [-1, -1, -1, -1]

        i = 0, ele = 4
        st = [4]

        i = 1, ele = 2
        st = [4, 2]

        i = 2, ele = 3
        st = [4, 3]
        nge = [-1, 3, -1, -1]

        i = 3, ele = 5
        st = [5]
        nge = [5, 3, 5, -1]

        1. init a stack, init a array to record NGEs
        2. traverse through arr, get arr[i], 
        3. compare with stack.top()
            - if len(stack) > 0 and arr[i] > stack.top(),
                - we found the NGE of stack.top(), record it (for that we need index of stack.top())
                - record the NGE of stack.top(), and stack.pop()
                - after pop(), go back to 3.
            - else
                push arr[i] to stack
                back to 2 for next ele
        3. after all element in arr is traversed
            finished


        [4, 2, 3, 5]

        idx = 0, ele = 4
        stack = [(4, 0)]

        idx = 1, ele = 2
        stack = [(4, 0), (2, 1)]

        idx = 2, ele = 3
        stack = [(4, 0), (3, 2)]
        nge = [-1, 3, -1, -1]

        idx = 3, ele = 5
        stack = [(5, 3)]
        nge = [5, 3, 5, -1]

        """
        res = [-1]*len(arr)
        # ToDo: Write Your Code Here.
        stack = []
        for idx, ele in enumerate(arr):
            while len(stack) > 0 and ele > stack[-1][0]:
                stack_top_ele, stack_top_idx = stack.pop()
                res[stack_top_idx] = ele

            stack.append((ele, idx))

        return res
```
