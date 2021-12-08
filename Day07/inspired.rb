start = Time.now

def pause
  puts "pause..."
  exit if STDIN.gets.chomp == 'x'
end

f = ARGV[0] == 't' ? 'test' : 'input'

crabs = {}

crabs = File.read("#{f}.txt")
  .split(',')
  .map(&:to_i)
  .sort


# puts crabs
# puts crabs.min
# puts crabs.max

fuels = []

(crabs.min..crabs.max).each do |i|
  fuel = 0

  crabs.each do |crab|
    fuel += (1..(crab - i).abs).sum
    # puts "Fuel for #{crab} = #{fuel}"
  end

  fuels << fuel
end

puts "Part 1: #{fuels.sort[0]} in #{Time.now - start} sec."
