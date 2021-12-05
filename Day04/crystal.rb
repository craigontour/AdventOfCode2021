# https://www.reddit.com/r/adventofcode/comments/r8i1lq/comment/hn6edvc/?utm_source=share&utm_medium=web2x&context=3
# https://crystal-lang.org/

class Day4
  class Board
    def initialize(@numbers : Array(Array(Int32)))
    end

    def win?(n) : Bool
      (@numbers + @numbers.transpose).any? { |l| (n & l).size == 5 }
    end
  end

  getter draw : Array(Int32)
  getter bingo : Array(Board) = Array(Board).new

  def initialize(f : String)
    input = File.read_lines(f).map(&.strip).reject!(&.empty?).map(&.split(/,| +/).map(&.to_i))
    @draw = input.shift
    input.in_groups_of(5, [0]) { |b| @bingo << Board.new(b) }
  end

  def part1
    draw.each_with_index do |v, i|
      win = bingo.select(&.win?(draw[0..i]))
      return (win.first.@numbers.flatten - draw[0..i]).sum * v if win.size == 1
    end
  end

  def part2
    draw.each_with_index do |v, i|
      win = bingo.select(&.win?(draw[0..i]))
      @bingo -= win
      return (win.first.@numbers.flatten - draw[0..i]).sum * v if bingo.size == 0
    end
  end
end

d = Day4.new("input.txt")
pp d.part1
pp d.part2