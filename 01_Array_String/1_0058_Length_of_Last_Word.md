## 58. Length of Last Word

Given a string s consisting of words and spaces, return the length of the last word in the string.

A word is a maximal 
substring consisting of non-space characters only.

Example 1:

- Input: s = "Hello World"
- Output: 5
- Explanation: The last word is "World" with length 5.

Example 2:

- Input: s = "   fly me   to   the moon  "
- Output: 4
- Explanation: The last word is "moon" with length 4.

Example 3:

- Input: s = "luffy is still joyboy"
- Output: 6
- Explanation: The last word is "joyboy" with length 6.
 

Constraints:

1 <= s.length <= 104
s consists of only English letters and spaces ' '.
There will be at least one word in s.
    
### Python

``` python
class Solution(object):
    def lengthOfLastWord(self, s):
        """
        :type s: str
        :rtype: int
        """
        stripped = s.strip()
        strList = stripped.split(" ")
        lastWord = strList[-1]
        return len(lastWord)
```

Using pointer
loops traverse the string backward

### Python
``` python
class Solution:
     def lengthOfLastWord(self, s):
        ptr1 = 0
        ptr2 = 0

        for i in range(len(s)-1,-1,-1):
            if s[i].isalpha():
                ptr1 = i+1
                print(ptr1)
                break
        
        for i in range(ptr1-1,-1,-1):
            if s[i] == " ":
                ptr2 = i
                break
            if i==0:
                ptr2 = i-1
                break
        
        result = ptr1-ptr2-1
        return result
```

Explanation:
- Initialize Pointers: Set ptr1 and ptr2 to 0.
- Find End of Last Word:
    - Traverse string s backward.
    - Set ptr1 to position after the last alphabetic character.
- Find Start of Last Word:
    - Continue backward traversal from ptr1 - 1.
    - Set ptr2 to position of first space before last word.
- Calculate Length:
    - Length is ptr1 - ptr2 - 1.