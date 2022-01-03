import numpy as np

lines = open('test.txt').read().split('\n')
lines = [list(line) for line in lines]
print(lines)

grid = np.array(lines, dtype=int)
print(grid)

width = np.shape(grid)[1]

for column in range(width):
  print(sum(grid[:,column] == 1))
  print(np.shape(grid)[0] // 2)

# part 1
def findMostCommon(col):
    countOne = sum(grid[:,col] == 1)
    return '1' if countOne >= np.shape(grid)[0] // 2 else '0'

gammaDigits = [findMostCommon(column) for column in range(width)]
epsilonDigits = ['1' if digit == '0' else '0' for digit in gammaDigits]
gamma = int(''.join(gammaDigits), 2)
epsilon = int(''.join(epsilonDigits), 2)
print('part 1:', gamma * epsilon)

# # part 2
# def filterByMostCommon(col, grid):
#     countOne = sum(grid[:,col] == 1)
#     countZero = sum(grid[:,col] == 0)
#     mostCommon = 1 if countOne >= countZero else 0
#     return np.delete(grid, np.where(grid[:, col] != mostCommon)[0], axis=0)

# def filterByLeastCommon(col, grid):
#     countOne = sum(grid[:,col] == 1)
#     countZero = sum(grid[:,col] == 0)
#     leastCommon = 0 if countZero <= countOne else 1
#     return np.delete(grid, np.where(grid[:, col] != leastCommon)[0], axis=0)
 
# grid = np.array(lines, dtype=int)
# column = 0
# while np.shape(grid)[0] > 1:
#     grid = filterByMostCommon(column, grid)
#     column += 1

# nums = ''.join([str(grid[0,i]) for i in range(width)])
# ogr = int(nums,2)

# grid = np.array(lines, dtype=int)
# column = 0
# while np.shape(grid)[0] > 1:
#     grid = filterByLeastCommon(column, grid)
#     column += 1

# nums = ''.join([str(grid[0,i]) for i in range(width)])
# csr = int(nums,2)

# print('part 2:', ogr * csr)