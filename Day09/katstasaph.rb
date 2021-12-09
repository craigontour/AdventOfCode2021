# This is solution from other Adventer:
# https://github.com/katstasaph/adventofcode21/blob/main/advent9.rb

start = Time.now()

ROW_LENGTH = 100

def get_adjacent_values(row, row_index, columns, column_index)
  adjacents = [row[column_index + 1], columns[column_index][row_index + 1]]
  if column_index != 0 then adjacents << row[column_index - 1] end
  if row_index != 0 then adjacents << columns[column_index][row_index - 1] end
  adjacents
end

def find_basins(contiguous_indexes, adjacent_points)
  basins = []
  basin_points = [contiguous_indexes[0]]
  loop do
    possible_expansions = []
    basin_points.each do |point| 
      adjacent_basin_points = adjacent_points[point]
      adjacent_basin_points.each { |adjacent_point| possible_expansions << adjacent_point unless possible_expansions.include?(adjacent_point) }
    end
    rough_max = possible_expansions.flatten.max + 1
    new_points = []
    contiguous_indexes.each do |index| 
      break if (index[0] > rough_max && index[1] > rough_max)
      new_points << index if possible_expansions.include?(index) 
    end
    contiguous_indexes.reject! { |index| basin_points.include?(index) }
    if new_points.empty?
      basins << basin_points
      basin_points = [contiguous_indexes.min_by { |point| point[0] + point[1] }]
      break if contiguous_indexes.empty?
    else 
      new_points.each { |point| basin_points << point unless basin_points.include?(point) }
    end
  end
  largest_basins = basins.sort_by { |basin| basin.length }.last(3)
  p largest_basins.inject(1) { |product, basin| product * basin.length }
end

# # part 1

# height_map = File.read('advent9.txt').split.map { |row| row.chars.map { |chr| chr.to_i }}
# risk_index = 0
# columns = height_map.transpose
# height_map.each_with_index do |row, row_index|
#   row.each_with_index do |num, column_index|
#     adjacents = get_adjacent_values(row, row_index, columns, column_index) << num
#     next unless adjacents.compact.sort[0] == num && adjacents.count(num) == 1
#     risk_index += (num + 1)
#   end
# end
# p risk_index

# part 2

new_height_map = File.read('input.txt').split.map { |row| row.chars.map { |chr| chr == "9" ? nil : chr.to_i }}
contiguous_indexes = []
adjacent_points = {}
new_height_map.each_with_index do |row, row_index|
  row.each_with_index do |num, column_index|
    if num
      point = [row_index, column_index]
      contiguous_indexes << point
      adjacent_indexes = [[row_index - 1, column_index], [row_index + 1, column_index], [row_index, column_index + 1], [row_index, column_index - 1]].reject { |point| point[0] < 0 || point[1] < 0 }
      adjacent_points[point] = adjacent_indexes
    end
  end
end
part2 = find_basins(contiguous_indexes, adjacent_points)

puts "Part 2: #{part2} in #{Time.now()-start} sec."
