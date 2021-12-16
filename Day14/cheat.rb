def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

input = File.readlines(ARGV[0]).each.map(&:strip).to_a

pairs = Hash.new(0)
input[0].chars.each_cons(2) { |a,b| pairs[[a, b]] += 1 }

rules = input[2..].map{ _1.split(' -> ').map(&:chars).flatten }

# pp "Rules:"
# pp rules,''
# pp "Pairs:"
# pp pairs,''

ARGV[1].to_i.times do
  new_pairs = pairs.clone
  # puts "new_pairs: #{new_pairs}"
  rules.each do |a, b, n|
    # puts "rule #{r} | a: #{a}, b: #{b}, n: #{n}}"
    new_pairs[[a, n]] += pairs[[a, b]]
    # puts "new_pairs[#{a}, #{n}]: #{new_pairs[[a, n]]} += pairs[#{a}, #{b}]: #{pairs[[a, b]]}"
    new_pairs[[n, b]] += pairs[[a, b]]
    # puts "new_pairs[#{n}, #{b}]: #{new_pairs[[n, b]]} += pairs[#{a}, #{b}]: #{pairs[[a, b]]}"
    new_pairs[[a, b]] -= pairs[[a, b]]
    # puts "new_pairs[#{a}, #{b}]: #{new_pairs[[a, b]]} -= pairs[#{a}, #{b}]: #{pairs[[a, b]]}"
  end
  # pause
  pairs = new_pairs
end

# pp pairs

count = Hash.new(0)
count[input[0][-1]] = 1
pairs.each{|k, v| count[k[0]] += v}

# pp count

puts count.values.minmax.reduce(&:-).abs
