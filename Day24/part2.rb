(99999999999999.downto(11111111111111)).each do |m|
  # nothing
  next if m.to_s.include?('0')
  pp m
end