
data = [ i for i in open('input.txt').read().split('\n') ]

print(len(data))
print(data[0])
print(data[1999])

c = 0
for r in range(0, len(data)-1):
  if int(data[r]) < int(data[r+1]):
    c += 1
    # print("r:",r,"data[r]:",data[r],"data[r+1]",data[r+1])

print("Part 1:", c)

c = 0
for r in range(0, len(data)-3):
  if int(data[r]) + int(data[r+1]) + int(data[r+2]) < int(data[r+1]) + int(data[r+2]) + int(data[r+3]):
    c += 1

print("Part 2.1:", c)

# This is same as r < r+3 ?
c = 0
for r in range(0, len(data)-3):
  if int(data[r]) < int(data[r+3]):
    c += 1

print("Part 2.2:", c)
