start = Time.now()
@values = []
@total = 0
@operation = 0
@depth = 0

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

OPERATORS = { 0=>'+', 1=>'*', 2=>'min', 3=>'max', 5=>'>', 6=>'<', 7=>'=='}

def processPacket(packet)
  @depth += 1
  typeid = packet[3..5].to_i(2)
  op_code = packet[6].to_i(2)

  if typeid == 4
    packet, value = processLiteral(packet)
  elsif typeid >= 0 && typeid < 8
    if op_code == 0
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

def part2(packet)
  while packet.length >= 11 do
    typeid = packet[3..5].to_i(2)

    puts "\n********* part2 TOP *******\ndepth: #{@depth}\ntypeid: #{typeid}\n"

    packet, value = processPacket(packet)
    
    @values << value if !value.nil?
    # pp @values
    puts "\n******** part2 BOT ********\ndepth: #{@depth}\ntypeid: #{typeid}\nvalue: #{value}\nvalues: #{@values}\n**********************\n"

    pause
  end
  return @values
end

v = part2(getInput(ARGV[0]))

pp v
