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
  puts "updateLeft: (no number)
  lhs : #{lhs}
  "
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
      puts "updateRight:
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
  puts "updateRight: (no number)
  rhs : #{rhs}
  "
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

def check_numbers(i, br, nums, line)
  puts "check_numbers:
  i: #{i}
  br: #{br}
  nums: #{nums}
  " if @debug
  
  if br > 4 && nums.length > 1
    line2 = explode(line[0..i-(nums.length)-2], nums, line[i+1..-1])
  
    puts "explode:
    line: #{line}
    to  : #{line2}
    " if @debug
  
    return true, line2
  elsif nums.length > 0
    nums.join().split(',').each do |num|
      puts "num: #{num} in nums: #{nums}"
      if num.to_i > 9
        puts "split_number:
        i: #{i}
        nums.length: #{nums.join().length+1}
        i-(num.length)-1: #{i-(nums.join().length+1)}
        line[0..(i-(num.length)-1)] : #{line[0..i-(nums.join().length+1)]}
        line[i..-1]                 : #{line[i..-1]}
        "
        return true, line[0..i-(nums.join().length+1)] + split_number(num.to_i) + line[i..-1]
      end
    end
  end
  return false, line
end

def split_number(i, num, line)
  a, b = num.to_i.divmod(2)
  puts "split_number:
  i: #{i}, num: #{num}, a: #{a}, b: #{b}
  num.length              : #{num.length}
  i-(num.length)          : #{i-num.length}
  line[0..(i-num.length)] : #{line[0..i-num.length]}
  line[i+1..-1]           : #{line[i+1..-1]}
  "
  return true, line[0..i-num.length] + "[#{a},#{a+b}]" + line[i+1..-1]
end

input = File.readlines("#{ARGV[0]}.txt").map(&:chomp)
line = input[0]

(1..input.length-1).each do |l|
  puts "--------------------"
  line = '[' + line + ',' + input[l] + ']'
  line_before = line.dup
  line = '[[[[0,7],4],[15,[0,13]]],[1,1]]'

  i = 0
  nums = []
  br = 0
  reduced = false

  while i < line.length-1 do
    ch = line[i]
    puts "i:#{i} | ch:#{ch} | br:#{br} | line:#{line}" if @debug
    pause if @debug

    if ch == '['
      # reduced, line = check_numbers(i, br, nums, line) if nums.length > 1
      br += 1
      nums = []
    elsif ch == ']'
      reduced, line = explode(i, br, nums, line) if nums.length > 1
      br -= 1
      nums = []
    elsif ch == ','
      nums << ch if nums.length > 0
    else
      if nums.length % 2 == 0
        # [] or ['1', ','] - add number to list
        nums << ch
      elsif nums.length == 1
        # e.g. ["1"] - concat number to element
        nums[0] = nums[0] + ch
        puts "number on left :\n  nums   : #{nums}\n  nums[0]: #{nums[0]}\n  split  : #{nums[0].to_i > 9}"
        reduced, line = split_number(i, nums[0], line) if nums[0].to_i > 9
      elsif nums.length == 3
        # e.g. ["11", ",", "1"] - concat number to last element
        nums[2] = nums[2] + ch
        puts "number on right:\n  nums: #{nums}\n  nums[2]: #{nums[2]}\n  split: #{nums[2].to_i > 9}"
        reduced, line = split_number(i, nums[2], line) if nums[2].to_i > 9
      end

      # Different cases:-
      #   15,
      # nums.length = 2
      # nums.join.split(',')

      #   ,11
      # nums.length = 2

      #   0,10
      # nums.length = 3

      #   12,3
      # nums.length = 3
    end

    if reduced
      puts "
      reset the variables...
      "
      i = 0
      nums = []
      br = 0
      reduced = false
    else
      i += 1
    end
  end

  puts "reduced:
  line: #{line_before}
  to  : #{line}"
  pause
end
