start = Time.now()

@debug1 = ARGV[1] == '1'
@debug2 = ARGV[1] == '2'

def pause(m = "pause")
  puts "#{m}..."
  r = STDIN.gets.chomp
  puts "r: #{r}"
  if r == '0'
    @debug1 = false
    @debug2 = false
  elsif r == '1'
    @debug1 = true
  elsif r == '2'
    @debug2 = true
  elsif r == 'x'
    exit
  end
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
      puts "updateLeft:
      lhs : #{lhs}
      num : #{num}
      nn  : #{nn.reverse}
      j   : #{j}
      rhs : #{rhs}
      (nn.reverse.to_i + num.to_i).to_s: #{(nn.reverse.to_i + num.to_i).to_s}
      " if @debug2
      pause if @debug2
      nn = (nn.reverse.to_i + num.to_i).to_s
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
  " if @debug1
  pause if @debug1

  return true, line2
end

def split_number(i, num, line)
  a, b = num.to_i.divmod(2)  
  line2 = line[0..i-num.length] + "[#{a},#{a+b}]" + line[i+1..-1]

  puts "split:
  line: #{line}
  to  : #{line2}
  " if @debug1
  pause if @debug1

  return line2
end

input = File.readlines("#{ARGV[0]}.txt").map(&:chomp)
line = input[0]

def reduce(line)
  i = 0
  nums = []
  br = 0
  reduced = false
  go_split = false

  while i < line.length-1 do
    ch = line[i]

    puts "  - i:#{i}, ch:#{ch}, br:#{br}, #{nums}" if @debug2
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
        puts "  - num: #{ch}, #{nums.length} % 2 == 0" if @debug2
        nums << ch
      elsif nums.length == 1
        puts "  - num: #{ch}, #{nums.length} == 1" if @debug2
        nums[0] = nums[0] + ch
        if nums[0].to_i > 9 && go_split
          puts "go_split:
          i: #{i}
          nums: #{nums[0]}
          line: #{line}
          " if @debug1
          line = split_number(i, nums[0], line)
          reduced = true
        end
      elsif nums.length == 3
        puts "  - num: #{ch}, #{nums.length} == 3" if @debug2
        nums[2] = nums[2] + ch
        if nums[2].to_i > 9 && go_split
          puts "go_split:
          i: #{i}
          nums: #{nums[2]}
          line: #{line}
          " if @debug1
          line = split_number(i, nums[2], line)
          reduced = true
        end
      else
        puts "  - num: #{ch}, #{nums.length}, else not captured" if @debug2
      end
    end

    if reduced
      puts "  - reduced, reset vars" if @debug2
      i = 0
      nums = []
      br = 0
      reduced = false
      go_split = false
      splitter = false
      puts "iteration:
      line: #{line_before}
      to  : #{line}" if @debug1
    else
      i += 1
    end

    puts "line: #{line}
    - is a number > 9: #{line.gsub('[','').gsub(']','').split(',').map(&:to_i).any?{|x| x> 9}}
    " if @debug1
    if i == line.length-1 && line.gsub('[','').gsub(']','').split(',').map(&:to_i).any?{|x| x> 9}
      puts "  - set go_split" if @debug2
      i = 0
      nums = []
      br = 0
      reduced = false
      go_split = true
    end
  end
end

(1..input.length-1).each do |l|
  puts "--------------------"
  line = '[' + line + ',' + input[l] + ']'
  line_before = line.dup

  line = reduce(line)

  puts "reduced:
  line: #{line_before}
  to  : #{line}"
  pause if @debug1
end

# Magnitude

while line.count('[') > 0 do
  m = line.match(/(\[\d+,\d+\])/).captures[0]
  l, r = m.sub('[','').sub(']','').split(',').map(&:to_i)
  sum = (l * 3) + (r * 2)
  line2 = line.sub(m, sum.to_s)
  
  puts "
  line2 : #{line2}
  "

  line = line2
end
