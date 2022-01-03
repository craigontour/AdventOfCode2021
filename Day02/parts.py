h = v = 0
for line in open('input.txt').read().split('\n'):
  dir, amount = line.split(' ')
  if dir == 'forward':
    h += int(amount)
  elif dir == 'up':
    v += int(amount)
  elif dir == 'down':
    v -= int(amount)

print("Part 1:", h, "*", abs(v), "=", h * abs(v))

###### Part 2

aim = h = v = 0

for line in open('input.txt').read().split('\n'):
  dir, amount = line.split(' ')
  if dir == 'forward':
    h += int(amount)
    v += int(amount) * aim
  elif dir == 'up':
    aim += int(amount)
  elif dir == 'down':
    aim -= int(amount)

print("Part 2:", h, "*", abs(v), "=", h * abs(v))

