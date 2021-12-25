start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end


if ARGV[0] == 't'
  players = [ 
    { "start" => true, "position" => 4, "score" => 0 },
    { "start" => true, "position" => 8, "score" => 0 },
  ]
else
  players = [ 
    { "start" => true, "position" => 7, "score" => 0 },
    { "start" => true, "position" => 3, "score" => 0 },
  ]
end

puts players

def roll(u)
  # u is 1, 2 or 3

end

def main
  while players.all? { |h| h['score'] <= 21 } do
    roll(1)
    roll(2)
    roll(3)
  end
end