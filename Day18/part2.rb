start = Time.now()

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

def reduce(line)
  i = 0
  nums = []
  br = 0
  reduced = false
  go_split = false

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
        if nums[0].to_i > 9 && go_split
          line = split_number(i, nums[0], line)
          reduced = true
        end
      elsif nums.length == 3
        puts "  - num: #{ch}, #{nums.length} == 3" if @debug2
        nums[2] = nums[2] + ch
        if nums[2].to_i > 9 && go_split
          line = split_number(i, nums[2], line)
          reduced = true
        end
      else
        puts "  - num: #{ch}, #{nums.length}, else not captured" if @debug2
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

    if i == line.length-1 && line.gsub('[','').gsub(']','').split(',').map(&:to_i).any?{|x| x> 9}
      i = 0
      nums = []
      br = 0
      reduced = false
      go_split = true
    end
  end
  return line
end

def magnitude(line)
  while line.count('[') > 0 do
    m = line.match(/(\[\d+,\d+\])/).captures[0]
    l, r = m.sub('[','').sub(']','').split(',').map(&:to_i)
    sum = (l * 3) + (r * 2)
    line2 = line.sub(m, sum.to_s)
    line = line2
  end
  return line.to_i
end

# Main

h = {}
File.readlines("#{ARGV[0]}.txt").map(&:chomp).each_with_index do |line, i|
  h[i] = line
end

mags = []
h.keys.permutation(2).map {|p|
  # puts "lines:
  # #{h[p[0]]}
  # #{h[p[1]]}
  # "
  line = '[' + h[p[0]] + ',' + h[p[1]] + ']'
  mags << magnitude(reduce(line))
}

# Part 2
pp mags.sort.max
