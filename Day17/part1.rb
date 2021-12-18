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
  if x >= tx[0] && x <= tx[1] && y <= ty[0] && y >= ty[1]
    return true #puts "[#{x},#{y}] in target"
  else
    return false #puts "[#{x},#{y}] NOT hit target"
  end
end

def do_velocity(vx, vy, tx, ty)
  x = 0
  y = 0
  step = 0
  # vx = 17
  # vy = -4
  maxy = 0

  # puts "x:#{x}, y:#{y}\ntarget: #{tx[0]}, #{ty[0]}"

  # puts "x:#{x}, y:#{y}\nvelocity: [#{vx}, #{vy}]\n"
  while !hit_target(x, y, tx, ty) do
    x = x + vx
    y = y + vy
    maxy = y if y > maxy

    if x >= tx[0] && x <= tx[1] && y >= ty[0] && y <= ty[1]
      # puts "Hit the target at [#{x}, #{y}]"
      return maxy
    elsif x > tx[1] || y < ty[1]
      # puts "gone past"
      return 0
    end
    
    if vx > 0
      vx -= 1
    elsif vx < 0
      vx += 1
    end
    vy -= 1

    # puts "x:#{x}, y:#{y} | velocity: [#{vx}, #{vy}]"
    
    step += 1
  end
end

tx, ty = getInput(ARGV[0])
velocities = {}

(0..tx[1]).each do |vx|
  (200.downto(-200)).each do |vy|
    # puts "velocity: [#{vx}, #{vy}]"
    v = do_velocity(vx, vy, tx, ty)
    velocities[[vx, vy]] = v if v != 0
    # pause
  end
end

# pause

pp velocities.max_by { |k,v| v }
