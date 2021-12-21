start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

players = []

File.readlines("#{ARGV[0]}.txt").each do |line|
  parts = line.chomp.split(' ')
  players << { 'start' => true, 'position' => parts[4].to_i, 'score' => 0 }
end

puts players

currentplayer = 0

rolls = 0
r = 1
nextr = 0

while players.all? { |h| h['score'] <= 21 } do
  if r < 98
    roll = (r..(r+2)).inject(&:+)
    nextr = r + 3
  elsif r == 98
    roll = 297 # 98 + 99 + 100
    nextr = 1
  elsif r == 99
    roll = 200 # 99 + 100 + 1
    nextr = 2
  elsif r == 100
    roll = 103 # 100 + 1 + 2
    nextr = 3
  else
    puts "Error: #{r} not accounted for."
    exit
  end
  rolls += 1

  start = players[currentplayer]['start']
  pos = players[currentplayer]['position']
  newpos = (((pos-1) + roll) %  10) + 1

  puts "
  - Player #{currentplayer+1} rolls #{r..(r+2)} (#{roll}) and moves from #{pos} to #{newpos} total score: #{players[currentplayer]['score'] + newpos}"

  players[currentplayer]['start'] = false if players[currentplayer]['start']
  players[currentplayer]['position'] = newpos
  players[currentplayer]['score'] += newpos

  if players[currentplayer]['score'] >= 1000
    puts "Part 2:"
    puts players
    puts ''
    puts (players.min_by { |k, v| k['score'] })['score'] * rolls * 3
    exit
  end

  # Switch players
  currentplayer = (currentplayer + 1) % 2
  r = nextr

  pause
end
