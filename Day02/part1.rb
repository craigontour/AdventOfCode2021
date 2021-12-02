
def getInput(t)
  return File.open("#{t}.txt").readlines()
end

if (ARGV[0] != nil)
  getInput('test.txt')
else
  getInput('input.txt')
end

dist = depth = 0

.each do |line|
  dir, amount = line.chomp.split(' ')
  # puts "dir: #{dir}; amount: #{amount}"
  case dir
  when 'forward'
    dist += amount.to_i
  when 'down'
    depth += amount.to_i
  when 'up'
    depth -= amount.to_i
  end
end

pp dist
pp depth
pp dist * depth
