if (ARGV[0] == 't')
  inputs = File.readlines('test.txt').each.map(&:to_i)
else
  inputs = File.readlines('input.txt').each.map(&:to_i)
end

def get_increasing(nums)
  i = 0
  while nums[i+1] != nil && nums[i] < nums[i+1] do
    i += 1
  end
  return i, nums[i+1..-1]
end

def part1(inputs)
  part1 = 0
  
  while inputs.length > 0 do
    c, inputs = get_increasing(inputs)
    part1 += c
  end

  puts "Part1: #{part1}", '-----'
end

part1(inputs)

# --------------------------------------------------
# iterator
# --------------------------------------------------

inputs = inputs.map(&:to_i)

x = c = 0
y = 1

while inputs[y] != nil do
  if inputs[x] < inputs[y]
    # puts "x: #{inputs[x]}; y: #{inputs[y]}"
    c += 1
  end
  x += 1
  y += 1
end

puts c
