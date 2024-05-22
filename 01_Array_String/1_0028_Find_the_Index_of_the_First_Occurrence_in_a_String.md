## 28. Find the Index of the First Occurrence in a String

Given two strings needle and haystack, return the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.

Example 1:

- Input: haystack = "sadbutsad", needle = "sad"
- Output: 0
- Explanation: "sad" occurs at index 0 and 6.
- The first occurrence is at index 0, so we return 0.

Example 2:

- Input: haystack = "leetcode", needle = "leeto"
- Output: -1
- Explanation: "leeto" did not occur in "leetcode", so we return -1.
 

Constraints:

1 <= haystack.length, needle.length <= 104
haystack and needle consist of only lowercase English characters.


### Python

``` python
class Solution(object):
    def strStr(self, haystack, needle):
        """
        :type haystack: str
        :type needle: str
        :rtype: int
        """
        for i in range(len(haystack) + len(needle) + 1):
            if haystack[i:i+len(needle)] == needle:
                return i
        return -1
```


Explanation:
- Iteration Through Haystack:
    - The loop runs from 0 to len(haystack) - len(needle) + 1. This ensures we only check valid starting positions where needle can fully fit within haystack.
- Substring Comparison:
    - For each index i, it checks if the substring of haystack from i to i + len(needle) matches needle.
- Return the Index: If a match is found, it returns the starting index i.
- No Match Found: If no match is found after completing the loop, it returns -1.
