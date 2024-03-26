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
