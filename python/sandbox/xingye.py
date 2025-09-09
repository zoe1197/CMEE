#
# 返回值: int[]
# 参数: arr: int[], 输入的数组
#
import sys
# arr = [2,3,14,5,0]

def test(arr):
    if arr == None:
        pass
    else:
        arr = input("please input:", )
        print(sorted(arr, reverse = True))
    # write code here
    
if __name__ == "__main__":
  test(arr)