start = Time.now()
@stack = []

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
  @stack << literal.to_i(2)

  return subpacket
end

OPERATORS = { 0=>'+', 1=>'*', 2=>'min', 3=>'max', 5=>'>', 6=>'<', 7=>'='}

def processPacket(packet)
  typeid = packet[3..5].to_i(2)
  op_code = packet[6].to_i(2)

  if typeid == 4
    packet = processLiteral(packet)
  elsif typeid >= 0 && typeid < 8
    puts "STACKED: #{OPERATORS[typeid]}"
    @stack << OPERATORS[typeid]
     
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

values = @stack

def reverse_polish(stack)
  numbers = el = []

  for i in (stack.length-1).downto(0) do
    
    el = stack[i]
    puts "i: #{i}, el: #{el}"

    if ['+','*','min','max','>','<','=='].include?(el)
      case el
      when '+'; pp numbers.inject(&:+); v = numbers.inject(&:+)
      when '*'; pp numbers.inject(&:*); v = numbers.inject(&:*)
      when 'min'; pp numbers.min; v = numbers.min
      when 'max'; pp numbers.max; v = numbers.max
      when '>'; if numbers[0] > numbers[1]
                  pp 1; ; v = 1
                else
                  pp 0; v = 0
                end
      when '<'; if numbers[0] < numbers[1]
                  pp 1; v = 1
                else
                  pp 0; v = 0
                end
      when '='; if numbers[0] == numbers[1]
                  pp 1; v = 1
                else 
                  pp 0; v = 0
                end
      end

      puts "operator: #{el} | v: #{v}"
      numbers = []
      stack = stack[0..(i-1)]
      stack += [v]
    else
      numbers += [el]
      stack = stack[0..(i-1)]
    end
    puts "numbers: #{numbers}"
    puts "i: #{i}\nstack: #{stack}"
    pause('-----------------------')
  end
end

reverse_polish(values)
