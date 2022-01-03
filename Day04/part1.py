# Solution uses:
# - readline() to read 1 line from file
# - split() to get distinct words from line
# Either
# - list() to create a list of words
# - map() to change words to integers
# Or
# - list comprehension & type casting

with open('test.txt') as f:
  balls = [ int(n) for n in f.readline().split(',')]

  # line 3-7, 9-13, 15-19, etc,.
  x = 2
  boxes = []
  while True:
    f.readline()
    box = []
    
    for y in range(0, 5):
      # box.append(list(map(int, f.readline().split())))
      # print("1 box:", box)
      box.append([ int(n) for n in f.readline().split() ])

    if len(box[-1]) == 5:
      x += 6
      boxes.append(box)
    else:
      break

for ball in balls:
  for b in range(0, len(boxes)):
    box = boxes[b]
    print("box", box, '\n')
    for line in box:
      for col in line:
        print("col:", col, "is ball", ball, "? :", col == ball)
  print('----------------')


# not finished
