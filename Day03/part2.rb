filename =  ARGV[0] == 't' ? 'test.txt' : 'input.txt'

oxy_gen = []
co_scrub = []

input = File.readlines(filename).map(&:chomp)

def mostCommon(line, bit)
  # puts "bit: #{bit}, count(#{bit}): #{line.count(bit.to_s)}, count(#{(bit-1).abs}): #{line.count((bit-1).abs.to_s)}, result: #{line.count((bit-1).abs.to_s) > line.count(bit.to_s) ? (bit-1).abs : bit }"

  return line.count((bit-1).abs.to_s) > line.count(bit.to_s) ? (bit-1).abs.to_s : bit.to_s
end

def leastCommon(line, bit)
  return line.count((bit-1).abs.to_s) < line.count(bit.to_s) ? (bit-1).abs.to_s : bit.to_s
end

def dodata(data, i, bit)
  newdata = []
  
  line = data.map(&:chars).transpose.map(&:join)[i]
  x = (bit == 1) ? mostCommon(line, bit) : leastCommon(line, bit)
  # puts "line: #{line}, winner: #{x}"

  data.each do |l|
    # puts "dodata > i: #{i}, l: #{l}"
    if l[i] == x
      newdata << l
    end
  end
  return newdata
end

def main(data, bit)
  i = 0
  while data.length > 1 do
    # puts "main > i: #{i}, data: #{data}"
    
    data = dodata(data, i, bit)
    i += 1
  end
  return data[0].to_i(2)
end

pp main(input, 1) * main(input, 0)
