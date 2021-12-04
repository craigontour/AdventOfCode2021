
filename =  ARGV[0] == 't' ? 'test.txt' : 'input.txt'

g = []
e = []

def getMostCommon(str)
  str.count('0') > str.count('1') ? '0' : '1'
end

File.readlines(filename).
  map(&:chomp).
  map(&:chars).
  transpose.
  map(&:join).
  each_with_index do |line, index|
    # pp index
    pp line

    g[index] = line.count('0') > line.count('1') ? '0' : '1'
    e[index] = line.count('0') > line.count('1') ? '1' : '0'
  end

pp g.join.to_i(2)
pp e.join.to_i(2)

pp g.join.to_i(2) * e.join.to_i(2)