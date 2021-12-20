start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

File.readlines("#{ARGV[0]}.txt").map(&:chomp).each do |line|
  pp line
  lb = 0
  rb = 0

  line.chars.each_with_index do |ch|
    if ch == '['
      lb += 1
    elsif ch == ']'
      rb += 1
    elsif ch == ','
      next
    else
      if lb > 4
      else
      end
    end
  end
end
