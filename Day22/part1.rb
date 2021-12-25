require 'set'

start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def getData(f)
  instructions = []
  coords = []
  File.readlines("#{ARGV[0]}.txt").each do |line|
    state, ranges = line.chomp.split(' ')
    coords = ranges.match(/x=(\-?\d+)..(\-?\d+),y=(\-?\d+)..(\-?\d+),z=(\-?\d+)..(\-?\d+)/).captures.map(&:to_i)

    instructions << { state: state, x: [coords[0], coords[1]], y: [coords[2], coords[3]], z: [coords[4], coords[5]] }
  end
  return instructions
end

cubes = Set.new

getData(ARGV[0]).each do |instruction|
  state = instruction[:state]
  x = instruction[:x]
  y = instruction[:y]
  z = instruction[:z]

  # count = ((x[0]-x[1]).abs + 1) * ((y[0]-y[1]).abs + 1) * ((z[0]-z[1]).abs + 1)

  next if x[0].abs > 50 || x[1].abs > 50 || y[0].abs > 50 || y[1].abs > 50 || z[0].abs > 50 || z[1].abs > 50

  (x[0]..x[1]).each do |dx|
    (y[0]..y[1]).each do |dy|
      (z[0]..z[1]).each do |dz|
        on = cubes.include?([dx, dy, dz]) ? true : false
        # puts "#{dx}, #{dy}, #{dz} is on: #{on}, state to be: #{state}"
        
        if state == 'off'
          if cubes.include?([dx, dy, dz])
            cubes.delete([dx, dy, dz])
          end
        else
          cubes << [dx, dy, dz]
        end
      end
    end
  end
end

# puts cubes,''
puts cubes.count,''
