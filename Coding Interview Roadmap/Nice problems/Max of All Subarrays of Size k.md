# Max of All Subarrays of Size k
## Problem Statement
Given an integer array and an integer `k`, design an algorithm to find the maximum for each and every contiguous subarray of size `k`.

## Examples 
```
Input: array = [1, 2, 3, 1, 4, 5, 2, 3, 6], k = 3
Output: [3, 3, 4, 5, 5, 5, 6]
Description: Here, subarray 1,2,3 has maximum 3, 2,3,1 has maximum 3, 3,1,4 has maximum 4, 1,4,5 has maximum 5, 4,5,2 has maximum 5, 5,2,3 has maximum 5, and 2,3,6 has maximum 6.
```
```
Input: array = [8, 5, 10, 7, 9, 4, 15, 12, 90, 13], k = 4
Output: [10, 10, 10, 15, 15, 90, 90]
Description: Here, the maximum of each subarray of size 4 are 10, 10, 10, 15, 15, 90, 90 respectively.
```
```
Input: array = [1,2,3,4,5], k = 3
Output: [3, 4, 5]
Description: Here, the maximum of each subarray of size 3 are 3, 4, 5 respectively.
```

## Constraints
```
1 <= arr.length <= 105 -104 <= arr[i] <= 104 1 <= k <= arr.length
```

## My Solution
```python
from collections import deque

class Solution:
    def printMax(self, arr, k):
        """
        using a queue to record possible maximums when we iterate through arr

        a possible maximum means
        - maximum
        - not maximum, but newer
        so when an element in the queue that is smaller and older than current element,
        it should be dropped

        so when we iterate through arr, for each element we encountered
        - pop element in queue from rear, if element is smaller than current arr[i]
        - push arr[i] into queue

        start to record maximums from kth element, which is the front element of the queue

        and since we only want to know the maximum within k elements
        - pop element in queue from front, if the element already exceed current range of k
        - for that we need to record element index

        [2 5 3 1 6], k = 3

        q = []

        i = 0, 
        q = [2]

        i = 1,
        q = [5]

        i = 2,
        q = [5, 3]
        max = [5]

        i = 3,
        q = [5, 3, 1]
        max = [5, 5]

        i = 4
        q = [6]
        max = [5, 5, 6]
        """
        result = []
        # ToDo: Write Your Code Here.
        possible_maximums = deque()

        for i in range(len(arr)):
            if len(possible_maximums) > 0 and possible_maximums[0][1] == i - k:
                possible_maximums.popleft()
            while len(possible_maximums) > 0 and possible_maximums[-1][0] < arr[i]:
                possible_maximums.pop()
            possible_maximums.append((arr[i], i))

            if i >= k - 1:
                result.append(possible_maximums[0][0])

        """
        [2 5 3 1 6], k = 3

        i = 0
        possible_maximums = [(2, 0)]

        i = 1
        possible_maximums = [(5, 1)]

        i = 2
        possible_maximums = [(5, 1), (3, 2)]
        result = [5]

        i = 3
        possible_maximums = [(5, 1), (3, 2), (1, 3)]
        result = [5, 5]

        i = 4
        possible_maximums = [(6, 4)]
        result = [5, 5, 6]

        """

        return result

```