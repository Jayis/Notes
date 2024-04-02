# Longest Substring Without Repeating Characters
## Problem Statement
Given a string, identify the length of its longest segment that contains distinct characters. In other words, find the maximum length of a substring that has no repeating characters.

## Examples
```
Input: "abcdaef"
Expected Output: 6
Justification: The longest segment with distinct characters is "bcdaef", which has a length of 6.
```
```
Input: "aaaaa"
Expected Output: 1
Justification: The entire string consists of the same character. Thus, the longest segment with unique characters is just "a", with a length of 1.
```
```
Input: "abrkaabcdefghijjxxx"
Expected Output: 10
Justification: The longest segment with distinct characters is "abcdefghij", which has a length of 10.
```

## Constraints
```
0 <= s.length <= 5 * 104
s consists of English letters, digits, symbols and spaces.
```

## Solution
### Algorithm Description:
To solve the problem, iterate through the characters of the given string while maintaining a HashSet to track the characters already encountered. As we traverse the string, each character is checked against the HashSet. If the character is not present in the HashSet, it indicates no repetition, and we add it to the HashSet and continue. However, if a character is already in the HashSet, it means a repetition has occurred. At this point, we update the length of the longest substring found so far (if necessary), and modify the HashSet to remove the characters up to and including the repeated character. This process continues until we have traversed the entire string. The final result is the length of the longest substring without repeating characters.

1. Initialization: Begin with two pointers, start and end, both at the start of the string. The hashset will initially be empty.

2. Sliding Window Expansion: Progressively move the end pointer to the right until you come across a character that's already in the hashset, indicating a repetition.

3. Adjusting Start Pointer: Upon detecting a repeated character, increment the start pointer by one position and remove the character at the start position from the hashset. This action ensures that the window only contains unique characters.

4. Result Calculation: At each step, calculate the length of the current window (from start to end). Keep track of the maximum length observed.

By the end of this process, the maximum length observed will be the length of the longest segment of unique characters in the string.

### Algorithm Walkthrough:

Given the string "abrkaabcdefghijjxxx":

- Initialize start and end to 0, and an empty hashset.
- As you move end from 0 to the end of the string:
  - When end is at position 4 (character 'a'), since 'a' is already in the hashset, we will remove the character at position 0 ('a') from the hashset and move start to position 1.
  - Continue this process, always ensuring the characters between start and end are unique.
  - Calculate the length of the segment at each step (start -> end) and update the maximum length.
- The maximum length observed will be 10, corresponding to the segment "abcdefghij".

### Code
```cpp
#include <iostream>
#include <unordered_set>
using namespace std;

class Solution {
public:
    int lengthOfLongestSubstring(string s) {
        unordered_set<char> char_set;
        int maxLength = 0, start = 0, end = 0, n = s.length();
        
        // Traverse the string with the end pointer
        while (end < n) {
            // If the character is not in the set, it's a unique character for the current substring
            if (char_set.find(s[end]) == char_set.end()) {
                char_set.insert(s[end]);
                maxLength = max(maxLength, end - start + 1);
                end++;
            } else {
                // If we find a repeating character, remove the character at the start pointer and move the start pointer
                char_set.erase(s[start]);
                start++;
            }
        }
        
        return maxLength;
    }
};

int main() {
    Solution sol;
    cout << sol.lengthOfLongestSubstring("abcdaef") << endl;       // Expected: 6
    cout << sol.lengthOfLongestSubstring("aaaaa") << endl;         // Expected: 1
    cout << sol.lengthOfLongestSubstring("abrkaabcdefghijjxxx") << endl; // Expected: 10
    return 0;
}
```

### Time Complexity
- While Loop: The algorithm uses a sliding window approach with two pointers, start and end. In the worst-case scenario, both pointers traverse the entire length of the string. Since each pointer can move from the beginning to the end of the string, the time complexity is O(2n), where n is the length of the string. However, in big O notation, constants are dropped, so the time complexity is O(n).

- HashSet Operations: The operations of adding, deleting, and checking for the existence of an element in a HashSet (or Set in some languages) are O(1) on average. Therefore, these operations don't add any significant overhead to the time complexity.

Combining the above points, the overall time complexity of the algorithm is O(n).

### Space Complexity
- HashSet: The space complexity is determined by the size of the HashSet. In the worst-case scenario, the HashSet will store all unique characters of the string. Since the set of possible characters is fixed (assuming the ASCII character set, which has 128 characters, or the extended ASCII set, which has 256 characters), the space complexity is O(min(n, m)), where n is the length of the string and m is the character set size (either 128 or 256). For most strings, n will be much larger than m, so the space complexity is effectively O(m), which is a constant. 

Therefore, the overall space complexity of the algorithm is O(1), as it's constant and does not grow with the size of the input string.