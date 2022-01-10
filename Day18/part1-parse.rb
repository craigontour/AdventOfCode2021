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

def split_number(num)
  a, b = num.divmod(2)
  return "[#{a},#{a+b}]" + line[i+1..-1]
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

  while i < line.length-1 do
    ch = line[i]
    puts "i: #{i}, ch: #{ch}, br: #{br}, line: #{line}" if @debug
    pause if @debug

    if ch == '['
      br += 1
    elsif ch == ']'
      br -= 1
    elsif ch == ','
      puts "comma"
    else
      puts "number: #{ch}"
      nums << ch
      while line[i+1] != '[' && line[i+1] != ']'
        nums << line[i+1]
        i += 1
      end

      if br > 4 && nums.length > 2
        puts "br: #{br}, nums: #{nums}"
        line2 = explode(line[0..i-(nums.join().length)-1], nums, line[i+2..-1])
        puts "explode:\n  line: #{line}\n  to  : #{line2}\n" #if @debug
        
        line = line2.dup
        i = -1
        br = 0
        nums = []
      elsif nums.length > 0
        nums.join().split(',').each do |num|
          puts "num: #{num} in nums: #{nums}"
          if num.to_i > 9
            puts "split_number:
            i: #{i}
            num: #{num}
            num.length: #{num.length}
            i-(num.length)-1: #{i-(num.length)-1}
            line[0..(i-(num.length)-1)] : #{line[0..(i-(num.length)-1)]}
            line[i..-1]                 : #{line[i..-1]}
            "
            line = line[0..(i-(num.length)-1)] + split_number(num.to_i) + line[i..-1]
            i = -1
            br = 0
          end
        end
      end
    end

    nums = []
    i += 1
  end

  puts "reduced:
  line: #{line_before}
  to  : #{line}"
  pause
end
