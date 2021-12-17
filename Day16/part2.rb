start = Time.now()
@values = []

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def getInput(f)
  line = File.read("#{f}.txt")
  packet = line.chomp.hex.to_s(2).rjust(line.length*4, '0')
  # puts "line: #{line}\npacket: #{packet}\n"
  return packet
end

def processLiteral(packet)
  subpacket = packet[6..]
  
  done = false
  literal = ''
  while !done do
    done = true if subpacket[0] == '0'
    literal += subpacket[1..4]
    subpacket = subpacket[5..]
  end
  
  return subpacket, literal.to_i(2)
end

OPERATORS = { 0=>'sum', 1=>'product', 2=>'min', 3=>'max', 5=>'greater', 6=>'less than', 7=>'equal'}

def processPacket(packet)
  typeid = packet[3..5].to_i(2)
  op_code = packet[6].to_i(2)

  puts "processPacket\npacket: #{packet}\ntypeid: #{typeid}\nop_code:#{op_code}\n\n"

  if typeid == 4
    packet, value = processLiteral(packet)
    puts "4: literal\npacket: #{packet}\nvalue: #{value}\n"
  elsif typeid >= 0 && typeid < 8
    puts "typeid: #{typeid}, #{OPERATORS[typeid]}\n",''
    if op_code == 0
      packet, value = processPacket(packet[22..])
    else
      packet, value = processPacket(packet[18..])
    end
  else
    puts "ERROR: unsupported typeid:#{typeid}. Exiting!"
    exit
  end

  return packet, value
end

def part2(packet)
  while packet.length >= 11 do
    packet, value = processPacket(packet)
    
    @values << value if !value.nil?
    pp @values

    pause
  end
end

puts "Part2: #{part2(getInput(ARGV[0]))}"
