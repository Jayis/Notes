# Grokking Data Structures and Algorithms for Coding Interviews
https://www.designgurus.io/course/grokking-data-structures-for-coding-interviews

---
## Array
### Static vs. Dynamic Sized Arrays
Static-sized Arrays: 
- fixed size, determined at compile time
- allocated on the stack, making allocation and deallocation fast
- stored contiguously in memory, thus fast accessing

Dynamic-sized Arrays:
- allocated on the heap, memory management (allocation and deallocation) is more complex and slightly slower

### Being Mindful About Arrays in Coding Interviews
1. Validating Assumptions:
    - Duplicates  
        Always clarify if duplicate values are allowed. Understand and communicate how duplicates might affect your approach.
    - Sorted/Unsorted  
        Check whether the array is sorted or not, as certain algorithms (like binary search) require sorted arrays.
    - Zeros and Negatives  
        Always check and clarify how to handle zeros and negative numbers in array problems. This is especially crucial in problems related to product or sum.
2. Boundary Conditions:
    - Index Out of Bounds  
        Always ensure that your code never tries to access an index outside of the array’s bounds. Use condition checks to prevent this common error.
    - Negative Indices  
        In certain languages like Python, negative indices access elements from the end of the array. Be cautious and deliberate in your use of them.
3. Efficiency Concerns:
    - Slicing and Concatenating  
        Remember slicing and concatenating can take  time. Be careful with these operations as they introduce significant time complexity into your solution.
    - In-place vs. Extra Space  
        Consider whether creating a new array is necessary or if you can manipulate the existing array in place to save space.
6. Testing:
    - Corner Cases  
        Test your solutions with edge cases (e.g., empty arrays, single-element arrays, arrays with all identical elements) to ensure robustness.
    - Various Inputs  
        Test with both typical and edge cases to ensure your solution handles all possible scenarios adeptly.
8. Modification During Iteration:  
    Be cautious when modifying an array as you iterate through it, as this can introduce bugs or unintended behaviors. Sometimes iterating backwards or using a separate array to store modifications can circumvent these issues.
10. Partial Results:  
    - Intermediate Variables  
        Consider whether storing intermediate results (e.g., prefix sums or suffix products) might optimize repeated calculations.
    - Multiple Passes  
        Weigh the pros and cons of making multiple passes through the array if it simplifies and optimizes the overall algorithm.
11. Parallel and Reverse Iteration:  
    Remember that sometimes iterating through an array from the end or through two arrays in parallel can be the key to an optimal solution.

## Stack, Queue
### Being Mindful in Coding Interviews
- Check underflow and overflow conditions
  - underflow:  
    check if it's empty before remove an item
  - overflow:  
    check if it's full before adding an item

## Linked List
### Small trick
#### Insert a Dummy Node to the Beginning of the List
a lot of the operation happens at the head can be easily handled as a normal operation, e.g. first insertion:
1. init **dummy**, set **dummy** as **tail**
    ```
    dummy -> null
    ^tail
    ```
2. insert
    ```
    dummy -> X -> null
             ^tail
    ```
3. return **dummy.next** as the head of newly created list

## Binary Search Tree
###  Self-balancing BSTs
#### AVL Tree
For every node, height difference of left subtree and right subtree should be no more than 1
#### Splay Tree
To reduce the search time for the node, Splay the node to root after every operation.

## HashMap
### Intro
After reviewing the implement detail of a (simple) hashmap, I found several things to be noticed.

Let's first remind ourselves of how hashmap works
1. use hash function to map input to a hashed index
2. locate in pre-allocated table with the hased index
3. deal with collision

#### Pre-allocated table
Even though we say that the space complexity is O(K), which K is the number of unique elemnets in input.
But the table is actually pre-allocated, either a "array" or "array of list", there's a constant space usage for O(1)-time operations.

#### Collision
##### Open Addressing (Closed Hashing):
Open addressing techniques resolve hash collisions by probing for the next available slot within the hash table itself. This approach is called open addressing since it opens up the entire hash table for finding an empty slot during insertion.  
It is also known as closed hashing because the insertion is restricted to existing slots within the table without using any external data structures.
##### Separate Chaining (Open Hashing):
Separate chaining offers a rather simpler chaining mechanism to resolve collisions. Each slot in the hash table points to a separate data structure, such as a linked-list. This linked-list or chain stores multiple elements that share the same hash index. When a collision occurs, new elements are simply appended to the existing list in the corresponding slot.  
Separate chaining is an "open hashing" technique because the hash table is "open" to accommodate multiple elements within a single bucket (usually using a chain) to handle collisions.
##### Perks & Downside of Separate Chaining
- Perks
  - Simple Implementation
  - Dynamic Memory Usage
- Downsides
  - Increased Memory Overhead
    - Cache Inefficiency
    - External Fragmentation

### Being Mindful in Interview
#### Space complexity
Be aware of the input space.  
The space complexity is O(input space) rather then O(# of input chars).  

For example, take a lower-case string and record the frequencies of each character.  
The space complexity will not be O(N) but O(26), which equals to O(1).

## Heap
### Time Complexity of Heapify() - O(N)
Here we define heapify as "create a heap from an complete binary tree (or simply an array)".

As naive thinking, we would use `N` insert operation to achieve building a new heap from `N` elements.  
That would take us `O(N*logN)` to build the heap.

So how does heapify make it in `O(N)` time?  
One key difference would be that, "N times insertion" will maintain a legal heap after each insertion, while heapify does not maintain a legal heap after each step.

#### Algorithm
The idea would be
- Traverse the heap, bottom-up, for each node and its corresponding subtree
  - heapify the subtree
 
If the left-subtree and the right-subtree of the subtree are both legal heaps, then heapify of the subtree takes only `O(height of the subtree)` time.  
Because, we only need to heapify the root node. In the worst case, we'll need to swap it from root to leave.  

#### Time Complexity
So the time complexity can be calculated as following:
1. summing all nodes' time complexity, root to leave
    ```
    summation of (# of node of layer) * (# of swaps needed)
    = 1 * logN + 2 * (logN - 1) + 4 * (logN - 2) + ... + 2^(logN - 1) * 1 + 2^logN * 0
    ```
2. rewrite with regards to k
    ```
    summation(2^k * (logN - k)), k = 0 ~ logN  
    = summation(2^k * logN) - summation(2^k * k), k = 0 ~ logN  
    = logN * summation(2^k) - summation(2^k * k), k = 0 ~ logN  
    ```

    And brings in the formulas.  
    > for summation(2^k) see [S(x^k)](Appendix.md#summationxk)  
    > for summation(2^k * k) see [S(k*x^k)](Appendix.md#summationk--xk)
    ```
    = logN * (2^(logN+1) - 1) - 2 * ( (logN+1)*2^logN - 2^(logN+1) + 1)
    = logN * 2^(logN+1) - logN - (logN+1)*2^(logN+1) + 2^(logN+2) - 2
    = 2^(logN+2) + 2^(logN+1) - logN - 2
    = 4N + 2N - logN - 2
    = 6N - logN - 2
    ```

    And `6N - logN - 2` is O(N).
