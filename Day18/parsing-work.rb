
def updateLeft(num, i, oldline)
  lhs = oldline.dup
  rhs = ''
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
      " if @debug
      return lhs[0..j-1] + nn + rhs.reverse
    end
  end
  return rhs.reverse
end

def updateRight(num, oldi, oldline)
  rhs = oldline.dup
  i = oldi.dup
  lhs = ''
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
      " if @debug
      return lhs + nn + rhs[j+1..-1]
    end
  end
  return lhs
end

def explode(i, ns, nums, line)
  puts "explode: #{nums}"
  ul = updateLeft(nums[0], ns, line, @debug)
  pause
  ur = updateRight(nums[1], i, line, @debug)

  puts "-- explode: #{nums}
  line: #{line}
  to  : #{ul + '0' + ur}
  "
  pause
  return ul + '0' + ur
end


br += 1
explode = true if br == 5
nums = [] if nums.length > 0
elsif ch == ']'
br -= 1
if n != '' && nums.length == 1 && explode
  nums << n.to_i
  line = explode(i, num_start, nums, line, debug)
  # reset vars
  i = -1
  nums = []
  br = 0
  num_start = 0
  explode = false
end
n = ''
elsif ch == ','
if n != ''
  nums << n.to_i
  n = ''
end
else
num_start = i-1 if nums.length == 0 && explode
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
  br = 0
  num_start = 0
  n = ''
end
