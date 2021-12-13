start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def fold_horizontal(dots, r)
  puts "horizontal fold at #{r}"
  if dots.length / 2 == r # i.e. middle
    folded = Array.new(dots.length/2)
    y1 = 0
    y2 = r - 1

    puts "middle fold: from #{y1} to #{y2}"

    (y1..y2).each do |i|
      opp = (dots.length - 1) - i
      puts "#{i}:#{dots[i]}, #{opp}:#{dots[opp]}"
      r1 = dots[i] ||= (dots[0].length).times.map{'0'}.join('')
      r2 = dots[opp] ||= (dots[0].length).times.map{'0'}.join('')
      folded[i] = (r1.to_i(2) | r2.to_i(2)).to_s(2).rjust(dots[0].length,'0')
    end
  elsif dots.length - r > dots.length / 2  # i.e. right side is long fold
    y1 = dots.length - 1
    y2 = r + 1
    folded = Array.new(y1 - y2 + 1)
    
    puts "long fold  : from #{y1} down to #{y2}"

    (y1.downto(y2)).each_with_index do |row, i|
      opp = r - (y1 - y2 - i + 1)
      # puts "#{i}:#{dots[row]}, #{opp}:#{dots[opp]}"

      if opp < 0
        folded[i] = dots[row]
      else
        r1 = dots[row] ||= (dots[0].length).times.map {'0'}.join('')
        r2 = dots[opp] ||= (dots[0].length).times.map {'0'}.join('')
        folded[i] = (r1.to_i(2) + r2.to_i(2)).to_s(2).rjust(dots[0].length,'0')
      end
      
      # pp folded[i],''
      # pause
    end
  else # i.e. right side is short fold
    y1 = 0
    y2 = r - 1
    folded = Array.new(r)

    puts "short fold : from #{y1} to #{y2}"
    
    (0..y2).each do |i|
      opp = (r - i) + r
      # puts "#{i}:#{dots[i]}, #{opp}:#{dots[opp]}"

      if opp > dots.length-1
        folded[i] = dots[i]
      else
        r1 = dots[i] ||= (dots[0].length).times.map {'0'}.join('')
        r2 = dots[opp] ||= (dots[0].length).times.map {'0'}.join('')
        folded[i] = (r1.to_i(2) + r2.to_i(2)).to_s(2).rjust(dots[0].length,'0')
      end
      
      # pp folded[i],''
      # pause
    end
  end
  
  pp folded

  return folded
end

def fold_vertical(dots, r)
  puts "vertical fold at #{r}"
  pp dots
  pp dots.transpose
  pause

  # l = dots[0].length
  # if l / 2 == r # i.e. middle
  #   folded = Array.new(l)
  #   x1 = 0
  #   x2 = r

  #   puts "middle fold: from #{y1} to #{y2}"

  #   (x1..x2).each do |i|
  #     opp = (dots.length - 1) - i
  #     # puts "#{i}:#{dots[i]}, #{opp}:#{dots[opp]}"
  #     r1 = dots.map { |col| col[i] } ||= (dots.length).times.map {'0'}.join('')
  #     r2 = dots.map { |col| col[opp] } ||= (dots.length).times.map {'0'}.join('')
  #     folded[i] = (r1.to_i(2) + r2.to_i(2)).to_s(2).rjust(dots.length,'0')
  #   end
  # elsif dots.length - r > dots.length / 2  # i.e. right side is long fold
  #   y1 = dots.length - 1
  #   y2 = r + 1
  #   folded = Array.new(y1 - y2 + 1)
    
  #   puts "long fold  : from #{y1} down to #{y2}"

  #   (y1.downto(y2)).each_with_index do |row, i|
  #     opp = r - (y1 - y2 - i + 1)
  #     # puts "#{i}:#{dots[row]}, #{opp}:#{dots[opp]}"

  #     if opp < 0
  #       folded[i] = dots[row]
  #     else
  #       r1 = dots[row] ||= (dots[0].length).times.map {'0'}.join('')
  #       r2 = dots[opp] ||= (dots[0].length).times.map {'0'}.join('')
  #       folded[i] = (r1.to_i(2) + r2.to_i(2)).to_s(2).rjust(dots[0].length,'0')
  #     end
      
  #     # pp folded[i],''
  #     # pause
  #   end
  # else # i.e. right side is short fold
  #   y1 = 0
  #   y2 = r - 1
  #   folded = Array.new(r)

  #   puts "short fold : from #{y1} to #{y2}"
    
  #   (0..y2).each do |i|
  #     opp = (r - i) + r
  #     # puts "#{i}:#{dots[i]}, #{opp}:#{dots[opp]}"

  #     if opp > dots.length-1
  #       folded[i] = dots[i]
  #     else
  #       r1 = dots[i] ||= (dots[0].length).times.map {'0'}.join('')
  #       r2 = dots[opp] ||= (dots[0].length).times.map {'0'}.join('')
  #       folded[i] = (r1.to_i(2) + r2.to_i(2)).to_s(2).rjust(dots[0].length,'0')
  #     end
      
  #     # pp folded[i],''
  #     # pause
  #   end
  # end
  
  # pp folded

  # return folded
end

def do_fold(dots, folds, stop)
  folds.split("\n").each_with_index do |fold , i|
    axis, num = fold.chomp.split(' ')[-1].split('=')
    puts "fold along #{axis} number #{num}"

    if axis == 'y'
      return fold_horizontal(dots, num.to_i)
    else
      return fold_vetical(dots, num.to_i)
    end

    # return dots if i+1 == stop
  end
end

###

input, folds = File.read("#{ARGV[0]}.txt").split("\n\n")
input = input.split("\n")

BLANKS = if ARGV[0] == 'test'
  11.times.map{'0'}.join('')
else
  999.times.map{'0'}.join('')
end

dots = []
input.each do |row|
  x, y = row.chomp.split(",").map(&:to_i)
  r = dots[y] ||= BLANKS
  # puts "row:#{y}, r:#{r}"
  r[x] = '1'
  # puts "x:#{x}, r:#{r}",''
  # pause
end

pp input
pp input.length
pause

# part1 = fold_horizontal(dots, 7).flatten.map { |s| s }.join('').count('1')
part1 = do_fold(dots, folds, 1).flatten.map { |s| s }.join('').count('1')
pp "Part1: #{part1} in #{Time.now - start} secs"
