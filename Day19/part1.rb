def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

AXES = ['x', 'y', 'z']
ANGLES = [0, 90, 180, 270]

transforms = [
  [1, 2, 3], [1, 2, -3], [1, -2, 3], [1, -2, -3],
  [1, 3, 2], [1, -3, 2], [1, 3, -2], [1, -3, -2],
  [-1, 2, 3], [-1, 2, -3], [-1, -2, 3], [-1, -2, -3],
  [-1, 3, 2], [-1, -3, 2], [-1, 3, -2], [-1, -3, -2],
  [3, 2, 1], [-3, 2, 1], [3, 2, -1], [-3, 2, -1],
  [3, -2, 1], [-3, -2, 1], [3, -2, -1], [-3, -2, -1],
  [2, 1, 3], [-2, 1, 3], [2, -1, 3], [-2, -1, 3],
  [2, 1, -3], [-2, 1, -3], [2, -1, -3], [-2, -1, -3],
]

def rotateX(coord, deg)
  c = []
  case deg
  when 0
    c = coord
  when 90
    c = [coord[0], coord[2], -coord[1]]
  when 180
    c = [coord[0], -coord[1], -coord[2]]
  when 270
    c = [coord[0], -coord[2], coord[1]]
  end
  # puts "Rotate in X, coord:#{coord} => #{c}"
end

def rotateY(coord, deg)
  c = []
  case deg
  when 0
    c = coord
  when 90
    c = [coord[2], coord[1], -coord[0]]
  when 180
    c = [-coord[0], coord[1], -coord[2]]
  when 270
    c = [-coord[2], coord[1], coord[0]]
  end
  # puts "Rotate in Y, coord:#{coord} => #{c}"
end

def rotateZ(coord, deg)
  c = []
  case deg
  when 0
    c = coord
  when 90
    c = [coord[1], -coord[0], coord[2]]
  when 180
    c = [-coord[0], -coord[1], coord[2]]
  when 270
    c = [-coord[1], coord[0], coord[2]]
  end
  # puts "Rotate in Z, coord:#{coord} => #{c}"
end

def rotate(i, flip, coord, axis, deg)
  coord[i] = -coord[i] if flip == -1
  case axis
  when 'x'
    return rotateX(coord, deg)
  when 'y'
    return rotateY(coord, deg)
  when 'z'
    return rotateZ(coord, deg)
  end
end

def getOrientations(beacons)
  orientations = []

  AXES.each_with_index do |axis, i|
    ANGLES.each do |deg|
      new_beacons = []
      beacons.each do |beacon|
        new_beacons << rotate(i, flip, beacon, axis, deg)
        # puts "Rotate #{beacon} in #{axis} axis by #{deg} degrees is #{new_beacons}."
      end
      orientations << new_beacons
    end
  end

  return orientations
end

def display_orientation(orientation)
  orientation.each do |beacon|
    pp beacon
  end
  puts ' -- --- --'
end

beacons = []
scanners = {}

File.open("#{ARGV[0]}.txt").read.split("\n\n").map(&:chomp).each do |scanner|
  scannerId = 0
  scanner.split("\n").each do |line|
    if line.match('scanner\s(\d+)\s')
      scannerId = line.match('scanner\s(\d+)\s').captures[0]
      next
    else
      beacons << line.split(',').map(&:to_i)
    end
  end

  scanners[scannerId] = getOrientations(beacons)
end

scanners.keys.each do |i|
  orientations = scanners[i]
  puts "scanner #{i} has #{orientations.length} orientations"
  orientations.each_with_index do |orientation|
    display_orientation(orientation)
  end
end

exit

transforms = [
  # x
  [1, 2, 3], [1, 2, -3], [1, -2, 3], [1, -2, -3], [1, 3, 2], [1, -3, 2], [1, 3, -2], [1, -3, -2],
  [-1, 2, 3], [-1, 2, -3], [-1, -2, 3], [-1, -2, -3], [-1, 3, 2], [-1, -3, 2], [-1, 3, -2], [-1, -3, -2],
  #  y
  [1, 2, 3], [1, 2, -3], [-1, 2, 3], [-1, 2, -3], [3, 2, 1], [-3, 2, 1], [3, 2, -1], [-3, 2, -1],
  [1, -2, 3], [1, -2, -3], [-1, -2, 3], [-1, -2, -3], [3, -2, 1], [-3, -2, 1], [3, -2, -1], [-3, -2, -1],
  # z
  [1, 2, 3], [1, -2, 3], [-1, 2, 3], [-1, -2, 3], [2, 1, 3], [-2, 1, 3], [2, -1, 3], [-2, -1, 3],
  [1, 2, -3], [1, -2, -3], [-1, 2, -3], [-1, -2, -3], [2, 1, -3], [-2, 1, -3], [2, -1, -3], [-2, -1, -3],
]

# APPENDIX

=begin
    X =>
      [0, 1, 2], [0, 1, -2], [0, -1, 2], [0, -1, -2],
      [0, 2, 1], [0, 2, -1], [0, -2, 1], [0, -2, -1]

# pp rotateX([8,2,7], 0)    # 0   : [8,2,7]     [x,y,z]
# pp rotateX([8,2,7], 270)  # -90 : [8,-7,2]    [x,y,-z]
# pp rotateX([8,2,7], 270)  # -90 : [8,-7,2]    [x,-y,z]
# pp rotateX([8,2,7], 180)  # +180: [8,-2,-7]   [x,-y,-z]
# pp rotateX([8,2,7], 90)   # +90 : [8,7,-2]    [x,z,y]
# pp rotateX([8,2,7], 90)   # +90 : [8,7,-2]    [x,z,-y]
# pp rotateX([8,2,7], 270)  # -90 : [8,-7,2]    [x,-z,y]
# pp rotateX([8,2,7], 270)  # -90 : [8,-7,2]    [x,-z,-y]

# pp rotateX([-8,2,7], 0)   # 0   : [-8,2,7]    [-x,y,z]
# pp rotateX([-8,2,7], 90)  # +90 : [-8,7,-2]   [-x,z,-y]
# pp rotateX([-8,2,7], 180) # +180: [-8,-2,-7]  [-x,-y,-z]
# pp rotateX([-8,2,7], 270) # -90 : [-8,-7,2]   [-x,-z,y]
# pp rotateX([-8,2,7], 270) # -90 : [-8,-7,2]   [-x,-z,-y]
# pp rotateX([-8,2,7], 270) # -90 : [-8,-7,2]   [-x,y,-z]

-2, -3, 1 => 2, -1, 3
x,  y,  z => -x, -z, -y

# pp rotateY([8,2,7], 0)    # 0   : [8,2,7]     [x,y,z]
# pp rotateY([8,2,7], 90)   # +90 : [7,2,-8]    [z,y,-x]
# pp rotateY([8,2,7], 180)  # +180: [-8,2,-7]   [-x,y,-z]
# pp rotateY([8,2,7], 270)  # -90 : [-7,2,8]     [-z,y,x]

# pp rotateY([8,-2,7], 0)   # 0   : [8,-2,7]    [x,-y,z]
# pp rotateY([8,-2,7], 90)  # +90 : [7,-2,-8]   [z,-y,-x]
# pp rotateY([8,-2,7], 180) # +180: [-8,-2,-7]  [-x,-y,-z]
# pp rotateY([8,-2,7], 270) # -90 : [-7,-2,8]    [-z,-y,x]


# puts "Rotate in Z:"
# pp rotateZ([8,2,7], 0)    # 0   : [8,2,7]     [x,y,z]
# pp rotateZ([8,2,7], 90)   # +90 : [2,-8,7]    [y,-x,z]
# pp rotateZ([8,2,7], 180)  # +180: [-8,-2,7]   [-x,-y,z]
# pp rotateZ([8,2,7], 270)  # -90 : [-2,8,7]     [-y,x,z]

# pp rotateZ([8,2,-7], 0)   # 0   : [8,2,-7]    [x,y,-z]
# pp rotateZ([8,2,-7], 90)  # +90 : [2,-8,-7]   [y,-x,-z]
# pp rotateZ([8,2,-7], 180) # +180: [-8,-2,-7]  [-x,-y,-z]
# pp rotateZ([8,2,-7], 270) # -90 : [-2,8,-7]    [-y,x,-z]
