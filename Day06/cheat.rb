DAYS_TO_GO = 256.freeze
COOLDOWN = 8.freeze
GAP = 6.freeze
CACHE = {}

def population(timer, day)
  return 1 if day > DAYS_TO_GO
  return population(GAP, day + 1) + population(COOLDOWN, day + 1) if timer == 0
  return CACHE[timer - 1][day + 1] if CACHE[timer - 1] && CACHE[timer - 1][day + 1]

  CACHE[timer - 1] ||= {}
  CACHE[timer - 1][day + 1] = population(timer - 1, day + 1)

  return CACHE[timer - 1][day + 1] 
end

fishes = File.read('input.txt').split(',').map(&:to_i)
puts fishes.map { |f| population(f, 1) }.sum