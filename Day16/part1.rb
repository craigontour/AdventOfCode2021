start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def getInput(testing)
  if testing
    File.readlines("test.txt").map(&:strip)
  else
    File.readlines("input.txt").map(&:strip)
  end
end

def processLiteral(packet)
  version = packet[0..2].to_i(2)
  @versions << version
  
  subpacket = packet[6..]
  
  done = false
  literal = ''
  while !done do
    done = true if subpacket[0] == '0'
    literal += subpacket[1..4]
    subpacket = subpacket[5..]
  end

  puts "processLiteral: packet:#{literal}, int:#{literal.to_i(2)}"
  return literal.to_i(2)
end

def getOperator(packet)
  version = packet[0..2].to_i(2)
  @versions << version
  puts "Operator: version:#{version}, length type id: #{packet[6]}"

  if packet[6] == '0'
    # length of the sub-packets in bits
    subLength = packet[7..21].to_i(2)
    puts "packet[7..21]: #{packet[7..21]}, subLength: #{subLength}"

    # repeat ( subLength / 27 ) times
    iterations = subLength / 27
    puts "packet[22..]: #{packet[22..]}, iterations: #{iterations}"
    
    s = 22
    (0..(subLength / 27) -1).each do |t|
      si = s + (t*27)
      se = si + 10
      pl = processLiteral(packet[si..se])
      puts "packet[#{si}..#{se}]: #{packet[si..se]}, pl: #{pl}"

      si = se + 1
      se = si + 15
      pl = processLiteral(packet[si..se])
      puts "packet[#{si}..#{se}]: #{packet[si..se]}, pl: #{pl}"
    end
  elsif packet[6] == '1'
    subPackets = packet[7..17].to_i(2)
    puts "packet[7..17]: #{packet[7..17]}, subPackets: #{subPackets}"

    s = 18
    (0...subPackets).each do |t|
      si = s + (t*11)
      ei = si + 11
      processLiteral(packet[si..ei])
    end
  
  else
    puts "Operator length type id ERROR."
    exit
  end

  puts "packet: #{packet}"
end

def processPacket(packet)
  typeid = packet[3..5].to_i(2)

  if typeid == 4
    # A packet with a type ID of 4 is a literal
    puts "Literal, typeid: #{typeid}"
    processLiteral(packet)
  else
    # Any packet with a type ID other than 4 is an operator
    puts "Operator, typeid: #{typeid}"
    getOperator(packet)
  end
  puts "processed packet: #{packet}, versions: #{@versions}"
  pause
end

@versions = []

# processPacket('110100101111111000101000')
# processPacket('11101110000000001101010000001100100000100011000001100000')

getInput(ARGV[0]).each do |line|
  @versions = []

  packet = line.chomp.hex.to_s(2).rjust(line.length*4, '0')
  puts "line: #{line}, packet: #{packet}", ''
  processPacket(packet)
  
  puts "Final versions: #{@versions}", ''
  pause
end

exit

puts "Part 1: #{@versions}"
