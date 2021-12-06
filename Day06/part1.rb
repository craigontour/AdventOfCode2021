# += 1 every 7 days

def pause
  puts "pause..."
  exit if STDIN.gets.chomp == 'x'
end

def getFish
  if ARGV[1] == 't'
    return [ 3, 4, 3, 1, 2 ]
  else
    input = File.readlines('input.txt')
    arr = input[0].split(',').map(&:to_i)
    return arr
  end
end

def main(days)
  fish = getFish

  for d in 1..days do
    # puts "before: #{d}: #{fish}"

    fish.each_with_index do |f, i|
      if f == 0
        fish[i] = 6
        fish << 9
      else
        fish[i] -= 1
      end
    end
    # puts "after : #{d}: #{fish}", '---'
    # pause
    puts "day: #{d}"
  end

  return fish.length
end

days = ARGV[0].to_i

puts "Part 1: #{main(days)}"
