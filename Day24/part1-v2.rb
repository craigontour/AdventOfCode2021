start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

input = File.readlines("input.txt").map(&:strip)

xs = [13, 11, 14, -5, 14, 10, 12, -14, -8, 13, 0, -5, -9, -1]
ys = [0, 3, 8, 5, 13, 9, 6, 1, 1, 2, 7, 5, 8, 15]
zs = [1, 1, 1, 26, 1, 1, 1, 26, 26, 1, 26, 26, 26, 26]
digits = ''

9876543.downto(5111111).each do |d|

  (1111111..4999999).each do |u|

    digits = d.to_s + u.to_s
    next if digits.include?('0')
    
    i = 0
    w = 0
    x = 0
    y = 0
    z = 0

    14.times do
      # puts "i: #{i}, w = #{digits[i]}"  
      w = digits[i].to_i
      x = z % 26
      z /= zs[i]
      x += xs[i]
      x = x == w ? 1 : 0
      x = x == 0 ? 1 : 0
      y = (25 * x) + 1
      z *= y
      y = w + ys[i]
      y *= x
      z += y

      i += 1
      
      if z == 0
        puts "i: #{i}, w: #{w}, x: #{x}, y: #{y}, z: #{z}"
        exit
      end
    end
  end
  puts "digits: #{digits}"
end
