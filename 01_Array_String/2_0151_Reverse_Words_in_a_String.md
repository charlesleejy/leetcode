## 151. Reverse Words in a String

Given an input string s, reverse the order of the words.

A word is defined as a sequence of non-space characters. The words in s will be separated by at least one space.

Return a string of the words in reverse order concatenated by a single space.

Note that s may contain leading or trailing spaces or multiple spaces between two words. The returned string should only have a single space separating the words. Do not include any extra spaces.

Example 1:

- Input: s = "the sky is blue"
- Output: "blue is sky the"

Example 2:

- Input: s = "  hello world  "
- Output: "world hello"
- Explanation: Your reversed string should not contain leading or trailing spaces.

Example 3:

- Input: s = "a good   example"
- Output: "example good a"
- Explanation: You need to reduce multiple spaces between two words to a single space in the reversed string.
 

Constraints:

- 1 <= s.length <= 104
- s contains English letters (upper-case and lower-case), digits, and spaces ' '.
- There is at least one word in s.
 
Follow-up: If the string data type is mutable in your language, can you solve it in-place with O(1) extra space?

### Python
``` python
class Solution(object):
    def reverseWords(self, s):
        """
        :type s: str
        :rtype: str
        """
        res = ""
        s = " " + s + " "
        start = end = -1
        for i in range(len(s) - 2, 0, -1):
            if s[i + 1] == " " and s[i] != " ":
                end = i
            if s[i - 1] == " " and s[i] != " ": 
                start = i
                res = res + " " + s[start: end + 1]
        return res[1:]
```

Explanation:
- Pad and Initialize:
    - Add spaces at the start and end of the string to handle edge cases.
    - Initialize an empty result string res.
- Iterate Backwards:
    - Traverse the string from the second last character to the second character.
    - Identify word boundaries by checking spaces around characters.
- Build Result:
    - When a word is identified, add it to the result string with a leading space.
- Return:
    - Remove the extra leading space from the result.