start = Time.now()

@debug = ARGV[1] == 'd'

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def updateLeft(lhs, num)
  rhs = ''
  nn = ''
  j = lhs.length-1
  
  while j >= 0 do
    ch = lhs[j]
    if ch != '[' && ch != ']' && ch != ','
      while ch != '[' && ch != ']' && ch != ','
        nn += ch
        j -= 1
        ch = lhs[j]
      end
      nn = (nn.to_i + num.to_i).to_s
      puts "updateLeft2:
      j   : #{j}
      lhs : #{lhs}
      num : #{num}
      ul  : #{lhs[0..j] + nn + rhs.reverse}
      " if @debug
      return lhs[0..j] + nn + rhs.reverse
    else
      rhs += ch
    end
    j -= 1
  end
  return lhs
end

def updateRight(rhs, num)
  lhs = ''
  nn = ''
  j = 0

  while j < rhs.length
    ch = rhs[j]
    if ch != '[' && ch != ']' && ch != ','
      while ch != '[' && ch != ']' && ch != ','
        nn += ch
        j += 1
        ch = rhs[j]
      end
      nn = (nn.to_i + num.to_i).to_s
      puts "updateRight2:
      rhs : #{rhs}
      num : #{num}
      ur  : #{lhs + nn + rhs[j..-1]}
      " if @debug
      return lhs + nn + rhs[j..-1]
    else
      lhs += ch
    end
    j += 1
  end
  return rhs
end

def explode(left, nums, right)
  puts "explode:
  left : #{left}
  nums : #{nums}
  right: #{right}
  " if @debug
  return updateLeft(left, nums[0]) + '0' + updateRight(right, nums[2])
end

def split_number(ns, i, n, line)
  a, b = n.to_i.divmod(2)

  puts "-- split number
  line: #{line}
  to  : #{line[0..ns] + "[#{a},#{a+b}]" + line[i+1..-1]}
  " if @debug
  return line[0..ns] + "[#{a},#{a+b}]" + line[i+1..-1]
end

input = File.readlines("#{ARGV[0]}.txt").map(&:chomp)
# line = input[0]

(0..input.length-1).each do |l|
  puts "--------------------"
  line = input[l]
  # line = '[' + line + ',' + input[l] + ']'
  line_before = line.dup

  i = 0
  nums = []
  n = ''
  br = 0

  while i < line.length-1 do
    ch = line[i]
    puts "i: #{i}, ch: #{ch}, br: #{br}, line: #{line}" if @debug
    pause if @debug

    if ch == '['
      br += 1
      if br == 5
        while line[i+1] != '[' && line[i+1] != ']'
          nums << line[i+1]
          i += 1
        end
        if nums.length == 3
          line2 = explode(line[0..i-(nums.join().length)-1], nums, line[i+2..-1])
          line = line2.dup

          puts "explode:
          line: #{line}
          to  : #{line2}
          " if @debug

          i = -1
          br = 0
          nums = []
          n = ''
        else
          n = ''
          nums = []
        end
      end
    elsif ch == ']'
      br -= 1
    end

    i += 1
  end

  puts "reduced:
  line: #{line_before}
  to  : #{line}"
  pause
end
