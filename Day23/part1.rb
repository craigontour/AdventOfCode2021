
# hallway
h  = [' ', ' ', 'x', ' ', 'x', ' ', 'x', ' ' ,'x', ' ', ' ']

# Start positions
# s1 = ['x', 'x', 'A', 'x', 'D', 'x', 'C', 'x', 'A', 'x', 'x']
# s2 = ['x', 'x', 'B', 'x', 'C', 'x', 'B', 'x', 'D', 'x', 'x']

l1 = ['A', 'D', 'C', 'A']
l2 = ['B', 'C', 'B', 'D']

# Target
e1 = ['A', 'B', 'C', 'D']
e2 = ['A', 'B', 'C', 'D']

def findEmpty(l1, l2, h)

end

def move()

end

i = 0
while l1 != e1 && l2 != e2 do
  findEmpty(l1, l2, h)

  i += 1
  if i == 10
    break
  end
end


# get letter from left to right
# - if on row 1 do
#     is a space free in row 2 with buddy letter in row 3?
#       yes: move to row 2
#       no : dont move OR move to safe?
# - if on row 2 do
#     is my buddy letter on row 3 of this col
#       yes : dont move
#       no  : which col is my buddy letter on?
#           

puts 'done.'
