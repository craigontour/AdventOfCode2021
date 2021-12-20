start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def getInput(f)
  line = File.read("#{f}.txt")
  return line.chomp.hex.to_s(2).rjust(line.length*4, '0')
end

class Packet
  attr_accessor :bits, :parent, :children, :type_id, :op_code

  def initialize (packet, parent, children)
    @bits = packet
    @parent = parent
    @children = children

    @type_id = @bits[3..5].to_i(2)
    @op_code = @bits[6].to_i(2)
  end

  def length
    @bits.length
  end

  def to_s
    puts "
    Parent:
      bits      : #{@bits}
      parent    : #{@parent}
      children  : #{@children}
    "
  end
end

def processLiteral(pkt)
  subpacket = pkt.bits[6..]

  literal = ''
  done = false

  while !done do
    done = true if subpacket[0] == '0'
    literal += subpacket[1..4]
    subpacket = subpacket[5..]
  end
  pkt.addchild(literal.to_i(2))
  pkt.rest = subpacket
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

def processPacket(pkt)
  pkt.to_s

  if pkt.type_id == 4
    processLiteral(pkt)
  elsif pkt.type_id >= 0 && typeid < 8
    if op_code == 0
      pp = pkt.bits[7..21].to_i(2)
      subs = getSubPacket(getSubPacket(packet[22..(22+pp)]))
      # processPacket(packet[(22+pp)..])
    else
      pp = pkt.bits[7..17].to_i(2)
      processPacket(packet[18..])
    end
  else
    puts "ERROR: unsupported typeid:#{typeid}. Exiting!"
    exit
  end
  
  return pkt
end

def part2(pkt)
  packets = []
  while pkt.length >= 11 do
    pkt = processPacket(pkt)
    packets += []
  end
  return packets
end

pp part2(pkt.new(getInput(ARGV[0]), [], [])
