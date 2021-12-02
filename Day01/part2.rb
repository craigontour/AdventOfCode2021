if (ARGV[0] == 't')
  inputs = File.readlines('test.txt').each.map(&:to_i)
else
  inputs = File.readlines('input.txt').each.map(&:to_i)
end

def get_three_measurement(input)
  return input[0..2].sum
end

def get_increasing(nums)
  i = 0
  while nums.length > 3 do
    a = get_three_measurement(nums[i..i+2])
    b = get_three_measurement(nums[i+1..i+3])
    if a >= b
      return i, nums[i+1..-1]
    end
    # puts "i: #{i}"
    # puts "a: #{a}
    # b: #{b}",'----'
    i += 1
  end
end

def part2(inputs)
  part2 = 0

  while inputs.length > 3 do
    c, inputs = get_increasing(inputs)
    # puts c
    # puts inputs
    part2 += c
  end

  puts "Part2 : #{part2}", '-----'
end

part2(inputs)
