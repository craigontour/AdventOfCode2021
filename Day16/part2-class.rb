start = Time.now()

class Packet
  attr_accessor :version, :typeid, :operator, :rest, :value

  def initialize (packet)
    @bits = packet

    @version = packet[0..2].to_i(2)
    @typeid = packet[3..5].to_i(2)
    if @typeid == 4
      @rest = packet[6..]
    else
      @operator = packet[6].to_i(2)
      if @operator == 0
        @rest = packet[22..]
      elsif @operator == 1
        @rest = packet[18..]
      else
        raise("ERROR: #{@operator} is unsupported.")
      end
    end
    @value = 0
  end

  def length
    @bits.length
  end

  def restlen
    @rest.length
  end

  def to_s
    puts "
    Parent:
      bits      : #{@bits}
      typeid    : #{@typeid}
      operator  : #{@operator}
      rest      : #{@rest}
    "
  end
end

# pk = Packet.new('1100001000000000101101000000101010000010')
# puts pk.to_s
# puts pk.length
# puts pk.restlen
# puts pk.value
# exit

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

def processOperator(packet)
  values  []

  if packet[6] == '0'
    packet, values = processPacket(packet[22..])

  elsif packet[6] == '1'
    packet, values = processPacket(packet[18..])

  else
    puts "Operator length type id ERROR: #{packet[6]}"
    exit
  end

  puts "processOperator\npacket:#{packet}\nvalue:#{values}\n"
  return packet, values
end

# 0 sum of sub-packets
def sum_of_packets(packet)
  processPacket(packet[6..])
end

def processLiteral(packet)
  puts "-- Literal: packet: #{packet}",''
  
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

def processPacket(pkt)
  typeid = packet[3..5].to_i(2)
  op_code = packet[6].to_i(2)

  puts "processPacket\npacket: #{packet}\ntypeid: #{typeid}\nop_code:#{op_code}"

  pause

  case typeid
  when 0
    puts "0 : sum of sub-packets"
    if op_code == 0
      values += processPacket(packet[22..])
    else
      values += processPacket(packet[18..])
    end
  when 1
    puts "product of sub-packets"
  when 2
    puts "min of sub-packets"
  when 3
    puts "max of sub-packets"
  when 4
    puts "4 : literal value"
    packet, value = processLiteral(packet)
    pause
  when 5
    puts "greater than: 1 if sub-packet[0] > sub-packet[1] else 0"
  when 6
    puts "less than: 1 if sub-packet[0] < sub-packet[1] else 0"
  when 7
    puts "equal to: 1 if sub-packet[0] == sub-packet[1] else 0"
  else
    puts "ERROR: unsupported typeid:#{typeid}. Exiting!"
    exit
  end
  @totalvalues += value
  puts @totalvalues

  return values
end

packets = []

def part2(packet)
  while bits.length > 11 do
    pkt = Packet.new(bits)
    processPacket(pkt)
    bits = pkt.rest
    packets << pkt
  end
end

puts "Part2: #{part2(getInput(ARGV[0]))}"
