start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def getInput(f)
  tx, ty = []
  File.readlines("#{f}.txt").each do |line|
    pp line
    tx, ty = line.split(':')[1].split(',')
    tx = tx.split('=')[1].split('..').map(&:to_i)
    ty = ty.split('=')[1].split('..').map(&:to_i)
  end
  # pp tx
  # pp ty
  return tx, ty
end

def hit_target(x, y, tx, ty)
  if x >= tx[0] && x <= tx[1] && y >= ty[0] && y <= ty[1]
    return true #puts "[#{x},#{y}] in target"
  else
    return false #puts "[#{x},#{y}] NOT hit target"
  end
end

def do_velocity(vx, vy, tx, ty)
  x = 0
  y = 0

  while !hit_target(x, y, tx, ty) do
    x = x + vx
    y = y + vy

    if hit_target(x, y, tx, ty)
      # puts "Hit the target at [#{x}, #{y}]"
      return [[x, y]]
    elsif x > tx[1] || y < ty[0]
      # puts "gone past | x:#{x}, y:#{y} | velocity: [#{vx}, #{vy}]"
      return []
    end
    
    if vx > 0
      vx -= 1
    elsif vx < 0
      vx += 1
    end
    vy -= 1

    # puts "x:#{x}, y:#{y} | velocity: [#{vx}, #{vy}]"
  end
end

tx, ty = getInput(ARGV[0])
velocities = {}

(-500..500).each do |vx|
  (-500..500).each do |vy|
    v = do_velocity(vx, vy, tx, ty)
    # puts "velocity: [#{vx}, #{vy}] : #{v}"
    velocities[[vx, vy]] = v if !v.empty?
    # pause
  end
end

# pp velocities.map { |k,v| k }
puts velocities.count
