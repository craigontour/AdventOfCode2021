# recursion

start = Time.now()

def pause
  puts "pause..."
  exit if STDIN.gets.chomp == 'x'
end

def getFish(arg1)
  if arg1 == 't'
    return [ 3, 4, 3, 1, 2 ]
  else
    return File.readlines('input.txt')[0].split(',').map(&:to_i)
  end
end

ENDDAYS = ARGV[0].to_i
fish = getFish(ARGV[1])

days = {}

fish.each_with_index do |f, i|
  firstspawn = fish[i] + 1
  (firstspawn..ENDDAYS).step(7) do |sp|
    if days[sp].nil?
      days[sp] = 1
    else
      days[sp] += 1
    end
  end
end

(1..ENDDAYS).each do |d|
  next if days[d].nil?
  
  # puts "fish on day #{d}: #{c}"
  ((d+9)..ENDDAYS).step(7).each do |i|
    # puts "add #{c} fish to day #{i}"
    if days[i].nil?
      days[i] = days[d]
    else
      days[i] += days[d]
    end
    # puts "day #{i}: #{days[i]}"
    # pause
  end
end

# days.each { |h, v| puts "#{h} -> #{v}" }

puts "Part 2: #{days.sum {|h,v| v} + fish.length} in #{Time.now()-start} sec."
