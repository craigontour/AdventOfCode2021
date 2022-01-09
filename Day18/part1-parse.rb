start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

lines = File.readlines("test2.txt").map(&:chomp)

def explodeLeft(num, i, line, debug)
  # This assumes that the number to the left is only 1 digit in length
  puts "-- explodeLeft: i:#{i}, num:#{num}, #{line[0..i]}" if debug
  n = ''
  i.downto(0).each do |j|
    if line[j] != '[' && line[j] != ']' && line[j] != ','
      line[j] = (line[j].to_i + num).to_s
      puts "-- explodeLeft: n:#{n}, line[j]:#{line[j]}, line:#{line}" if debug
      return line
    end
  end
  return line
end

def explodeRight(num, i, line, debug)
  # This assumes that the number to the right is only 1 digit in length
  puts "-- explodeRight: i:#{i}, num:#{num}, #{line[i..-1]}" if debug
  (i..(line.length-1)).each do |j|
    if line[j] != '[' && line[j] != ']' && line[j] != ','
      line[j] = (line[j].to_i + num).to_s
      puts "-- explodeRight: line[j]:#{line[j]}, line:#{line}" if debug
      return line
    end
  end
  return line
end

def explode(i, ns, nums, line, debug)
  puts "EXPLODE:
  - ns  : #{ns}
  - i   : #{i}
  - nums: #{nums}
  - line: #{line}

  - line[0..ns-1]: #{line[0..ns-1] }
  - line[i+1..-1]: #{line[i+1..-1]}
  " if debug
  
  line = explodeLeft(nums[0], ns, line, debug)
  line = explodeRight(nums[1], i, line, debug)
  return line[0..ns-1] + '0' + line[i+1..-1], i
end

debug = false

lines.each do |line|
  # pp line.scan(/\[\d+,\d+\]/)
  # pp line.match(/\[.*\[.*\[.*\[.*\[\d+,\d+\]/)

  puts "---------- New line: #{line} ----------"
  
  i = 0
  nums = []
  n = ''
  lb = 0
  rb = 0
  num_start = 0
  start_line = ''

  # Need to loop until all reductions done
  # while start_line != line 
  # set start_line to line, if not changed after this loop then done
  start_line = line.dup

  while i < line.length-1 do
    ch = line[i]

    if ch == '['
      lb += 1
      explode = true if lb - rb == 5
      if nums.length > 0
        nums = []
      end
      puts "- open  : #{ch}, explode: #{explode ? 'Yes' : 'No'}" if debug
    elsif ch == ']'
      rb += 1
      if n != '' && nums.length == 1 && explode
        nums << n.to_i
        line, i = explode(i, num_start-1, nums, line, debug)
        lb -= 1
        rb -= 1
        nums = []
      end
      n = ''
      puts "- close : #{ch}" if debug
    elsif ch == ','
      if n != ''
        nums << n.to_i
        n = ''
      end
      puts "- comma : #{ch}" if debug
    else
      # if prevCh is [ or , or 0-9 then add to n
      num_start = i if nums.length == 0
      if n == ''
        n = ch
      else
        n += ch
      end
      puts "- number: #{ch}, n:#{n}, num_start:#{num_start}" if debug
    end

    puts "i:#{i}, ch:#{ch}, lb:#{lb}, rb:#{rb}, n:#{n}, nums:#{nums}" if debug
    pause if debug
    
    i += 1
  end

  puts "start_line:#{start_line}, line:#{line}"
  pause
end
