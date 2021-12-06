# recursion

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

def spawned_fish(day, days)
  spawned = 0
  puts "- get spawned fish from day #{day} to #{days}"
  ((day+1)..days).step(7).each do |dd|
    spawned += 1 if dd != days
    puts "-- fish spawned day #{dd}; spawned = #{spawned}"
    if days - dd > 7
      spawned += spawned_fish(dd + 9, days)
    end
  end
  return spawned
end

def main(fish, days)
  puts "Total days = #{days}"
  totalfish = fish.length
  
  (1..days).each do |day|
    
    puts "day: #{day+1}" #", totalfish #{totalfish}"

    fish.each_with_index do |f, i|
      fish[i] -= 1
      if fish[i] == 0
        puts "fish[#{i}]: spawns on day #{day}"
        totalfish += spawned_fish(day, days)
      end
    end
    
    fish.delete(0)
    
    puts "after : #{day}: #{fish}, totalfish: #{totalfish}", '----------'
    pause
  end
  
  return totalfish
end


puts "Part 2: #{main(getFish(ARGV[1]), ARGV[0].to_i)}"
