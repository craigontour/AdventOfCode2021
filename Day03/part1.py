# Part 1

diag = open('input.txt').read().split('\n')
# print(diag)

def readCol(l, c):
  s = ''
  for row in l:
    s += row[c]
  return s

def getBinary(s):
  return int(s, 2)

g = e = ''
for i in range(0, len(diag[0])):
  s = readCol(diag, i)
  if s.count('1') > s.count('0'):
    g += '1'
    e += '0'
  else:
    g += '0'
    e += '1'

print("Part 1:",int(g, 2) * int(e, 2))

# On Shoulders of Giants - using numpy

arr = []
with open("test.txt") as f:
  for line in f:
    val = line.replace('\n', '')
    arr.append(str(val))

print(arr)
print(arr[0])
print(arr[0][0])
