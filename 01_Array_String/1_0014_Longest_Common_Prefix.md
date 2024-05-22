## 14. Longest Common Prefix


Write a function to find the longest common prefix string amongst an array of strings.

If there is no common prefix, return an empty string "".

 

Example 1:

Input: strs = ["flower","flow","flight"]
Output: "fl"
Example 2:

Input: strs = ["dog","racecar","car"]
Output: ""
Explanation: There is no common prefix among the input strings.
 

Constraints:

1 <= strs.length <= 200
0 <= strs[i].length <= 200
strs[i] consists of only lowercase English letters.


Python
``` python
def longestCommonPrefix(self, strs):
    """
    :type strs: List[str]
    :rtype: str
    """
    if not strs:
        return ""
    shortest = min(strs,key=len)
    for i, ch in enumerate(shortest):
        for other in strs:
            if other[i] != ch:
                return shortest[:i]
    return shortest 
```


Explanation:
- Check if the list is empty: If the input list strs is empty, return an empty string "".
- Find the shortest string: find the shortest string in the list. This is because the common prefix cannot be longer than the shortest string.
- Iterate through each character of the shortest string
- Compare characters with other strings:
- For each character in the shortest string, iterate through all the strings in the list.
- If any string has a different character at the same position, return the substring of the shortest string from the beginning up to the current index i.
- Return the common prefix: If the loop completes without finding any mismatches, return the shortest string itself as the common prefix.

Another approach:

Python
``` python
class Solution:
    def longestCommonPrefix(self, v: List[str]) -> str:
        ans = ""
        v = sorted(v)
        first = v[0]
        last = v[-1]
        for i in range(min(len(first),len(last))):
            if (first[i] != last[i]):
                return ans
            ans += first[i]
        return ans 
```


Another approach:

Python
``` python
class Solution:
    def longestCommonPrefix(self, strs: List[str]) -> str:
        res = ""
        for a in zip(*strs):
            if len(set(a)) == 1: 
                res += a[0]
            else: 
                return res
        return res
```

- Initialize an empty string res to store the common prefix.
- Zip the list of strings using zip(*strs) to group characters by index.
- Convert each tuple of characters to a set:
- If all characters are the same (set length is 1), add the character to res.
- If a mismatch is found (set length is not 1), return res.
- Return res after processing all characters.
