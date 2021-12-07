
def pause
  puts "pause..."
  exit if STDIN.gets.chomp == 'x'
end

f = ARGV[0] == 't' ? 'test' : 'input'

crabs = {}

File.read("#{f}.txt")
  .split(',')
  .map(&:to_i)
  .sort
  .each { |i|
    if crabs[i].nil?
    crabs[i] = 1
    else
      crabs[i] += 1
    end
  }

puts crabs

min = crabs.keys[0]
max = crabs.keys[-1]
fuels = {}

(min..max).each do |i|
  fuel = 0
  crabs.each do |h, v|
    # puts " i: #{h} has #{v} crab(s)"
    f = (h - i).abs * v
    # puts " fuel for #{v} crab(s) at #{h} = #{f}"
    # pause
    fuel += f
  end
  puts "Position #{i} had fuel costs: #{fuel}"
  fuels[i] = fuel
end

puts fuels
pp (fuels.sort_by { |_, value| value})[0]
