start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

input = File.readlines("input.txt").map(&:strip)

xs = [13, 11, 14, -5, 14, 10, 12, -14, -8, 13, 0, -5, -9, -1]
ys = [0, 3, 8, 5, 13, 9, 6, 1, 1, 2, 7, 5, 8, 15]
zs = [1, 1, 1, 26, 1, 1, 1, 26, 26, 1, 26, 26, 26, 26]

# 99999999999999.downto(11111111111111).each do |num|
(11111111111111..99999999999999).each do |num|
  m = num.to_s
  next if m.include?('0')

  x = 0
  y = 0
  z = 0
  
  (0..13).each do |i|
    w = m[i].to_i
    x = (((z % 26) + xs[i]) == w ? 1 : 0) == 0 ? 1 : 0
    z2 = z / zs[i]
    y1 = (25 * x) + 1
    z1 = z2 * y
    y = (w + ys[i]) * x
    z += y
    
    if z == 0
      puts "#{m} - w: #{w}, x: #{x}, y: #{y}, z: #{z}"
    else
    end
  end
  puts num if num / 10000000000000 > 1
end
