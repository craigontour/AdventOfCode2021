def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

File.readlines("magnitudes.txt").map(&:chomp).each do |line|

  sum = 0
  
  while line.count('[') > 0 do
    m = line.match(/(\[\d+,\d+\])/).captures[0]
    l, r = m.sub('[','').sub(']','').split(',').map(&:to_i)
    sum = (l * 3) + (r * 2)
    line2 = line.sub(m, sum.to_s)
    
    puts "
    line  : #{line}

    m: #{m}
    l     : #{l} => #{l * 3}
    r     : #{r} => #{r * 2}
    sum   : #{(l*3)+(r*2)}

    line2 : #{line2}
    "

    line = line2
  end

  pause
  
end