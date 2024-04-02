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

## My Solution
```cpp
#include <iostream>
#include <unordered_set>
using namespace std;

/*

    abcdebd
f:      ^
b:        ^
hashset = {e, b, d}
cur_length = 3

1. init a new custom class "substring"
    //- queue: char_list
    - int: front_idx, back_idx
    - hashset: char_set
    - int: cur_len

2. iterate through the list, for each element
    while the element is in "substring"
        - pop element from substring.char_list from front
        - pop element from substring.char_set
        - substring.cur_len--

    - push element to substring.char_list
    - push element to substring.char_set
    - substring.cur_len++

    - record the max(substring.cur_len)

*/

class Solution {
private:
    class CustomSubstring {
    private:
        const string& src_string;
        int front, back, len;
        unordered_set<int> char_set;
    public:
        CustomSubstring(string& src_str) : front(-1), back(-1), len(0), src_string(src_str) {}

        void pushChar() {
            // push the target_c to the back
            if (front==-1) front = 0, back = 0;
            else back++;

            len++;

            char_set.insert(src_string[back]);
        }

        void removeChar() {
            // pop the first element from front
            // assert len() > 0;
            char cur_char = src_string[front];
            char_set.erase(cur_char);
            front++;
            len--;
        }

        int has(char target_c) {
            // see if the substring contains target_c 
            return char_set.count(target_c);
        }

        int length() {
            return len;
        }

    };

public:
    int lengthOfLongestSubstring(string s) {
        int maxLength = 0;
        // ToDo: Write Your Code Here.
        CustomSubstring custom_substring = CustomSubstring(s);

        for (char& c: s) {
            while (custom_substring.has(c) == 1) custom_substring.removeChar();
            custom_substring.pushChar();
            if (custom_substring.length() > maxLength) maxLength = custom_substring.length();
        }

        return maxLength;
    }
};


/*
abcdebdd
       ^

maxLength = 5
custom_substring {
    front=7
    back=7
    len=1
    src_string=abcdebdd
    char_set={d}
}

*/
```