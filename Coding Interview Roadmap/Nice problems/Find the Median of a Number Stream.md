# Find the Median of a Number Stream
## Problem Statement
Design a class to calculate the median of a number stream.

The class should have the following two methods:
- `insertNum(int num)`: stores the number in the class
- `findMedian()`: returns the median of all numbers inserted in the class

If the count of numbers inserted in the class is even, the median will be the average of the middle two numbers.

## Example
```
1. insertNum(3)
2. insertNum(1)
3. findMedian() -> output: 2
4. insertNum(5)
5. findMedian() -> output: 3
6. insertNum(4)
7. findMedian() -> output: 3.5
```

## Constraints
- -10^5 <= num <= 10^5
- There will be at least one element in the data structure before calling `findMedian`.
- At most 5 * 10^4 calls will be made to `insertNum` and `findMedian`.

## My Solution
```python
from heapq import *

"""
if we maintain a sorted array
- insertNum:
  - search for the position to insert
    - binary search: O(logn)
    - maintain array: O(n)
- findMedian:
  - direct access by index: O(1)

if we maintain a binary search tree
- insertNum:
  - search for the position to insert
    - binary search: O(logn)
    - maintain tree: O(1)
- findMedian:
  - remember where is the median, update it after every insert
    - find next element in BST: O(logn)

if we maintain a min heap and a max heap, and make len(max_heap)-len(min_heap)=0 or 1
- insertNum:
  - if num > median:
    insert num to min_heap
  - else:
    insert num to max_heap
  - balance the size of the heaps
    - while len(min_heap) > len(max_heap):
      pop from min_heap, push to max_heap
    - while len(max_heap) - len(min_heap) > 1:
      pop from max_hep, push to min_heap

- findMedian:
  - check element: O(1)

1 3 5 7, ans = 1, 2, 3, 4

max_heap = [3, 1]
min_heap = [5, 7]

insertNum(1)
findMedian()->1
insertNum(3)
findMedian()->2
insertNum(5)
findMedian()->3
insertNum(7)


"""

class Solution: 

  def __init__(self):
    self = self
    # TODO: Write your code here
    self.max_heap = []
    self.min_heap = []

  def insertNum(self, num):
    # TODO: Write your code here
    if num > self.findMedian():
      heappush(self.min_heap, num)
    else:
      heappush(self.max_heap, -num)

    while len(self.min_heap) > len(self.max_heap):
      heappush(self.max_heap, -heappop(self.min_heap))

    while len(self.max_heap) - len(self.min_heap) > 1:
      heappush(self.min_heap, -heappop(self.max_heap))

    return

  def findMedian(self):
    # TODO: Write your code here
    if len(self.max_heap) == 0:
      return 0

    if len(self.min_heap) < len(self.max_heap):
      return float(-self.max_heap[0])
    else:
      return (self.min_heap[0] - self.max_heap[0])/2

"""
5 3 1

max_heap = [-3, -1]
min_heap = [5]

push 5
push 3
"""
```
