start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

debug = ARGV[0].nil? ? 0 : ARGV[0].to_i

input = File.readlines("input.txt").map(&:strip)

i = 0
modelno = 99999999999999
modelnumbers = []
OPERATORS = { 'add' => '+', 'mul' => '*', 'div' => '/', 'mod' => '%', 'eql' => '==' }
NUMBERS = ['1', '2', '3', '4', '5', '6', '7', '8', '9']

# 99999999999999.downto(11111111111111).each do |m|
9.downto(1).each do |m|
  # modelNoStr = m.to_s
  # next if modelNoStr.include?('0')
  # puts "modelno: #{m}",''

  i = 0
  vars = { 'w' => 0, 'x' => 0, 'y' => 0, 'z' => 0 }

  input.each do |line|
    op, v1, v2  = line.split(' ')

    if v2.nil?
      vars[v1] = m #modelNoStr[i].to_i
      puts "vars: #{vars}"
      # puts "i: #{i}, vars[#{v1}]: #{vars[v1]}"
      i += 1
    else
      if vars.keys.include?(v2)
        v2 = vars[v2]
      else
        v2 = v2.to_i
      end
      
      if op == 'eql'
        # puts ">> #{v1} = #{vars[v1]} #{op} #{v2} = #{(vars[v1]).method(OPERATORS[op]).(v2) ? 1 : 0}"
        vars[v1] = (vars[v1]).method(OPERATORS[op]).(v2) ? 1 : 0
      else
        # puts ">> #{v1} = #{vars[v1]} #{OPERATORS[op]} #{v2} => #{(vars[v1]).method(OPERATORS[op]).(v2)}"
        vars[v1] = (vars[v1]).method(OPERATORS[op]).(v2)
      end
    end
    # puts "vars: #{vars}"
    # pause
  end

  if vars['z'] == 0
    puts "modelNo: #{modelNoStr.to_i}"
    exit
    modelnumbers << modelNoStr.to_i
  end
  # pause
end

# pp modelnumbers
# pp modelnumbers.length
# pp modelnumbers.sort[-1]