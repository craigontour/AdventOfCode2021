start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

# input = File.readlines("input.txt").map(&:strip)

xs = [13, 11, 14, -5, 14, 10, 12, -14, -8, 13, 0, -5, -9, -1]
ys = [0, 3, 8, 5, 13, 9, 6, 1, 1, 2, 7, 5, 8, 15]
zs = [1, 1, 1, 26, 1, 1, 1, 26, 26, 1, 26, 26, 26, 26]

part1 = Hash.new {}
digits = ''

# (2..2).each do |a1|
  (1..9).each do |a2|
    (1..9).each do |a3|
      (1..9).each do |a4|
        (1..9).each do |a5|
          (1..9).each do |a6|
            (1..9).each do |a7|
              (1..9).each do |a8|
                (1..9).each do |a9|
                  (1..9).each do |a10|
                    (1..9).each do |a11|
                      (1..9).each do |a12|
                        (1..9).each do |a13|
                          (1..9).each do |a14|
                            digits = "2#{a2}#{a3}#{a4}#{a5}#{a6}#{a7}#{a8}#{a9}#{a10}#{a11}#{a12}#{a13}#{a14}"
                            # puts "digits: #{digits}"

                            part1['w'] = 0
                            part1['x'] = 0
                            part1['y'] = 0
                            part1['z'] = 0

                            (0..13).each do |i|
                              part1['w'] = digits[i].to_i
                              part1['x'] = (part1['z'] % 26) + xs[i]
                              part1['x'] = part1['x'] == part1['w'] ? 1 : 0
                              part1['x'] = part1['x'] == 0 ? 1 : 0
                              part1['y'] = (25 * part1['x']) + 1
                              part1['z'] = (part1['z'] / zs[i]) * part1['y']
                              part1['y'] = part1['w'] + ys[i]
                              part1['y'] *= part1['x']
                              part1['z'] += part1['y']
                              
                              if part1['z'] == 0
                                puts "digits: #{digits}, i: #{i}, part1: #{part1}"
                                exit
                              end
                            end
                            # pause
                          end
                        end
                      end
                    end
                  end
                end
              end
              puts "digits: #{digits} with z: #{part1['z']} took #{Time.now - start} secs."
            end
          end
        end
      end
    end
  end
# end
