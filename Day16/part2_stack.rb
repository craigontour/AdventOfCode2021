start = Time.now()
@stacked = []

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
  puts "STACKED: #{literal.to_i(2)}"
  @stacked << literal.to_i(2)

  return subpacket
end

OPERATORS = { 0=>'+', 1=>'*', 2=>'min', 3=>'max', 5=>'>', 6=>'<', 7=>'='}

def processPacket(packet)
  typeid = packet[3..5].to_i(2)
  op_code = packet[6].to_i(2)

  if typeid == 4
    packet = processLiteral(packet)
  elsif typeid >= 0 && typeid < 8
    # puts "STACKED: #{OPERATORS[typeid]}"
    @stacked << OPERATORS[typeid]
     
    if op_code == 0
      packet = processPacket(packet[22..])
    else
      packet = processPacket(packet[18..])
    end
  else
    puts "ERROR: unsupported typeid:#{typeid}. Exiting!"
    exit
  end
  
  return packet
end

def part2(packet)
  while packet.length >= 11 do
    packet = processPacket(packet)    
  end
end

part2(getInput(ARGV[0]))

def getOperatorValue(el, numbers)
  # puts "numbers: #{numbers}"

  case el
  when '+'; v = numbers.inject(&:+)
  when '*'; v = numbers.inject(&:*)
  when 'min'; v = numbers.min
  when 'max'; v = numbers.max
  when '>'; if numbers[0] > numbers[1]
              v = 1
            else
              v = 0
            end
  when '<'; if numbers[0] < numbers[1]
              v = 1
            else
              v = 0
            end
  when '='; if numbers[0] == numbers[1]
              v = 1
            else 
              v = 0
            end
  end
  return v, []
end

def reverse_polish(stacked)
  while stacked.length > 0 do
    stack = []
    numbers = []

    stacked.each_with_index do |el, i|
      # puts "el: #{el}"

      if ['+','*']
      elsif ['min','max','>','<','='].include?(el)
        if stacked[i+1].to_i >= 0 && stacked[i+2].to_i >= 0
          numbers << stack.pop << stack.pop
          v, numbers = getOperatorValue(el, numbers)
          stack = stack.push(v)
        else
          stack = stack.push(el)
        end
      else
        stack << el
      end
      # puts "stack: #{stack}"
      # pause('-----------------------')
    end
    stacked = stack
    pp "stacked: #{stacked}, #{stack.length}"
    pause
  end
  pp @stacked
  pause
  return stack[0]
end

puts @stacked

pp reverse_polish(@stacked.reverse)
