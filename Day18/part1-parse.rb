start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

lines = File.readlines("#{ARGV[0]}.txt").map(&:chomp)

def updateLeft(num, i, oldline, debug)
  lhs = oldline.dup
  rhs = ''
  puts "- updateLeft: i:#{i}, oldline: #{oldline}, num:#{num}, #{lhs[0..i-1]}" if debug
  (i-1).downto(0).each do |j|
    if lhs[j] == '[' || lhs[j] == ']' || lhs[j] == ','
      rhs += lhs[j]
    else
      # assumes single digit number
      nn = (lhs[j].to_i + num).to_s
      puts "-- updateLeft :
      lhs[0..j-1]: #{lhs[0..j-1]}
      nn: #{nn}
      rhs: #{rhs.reverse}
      " if debug
      return lhs[0..j-1] + nn + rhs.reverse
    end
  end
  return rhs.reverse
end

def updateRight(num, oldi, oldline, debug)
  rhs = oldline.dup
  i = oldi.dup
  lhs = ''
  puts "- updateRight: i:#{i}, oldline: #{oldline}, num:#{num}, #{rhs[i+1..-1]}" if debug
  (i+1..(rhs.length-1)).each do |j|
    if rhs[j] == '[' || rhs[j] == ']' || rhs[j] == ','
      lhs += rhs[j]
    else
      # assumes single digit number
      nn = (rhs[j].to_i + num).to_s
      puts "-- updateRight :
      lhs: #{lhs}
      nn: #{nn}
      rhs: #{rhs[j+1..-1]}
      " if debug
      return lhs + nn + rhs[j+1..-1]
    end
  end
  return lhs
end

def explode(i, ns, nums, line, debug)
  puts "EXPLODE:
  - ns  : #{ns}
  - i   : #{i}
  - nums: #{nums}
  - line: #{line}

  - line[0..ns-1]: #{line[0..ns-1] }
  - line[ns..i]  : #{line[ns..i] }
  - line[i+1..-1]: #{line[i+1..-1]}
  " if debug
  
  # line becomes left side of explode + 0 + right side of explode
  ul = updateLeft(nums[0], ns, line, debug)
  ur = updateRight(nums[1], i, line, debug)

  puts "-- explode line: #{line} to #{ul + '0' + ur}" if debug
  return ul + '0' + ur
end

def split_number(ns, i, n, line, debug)
  a, b = n.to_i.divmod(2)
  puts "
  split_number:
  ns  : #{ns}
  i   : #{i}
  n   : #{n}
  a, b: #{a}, #{b}

  lhs : #{line[0..ns]}
  rhs : #{line[i+1..-1]}
  line: #{line[0..ns]}[#{a},#{a+b}]#{line[i+1..-1]}
  " if debug
  return line[0..ns] + "[#{a},#{a+b}]" + line[i+1..-1]
end

debug = ARGV[1] == 'd'

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
    puts "i:#{i}, line:#{line}"
    ch = line[i]

    if ch == '['
      lb += 1
      explode = true if lb - rb == 5
      puts "- open  : #{ch}, explode: #{explode ? 'Yes' : 'No'}" if debug
      nums = [] if nums.length > 0
    elsif ch == ']'
      puts "- close : #{ch}" if debug
      rb += 1
      if n != '' && nums.length == 1 && explode
        nums << n.to_i
        line = explode(i, num_start, nums, line, debug)
        # reset vars
        i = -1
        nums = []
        lb = 0
        rb = 0
        num_start = 0
        explode = false
      end
      n = ''
    elsif ch == ','
      puts "- comma : #{ch}" if debug
      if n != ''
        nums << n.to_i
        n = ''
      end
    else
      num_start = i-1 if nums.length == 0 && explode
      puts "- number: #{ch}, n: #{n}, num_start:#{num_start}, exploding?: #{explode}" if debug
      if n == ''
        n = ch
      else
        n += ch
      end
      if n.to_i > 9
        line = split_number(i - n.length, i, n, line, debug)
        # reset vars
        i = -1
        nums = []
        lb = 0
        rb = 0
        num_start = 0
        n = ''
      end
    end

    pause if debug
    
    i += 1
  end

  puts "start_line:#{start_line}, line:#{line}"
  pause
end
