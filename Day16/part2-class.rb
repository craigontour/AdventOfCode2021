start = Time.now()

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

class Packet
  attr_accessor :version, :typeid, :operator, :rest, :value, :children, :parent

  def initialize (packet, parent = [])
    @bits = packet
    @parent = parent
    @children = []

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

def processLiteral(pkt)
  puts "-- Literal: packet: #{pkt}",''
  
  done = false
  literal = ''
  while !done do
    done = true if pkt[0] == '0'
    literal += pkt[1..4]
    pkt = pkt[5..]
  end
  pkt.value = literal.to_i(2)

  return pkt
end

def processPacket(pkt)
  typeid = packet[3..5].to_i(2)
  op_code = packet[6].to_i(2)

  puts "processPacket\npacket: #{packet}\ntypeid: #{typeid}\nop_code:#{op_code}\n\n"

  pause
  if [0,1,2,3,5,6,7].include?(typeid)
    if op_code == 0
      child_pk = Packet.new(packet[22..], pkt)
    else
      child_pk = Packet.new(packet[18..], pkt)
    end
  elsif typeid == 4
    puts "4 : literal value"
    lit_pkt = Packet.new(packet[6..], pkt)
    pause

  end

packets = []

def part2(packet)
  pkt = Packet.new(packet)
  processPacket(pkt)
  bits = pkt.rest
  packets << pkt
end

puts "Part2: #{part2(getInput(ARGV[0]))}"
