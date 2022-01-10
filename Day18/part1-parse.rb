start = Time.now()

@debug1 = ARGV[1] == '1'
@debug2 = ARGV[1] == '2'

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
      return lhs + nn + rhs[j..-1]
    else
      lhs += ch
    end
    j += 1
  end

  return rhs
end

def explode(i, nums, line)
  left = line[0..i-(nums.join().length+2)]
  right = line[i+1..-1]

  line2 = updateLeft(left, nums[0]) + '0' + updateRight(right, nums[2])

  puts "explode:
  i    : #{i}
  nums : #{nums}
  nums.length+1: #{nums.length+1}
  nums.join().length+1: #{nums.join().length+1}
  line : #{line}
  left : #{left}
  right: #{right}

  to   : #{line2}
  "
  pause

  return true, line2
end

def split_number(i, num, line)
  a, b = num.to_i.divmod(2)  
  line2 = line[0..i-num.length] + "[#{a},#{a+b}]" + line[i+1..-1]

  puts "split:
  line: #{line}
  to  : #{line2}
  "
  pause

  return line2
end

input = File.readlines("#{ARGV[0]}.txt").map(&:chomp)
line = input[0]

(1..input.length-1).each do |l|
  puts "--------------------"
  line = '[' + line + ',' + input[l] + ']'
  line_before = line.dup

  i = 0
  nums = []
  br = 0
  reduced = false
  go_split = false
  splitter = false

  while i < line.length-1 do
    ch = line[i]

    if ch == '['
      br += 1
      nums = []
    elsif ch == ']'
      reduced, line = explode(i, nums, line) if br > 4 && nums.length > 1
      br -= 1
      nums = []
    elsif ch == ','
      nums << ch if nums.length > 0
    else
      if nums.length % 2 == 0
        nums << ch
      elsif nums.length == 1
        nums[0] = nums[0] + ch
        if nums[0].to_i > 9
          if go_split
            line = split_number(i, nums[0], line)
            reduced = true
          else
            splitter = true
          end
        end
      elsif nums.length == 3    
        nums[2] = nums[2] + ch
        if nums[2].to_i > 9
          if go_split
            line = split_number(i, nums[2], line)
            reduced = true
          else
            splitter = true
          end
        end
      end
    end

    if reduced
      i = 0
      nums = []
      br = 0
      reduced = false
      go_split = false
      splitter = false
    else
      i += 1
    end

    if i == line.length-1 && splitter
      i = 0
      nums = []
      br = 0
      reduced = false
      go_split = true
      puts "go_split"
    end
  end

  puts "reduced:
  line: #{line_before}
  to  : #{line}"
  pause
end
