# Build folders and files

# Day1..25 folders
# In each folder:
#   Part1.txt
#   Part2.txt
#   Part1.rb
#   Part2.rb
#   Part1.py
#   Part2.py

(1..25).each do |d|
    dd = d.to_s.rjust(2, '0')
    dir = "/Users/UK32263934/DEV/AdventOfCode2021/Day#{dd}"

    Dir.mkdir(dir) unless File.exists?(dir)

    input_file = "#{dir}/input.txt"
    File.new(input_file, 'w') unless File.exists?(input_file)

    File.new("#{dir}/part1.rb", 'w') unless File.exists?("#{dir}/part1.rb")
    File.new("#{dir}/part2.rb", 'w') unless File.exists?("#{dir}/part2.rb")
    File.new("#{dir}/part1.py", 'w') unless File.exists?("#{dir}/part1.py")
    File.new("#{dir}/part2.py", 'w') unless File.exists?("#{dir}/part2.py")
end
