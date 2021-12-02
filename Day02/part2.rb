aim = horiz = depth = 0

File.readlines('input.txt').each do |line|
  dir, amount = line.chomp.split(' ')
  # puts "dir: #{dir}; amount: #{amount}"
  case dir
  when 'forward'
    horiz += amount.to_i
    depth += aim * amount.to_i
  when 'down'
    aim += amount.to_i
  when 'up'
    aim -= amount.to_i
  end
end

pp aim
pp horiz
pp depth

pp horiz * depth
