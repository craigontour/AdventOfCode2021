start = Time.now()

f = ARGV[0] == 't' ? 'test' : 'input'

def pause
  puts "pause..."
  exit if STDIN.gets.chomp == 'x'
end

digits = []

def getCharsOfDigit(digits, value)
  digits.each do |k, v|
    return k.chars if v == value
  end
end

total = 0

File.readlines("#{f}.txt").map(&:strip).each do |line|
  l, r = line.chomp.split(' | ')
  
  digits = {}

  l.split(' ').sort_by {|x| x.length}.each do |signal|
    len = signal.length
    digit = signal.chars.sort.join('')
    # puts "signal: #{signal}, len: #{len}, digit: #{digit}"
    case len
    when 2
      digits[digit] = 1
    when 3
      digits[digit] = 7
    when 4
      digits[digit] = 4
    when 7
      digits[digit] = 8
    when 5
      if (getCharsOfDigit(digits, 7) - signal.chars) == []
        digits[digit] = 3
      elsif (signal.chars - getCharsOfDigit(digits, 4)).length == 2
        digits[digit] = 5
      else
        digits[digit] = 2
      end
    when 6
      if (signal.chars.sort - getCharsOfDigit(digits, 4)).length == 2
        digits[digit] = 9
      elsif (signal.chars.sort - getCharsOfDigit(digits, 5)).length == 1
        digits[digit] = 6
      else
        digits[digit] = 0
      end
    else
      digits[digit] = 8
    end
    # digits[digit] = signal.chars.sort.join('')
  end

  # puts "digits: #{digits}"

  output = ''
  r.split(' ').each do |signal|
    output += digits[signal.chars.sort.join('')].to_s
  end
  total += output.to_i
end

puts "Part 2 (Mark style): #{total} in #{Time.now - start} sec."