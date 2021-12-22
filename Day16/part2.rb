start = Time.now()

OPERATORS = { 0=>'+', 1=>'*', 2=>'min', 3=>'max', 5=>'>', 6=>'<', 7=>'=='}

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def getInput(f)
  File.readlines("#{f}.txt").each do |line|
    return line.chomp.hex.to_s(2).rjust(line.length*4, '0')
  end
end

def processLiteral(s)
  done = false
  literal = ''
  while !done do
    done = true if s[0] == '0'
    literal += s[1..4]
    s = s[5..]
  end
  
  return literal.to_i(2), s
end

def getVersion(s)
  puts "2a getVersion: #{s[0..2].to_i(2)}\n"
  return s[0..2].to_i(2), s[3..]
end

def getType(s)
  puts "2b getType: #{s[0..2].to_i(2)}\n"
  return s[0..2].to_i(2), s[3..]
end

def getLengthTypeId(s)
  opLengthType = s[0].to_i(2)
  puts "2c getOpLength: #{opLengthType}\n"
  return opLengthType, s[1..]
end

def processPacket(packet)
  packet, typeid = getTypeId(packet)
  
  if typeid == 4
    packet, value = processLiteral(packet)
  elsif typeid >= 0 && typeid < 8
    if packet[6].to_i(2) == 0
      packet, value = processPacket(packet[22..])
    else
      packet, value = processPacket(packet[18..])
    end
  else
    puts "ERROR: unsupported typeid:#{typeid}. Exiting!"
    exit
  end
  
  puts "\n-  -  -  -  -  -  -\ndepth: #{@depth}\ntypeid: #{typeid}\nvalue: #{value}\n-  -  -  -  -  -  -\n"

  return packet, value
end

def getValue(type, values)
  case type
  when 0
    puts "sum of #{values}"
    if !values.nil?
      value = values.inject(&:+)
    else
      value = 0
    end
  when 1
    puts "product of #{values}"
    return values.inject(&:*)
  when 2
    puts "minimum of #{values}"
    return values.min
  when 3
    puts "maximum of #{values}"
    return values.max
  when 5
    puts "#{values[0]} > #{values[1]}"
    if values[0] > values[1]
      return 1
    else
      return 0
    end
  when 6
    puts "#{values[0]} < #{values[1]}"
    if values[0] < values[1]
      return 1
    else
      return 0
    end
  when 7
    puts "#{values[0]} == #{values[1]}"
    if values[0] == values[1]
      return 1
    else
      return 0
    end
  else
    puts "Error: type #{type} is unsupported!"
    exit
  end
end

def processA(s, bits)
  values = []
  remainder = s[bits..]

  puts "- process 'A' for #{bits} bits\nremainder: #{remainder}"
  while s.length > 0 do
    puts "-- processA - s.length: #{s[0..bits-1].length}"
    value, s = processStr(s[0..bits-1])
    puts "-- processA - value: #{value}"
    values << value
  end
  return values, s + remainder
end

def processB(s, reps)
  values = []
  
  (0..reps-1).each do |n|
    value, s = processStr(s)
    values << value
    puts "- process 'B'\nrep: #{n+1} of #{reps}\nvalues: #{values}"
  end

  return values, s
end

def processStr(str)
  puts "0 - Processing str: #{str}\nlength: #{str.length}"
  
  value = 0
  version, str = getVersion(str)
  type, str = getType(str)
  
  if type == 4
    puts "1.1 - Literal type: #{type}\nstr length: #{str.length}"
    value, str = processLiteral(str)
    puts "1.2 - Literal value: #{value}\nstr length: #{str.length}"
  else
    puts "1 - Operation type: #{type} (#{OPERATORS[type]})"

    opLengthType, str = getLengthTypeId(str)
    
    if opLengthType == 0
      n = str[0..14].to_i(2)
      puts " - length in bits [0..14]: #{n}\n",'+-+-+-+-+-+-+-+-+-+-+-+-+-+-'
      values, str = processA(str[15..], n)
    else
      n = str[0..10].to_i(2)
      puts " - # of sub-packets [0..10]: #{n}\n"
      values, str = processB(str[11..], n)
    end
    
    value = getValue(type, values)
    puts "#{OPERATORS[type]} on #{values} = #{value}"
  end

  puts "value: #{value}",'------------------------------'  
  return value, str
end

def main(str)
  while str.length >= 11 do
    value, str = processStr(str)
    puts "value: #{value}"
  end
end

processStr(getInput(ARGV[0]))
# main('C200B40A82'.hex.to_s(2))
# main('04005AC33890'.hex.to_s(2).rjust(48,'0'))
# main('880086C3E88112'.hex.to_s(2).rjust(14*4,'0'))
# main(''.hex.to_s(2).rjust(48,'0'))
