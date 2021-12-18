
def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

ans = []

File.readlines('answers.txt').each do |line|
  # pp line,''
  # pp line.chomp.split(' '),''
  ans += line.chomp.split(' ')
end

puts ans.sort
