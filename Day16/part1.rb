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

input = getInput(ARGV[0])

def getLiteral(packet)
  literal = ''
  vvv = packet[0..2].to_i(2)
  ttt = packet[3..5].to_i(2)
  (6..(packet.length-1)).step(5) do |i|
    bits = packet[i..i+4]
    if bits.length == 5
      literal += bits[1..]
    end
  end
  return literal.to_i(2)
end

def getOperator(packet)
  vvv = packet[0..2].to_i(2)
  ttt = packet[3..5].to_i(2)
  puts "operator: vvv:#{vvv}, ttt:#{ttt}, I:#{packet[6]}"

  if packet[6].to_i == 0
    lll = packet[7..21].to_i(2)
    puts "label: #{lll}, length: #{lll}"

    aaa = packet[22..32]
    puts "sub-packet 1: #{aaa}, literal: #{getLiteral(aaa)}"

    bbb = packet[33..49]
    puts "sub-packet 2: #{bbb}, literal: #{getLiteral(bbb)}"
  else      
    lll = packet[7..17].to_i(2)
    puts "lll: #{packet[7..17]}, literal: #{lll}"

    s = 18
    (0...lll).each do |t|
      si = s + (t*11)
      ei = si + 11
      sub = packet[si..ei]
      puts "sub[#{si}..#{ei}]: #{t} = #{sub}, literal: #{getLiteral(sub)}"
    end
  end
end

input.each do |line|
  packet = line.chomp.hex.to_s(2).rjust(line.length*4, '0')
  ttt = packet[3..5].to_i(2)
  if ttt == 4
    data = getLiteral(packet)
  else
    data = getOperator(packet)
  end
end
