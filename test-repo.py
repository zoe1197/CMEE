

""" 1.
给定一个数组 prices ，它的第 i 个元素 prices[i] 表示一支给定股票第 i 天的价格。

你只能选择某一天买入这只股票，并选择在未来的某一个不同的日子卖出该股票。

设计一个算法来计算你所能获取的最大利润。

返回你可以从这笔交易中获取的最大利润。如果你不能获取任何利润，返回 0 。 """


from audioop import reverse
from cgi import test
from difflib import restore
from math import floor, gcd
from operator import le, length_hint
from time import process_time_ns
from tkinter.colorchooser import askcolor
from traceback import print_tb
from turtle import left, numinput, right
from unittest.mock import sentinel

from pyparsing import restOfLine


class Solution1:
    def maxProfit(self, prices):
        min_price= int(1e9)
        max_profit = 0
        for price in prices:
            max_profit = max(price - min_price, max_profit)
            min_price = min(price, min_price)
        return max_profit

max_pri = Solution1()
max_pri.maxProfit([7,1,5,3,6,4])
max_pri.maxProfit([7,6,4,3,1])

""" 2.
一只青蛙一次可以跳上1级台阶，也可以跳上2级台阶。求该青蛙跳上一个 n 级的台阶总共有多少种跳法。

答案需要取模 1e9+7（1000000007），如计算初始结果为：1000000008，请返回 1。
"""
class FibonacciVar:
    def numWays(self, n: int) -> int:
        a, b = 1, 1
        for _ in range(n):
            a, b = b, a + b
        return a % 1000000007

fib = FibonacciVar()
fib.numWays(7)



""" 3.计算某字符出现的次数 """

array = input()
obj = input()

array = str(array.lower())
obj = obj.lower()

num = 0
for i in range(len(array)):

    if array[i] == obj:
        num += 1
    else:
        next

print(num)



""" 4.N+随机数，返回不重复数字 """
N = input()
N = int(N)

list = []
for i in range(N):
    temp = input()
    temp = int(temp)
    list.append(temp)

result = set(list)
result = sorted(result)

for j in result:
    print(j)


""" 5.字符串分割 """

string = input()

def separate(string):
    groups = int(len(string) / 8)
    for i in range(groups):
        print(string[i*8:(i+1)*8])

if len(string) % 8 == 0:
    separate(string)
else:
    add = 8-len(string) % 8
    add_0 = '0'*add
    string = string + add_0
    separate(string)



""" 6. 计算成绩(最少学习时间) """
import numpy as np
import sys
import re

# define the functions
def match_num(inpu):
    match = re.findall(r'\d+\s?',inpu)
    return match

# read the data
inpu = sys.stdin.readlines()
data = [[0 for i in range(3)] for j in range(len(inpu))]
for i in range(len(inpu)):
    size = len(match_num(inpu[i]))
    temp = []
    for j in range(size):
        temp.append(int(match_num(inpu[i])[j]))
        data[i] = temp

# define main
# 1.有几组数据需要处理

rest = data
heads = [i for i in data if len(i) == 3]
for i in range(len(heads)):
    n = heads[i][0]
    r = heads[i][1]
    avg = heads[i][2]
    group = rest[0:n+1]
    rest = rest[n+1:]
    # calculatation
    min_score = 0
    b_list = []
    for j in range(n):
        min_score += group[j+1][0]
        if int(group[j+1][1]) in b_list:
            next
        else:
            b_list.append(int(group[j+1][1]))

    # 判断分数
    if min_score >= n*avg:
        print(0)
    else:
        lower = min_score
        upper = min_score
        t = 0
        # 需要处理几个b值
        times = 0
        while upper < n*avg:
            
            b_loop = sorted(b_list)[times]
            
            for l in range(n):
                a = group[l+1][0]
                b = group[l+1][1]
                if b == b_loop:
                    upper += (r-a) 
                else:
                    next 
                    
            t += (upper-lower)*b_loop
            lower = upper 
            times += 1
        print(t+((n*avg-lower)*b_loop))


# ##################################
# # 用numpy
# inpu = input()
# if len(match_num(inpu)) == 3:

#     n = int(match_num(inpu)[0])
#     r = int(match_num(inpu)[1])
#     avg = int(match_num(inpu)[2])

#     table = np.zeros((n,2))
#     for i in range(n):
#         inpu = input()
#         table[i,0] = int(match_num(inpu)[0])
#         table[i,1] = int(match_num(inpu)[1])

#     min_score = np.sum(table, axis=0)[0]
#     if min_score >= n*avg:
#         print(0)
#     else:
#         loop_time = len(set(np.sort(table[:,1])))
#         upper = min_score

#         for j in range(loop_time):
#             min_b = list(set(np.sort(table[:,1])))[j]
#             lower = upper
#             upper = 0
#             for k in range(n):
#                 if table[k,1] == min_b:
#                     upper += r
#                 else:
#                     upper += table[k,0]
        
#                 if upper >= n*avg:
#                     print((n*avg-min_score)*min_b)
#                     exit

""" 7.找出没在序列中的数 """
import re

inpu = input()
match = re.findall(r'\d+\s?',inpu)
match

n = int(match[0])
array =[]
for i in match[1:]:
    array.append(int(i))
array

for i in range(n):
    if i in array:
        next 
    else:
        print(i)


""" 8.扭蛋机，倒推事件 """

N = int(input())

array=[]
x = N
while x != 0:
    if x%2 == 0:
        x = (x-2)/2
        array.append(2)
    else:
        x = (x-1)/2
        array.append(3)

array = array[::-1]
for i in array:
    print(i, end='')


""" 9.路灯最小照明距离 """
import re
import sys

inpu = sys.stdin.readlines()

data = [[0 for i in range(1)] for i in range(len(inpu))]
for i in range(len(inpu)):
    match = re.findall(r'\d+\s?', inpu[i])

    temp = []
    for j in range(len(match)):
        temp.append(int(match[j]))
    data[i] = temp

groups = [i for i in data if len(i) == 2]

rest = data
result = []
for time in range(len(groups)):
    n = groups[time][0]
    l = groups[time][1]
    a = rest[1]
    rest = rest[2:]

    index = sorted(a)

    if index[0] != 0 | index[-1] != l:
        compare = max(index[0], l - index[-1])*2
    else:
        compare = l/n

    for i in range(len(index)-1):
        dis = index[i+1] - index[i]
        if compare > dis:
            next 
        else:
            compare = dis

    result.append(compare/2)

for i in result:
    print('%.2f' %(i))


""" 10. 两刀切获取最大的奖金"""
import re

# read the data
n = int(input())
inpu = input()
match = re.findall(r'\d\s?', inpu)
match
data = []
for i in range(n):
    data.append(int(match[i]))
# define the function
def add(direction, data, index):
    if direction == 'l':
        return sum(data[:index])
    else:
        return sum(data[index:])
# calculate
index_left = 1
index_right = n-1
sum_left = add('l', data, index_left)
sum_right = add('r', data, index_right)

equal_list = []
while index_left <= index_right:
    if sum_left < sum_right:
        index_left += 1
        sum_left = add('l', data, index_left)
    elif sum_left > sum_right:
        index_right -= 1
        sum_right = add('r', data, index_right)
    else:
        equal_list.append(sum_right)
        if (index_left +1 == index_right) | (index_left == index_right):
            break
        else:
            index_left += 1
            sum_left = add('l', data, index_left)

if equal_list:
    print(max(equal_list))
else:
    print(0)




""" 11.最小的最大间隔 """
import re
import sys
# read the data
inpu = sys.stdin.readlines()
data =[[0 for i in range(1)] for j in range(len(inpu))]
for i in range(len(inpu)):
    match = re.findall(r'[\d\s?]+\n', inpu[i])
    sub_match = re.findall(r'\d+\s+\n?', match[0])
    temp = []
    for j in range(len(sub_match)):
        temp.append(int(sub_match[j]))
    data[i] = temp
data

# define the function to find the max distance in an array
def max_dist(n, array):
    distance = []
    for i in range(n):
        del_data = array.copy()
        del_data.remove(del_data[i])
        dis = []
        for j in range(n-2):
            dis.append(del_data[j+1] - del_data[j])
        distance.append(max(dis))
    return distance

# calculate
n_list = [lists for lists in data if len(lists) == 1]
loop_times = len(n_list)

min_list = []
for time in range(loop_times):
    n = n_list[time][0]
    array = data[time*2+1]
    dis_list = max_dist(n, array)
    min_list.append(min(dis_list))

for result in min_list:
    print(result)

""" 12.大整数相乘(it's not right cause says 不能用系统自带的最大整数类型) """
import sys

inpu = sys.stdin.readline()
match = re.findall(r'[\d]+\s?', inpu)
data = []
for i in range(len(match)):
    data.append(int(match[i]))

result = data[0] * data[1]

print(str(result))

""" 13.小A最多会新认识多少人 """
import sys
import re
# read the data
inpu = sys.stdin.readlines()

n, index, m = [int(i) for i in inpu[0:3]]
pairs = inpu[3:]
paris_list =[]
for i in range(m):
    head = int(re.findall(r"\d+",pairs[i])[0])
    tail = int(re.findall(r"\d+",pairs[i])[1])
    paris_list.append([head, tail])

# find the people A knows
a_pairs = [pair for pair in paris_list if index in pair]
a_knows = [i for pair in a_pairs for i in pair if i != index]
# introduce
intro_list = []
for i in range(len(a_knows)):
    middle = a_knows[i]
    middle_list = [pair for pair in paris_list if middle in pair]
    intro = [i for pair in middle_list for i in pair if i != middle]
    intro_list.append(intro)
intro_list = [i for j in intro_list for i in j]

result = [a_knows, intro_list]
result = [i for j in result for i in j]
result = set(result)

print(len(result)-1)

""" 14.最大乘水面积 """
height = [2,3,4,5,18,17,6]
class Solution:
    def maxArea(self, height: List[int]) -> int:
        n = len(height)
        i, j = 0, (n-1)

        area = 0
        while i < j & j <= n-1:

            if height[i] < height[j]:
                temp = height[i]*(j-i)
                i += 1
            else:
                temp = height[j]*(j-i)
                j -= 1

            area = max(area, temp)
        
        return area

""" 15. """
a = 1
b = 3
b = 0
if (a > b) & (a == 1):
    print("true")
else:
    print('false')


""" 16.输出最大连续字符串 """
s = 'cc'
class Solution:
    def maxPower(self, s: str) -> int:
        import re
        match = re.findall(r'\w', s)

        count_list = [1]
        temp = 1
        for i in range(1,len(match)):
            if match[i] == match[i-1]:
                temp += 1  
                if i == len(match)-1:
                    count_list.append(temp)
            else:
                count_list.append(temp)
                temp = 1

        return max(count_list)

""" 17.输出乘积小于k的连续字数组 """
nums = [1,2,3]
k = 2

class Solution:
    def numSubarrayProductLessThanK(self, nums: List[int], k: int) -> int:

        from functools import reduce

        result = []
        for length in range(1,len(nums)+1):
            # print("length: ",length)
            for index in range(len(nums)-length+1):
                # print("index: ",index)
                temp = nums[index:index+length]
                # print(temp)
                multi = reduce(lambda x,y: x*y, temp)
                if multi < k:
                    result.append(temp)
        return len(result)
# 时间复杂度过大
# 另解：
nums = [10,5,2,6]
k = 100

result, multi, left = 0,1,0
for right in range(len(nums)):
    num = nums[right]
    multi *= num
    while multi >= k and left < len(nums):
        multi /= nums[left]
        left += 1
    if right-left+1 > 0:
        result += right-left+1

result

""" 18.输出出现最多次数 """
nums = [1,2,2,3,1,4,2]
class Solution:
    def findShortestSubArray(self, nums: List[int]) -> int:

        infor = dict()

        for index, num in enumerate(nums):
            if num in infor:
                infor[num][0] += 1
                infor[num][2] = index
            else:
                infor[num] = [1,index,index]
        
        # calculate the max_time and min_length
        max_time = min_length = 0
        for times, left, right in infor.values():
            if times > max_time:
                max_time = times
                min_length = right-left+1
            elif times == max_time:
                if min_length > (alter := right-left+1):
                    min_length = alter

        return min_length



""" 19.按序反转字符串 """
str = "abcdefg"
k = 2
import re 
import math

match = re.findall(r'\w', str)
times = math.ceil(len(match)/(2*k))

result = []
for time in range(times):

    sub = match[time*2*k:(time+1)*2*k]
    result.append(sub[::-1][-k:])
    result.append(sub[k:])

print(result)

result = [i for item in result for i in item]
''.join(i for i in result)


""" 20 找出所有子字符串 """
words = ["leetcoder","leetcode","od","hamlet","am"]

# 方法1:
# import re
# result = []
# for i in range(len(words)):
#     obj = words[i]
#     for j in range(len(words)):
#         if i == j:
#             next
#         else:
#             match = re.findall(obj, words[j])
#             if len(match) > 0:
#                 result.append(obj)

# 方法2:
result = []
for i in range(len(words)):
    for j in range(i+1, len(words)):
        if words[i].__contains__(words[j]):
            result.append(words[j])
        elif words[j].__contains__(words[i]):
            result.append(words[i])

# 删除重复元素
dic = {}
dic = dic.fromkeys(result)
list(dic.keys())
# 删除：set
# result = set(result)
# list(result)



""" 20. 判断是否是变位词 """
s='abc'
t='acb'
class Solution:
    def isAnagram(self, s: str, t: str) -> bool:

        import re

        if s == t:
            return False
        else:
            letters1 = re.findall(r'\w', s)
            letters2 = re.findall(r'\w', t)

            if sorted(letters1) == sorted(letters2):
                return True
            else:
                return False
       


