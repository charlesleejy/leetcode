## 169. Majority Element

Given an array nums of size n, return the majority element.

The majority element is the element that appears more than ⌊n / 2⌋ times. 
You may assume that the majority element always exists in the array.

Example 1:

- Input: nums = [3,2,3]
- Output: 3

Example 2:

- Input: nums = [2,2,1,1,1,2,2]
- Output: 2
 

Constraints:

- n == nums.length
- 1 <= n <= 5 * 104
- -109 <= nums[i] <= 109
 

Follow-up: Could you solve the problem in linear time and in O(1) space?


### Python
Using hashmap
``` python
class Solution:
    def majorityElement(self, nums: List[int]) -> int:
        count = {}
        res, maxCount = 0, 0 
        for n in nums:
            count[n] = 1 + count.get(n,0)
            if count[n] > maxCount:
                res = n
            maxCount = max(count[n], maxCount)
        return res
exit(0)
```

### Python
``` python
class Solution:
    def majorityElement(self, nums: List[int]) -> int:
        curr, count = nums[0], 1
        for i in nums[1:]:
            count += (1 if curr == i else -1)
            if count == 0:
                curr = i
                count = 1
        return curr
```

Explanation:

- Boyer-Moore Voting Algorithm used to find the majority element in an array:
- Initialize:
    - curr to track the current candidate for the majority element.
    - count to count the occurrences of the current candidate.
- Iterate through the array:
    - If the count is zero, set the current element as the new candidate and reset the count to 1.
    - For each element, if it matches the current candidate, increment the count.
    - If it doesn't match, decrement the count.
- Return the candidate:
    - By the end of the iteration, the candidate stored in curr will be the majority element.

Key Points
- Time Complexity: O(n) - The array is traversed only once.
- Space Complexity: O(1) - No extra space is used.