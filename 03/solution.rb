lines = File.readlines("input").map(&:chomp).map{|s| s.split("")}
positions = []
lines.each do |digits|
  digits.each_with_index do |val, idx|
    current = positions.fetch(idx, {"0" => 0, "1" => 1})
    current[val] += 1
    positions[idx] = current
  end
end

gamma = positions.map { |pos| pos["0"] < pos["1"] ? "1" : "0" }.join.to_i(2)
epsilon = positions.map { |pos| pos["0"] < pos["1"] ? "0" : "1" }.join.to_i(2)
puts gamma * epsilon