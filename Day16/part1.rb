start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def getInput(f)
  File.readlines("#{f}.txt").map(&:strip)
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
  
  if subpacket.length > 11
    processPacket(subpacket)
  else
    return
  end
end

def processOperator(packet)
  version = packet[0..2].to_i(2)
  @versions << version

  if packet[6] == '0'
    processPacket(packet[22..])

  elsif packet[6] == '1'
    processPacket(packet[18..])

  else
    puts "Operator length type id ERROR: #{packet[6]}"
    exit
  end
end

def processPacket(packet)
  typeid = packet[3..5].to_i(2)

  if typeid == 4
    processLiteral(packet)
  else
    processOperator(packet)
  end
end


@versions = []
getInput(ARGV[0]).each do |line|

  packet = line.chomp.hex.to_s(2).rjust(line.length*4, '0')
  processPacket(packet)

end

puts "Part 1: #{@versions.flatten.sum}"
