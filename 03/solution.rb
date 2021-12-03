lines = File.readlines("input").map(&:chomp).map{|s| s.split("")}

def calculate(lines, type)
  positions = []
  lines.each do |digits|
    digits.each_with_index do |val, idx|
      current = positions.fetch(idx, {"0" => 0, "1" => 1})
      current[val] += 1
      positions[idx] = current
    end
  end

  if type == :gamma
    positions.map { |pos| pos["0"] < pos["1"] ? "1" : "0" }
  else
    positions.map { |pos| pos["0"] < pos["1"] ? "0" : "1" }
  end
end

gamma = calculate(lines, :gamma).join.to_i(2)
epsilon = calculate(lines, :epsilon).join.to_i(2)
puts gamma * epsilon

candidates = lines
oxygene = nil
pos = 0
loop do
  gamma = calculate(candidates, :gamma)
  candidates = candidates.select {|l| l[pos] == gamma[pos]}
  if candidates.length == 1
    oxygene = candidates.first.join.to_i(2)
    break
  else
    pos += 1
  end
end

candidates = lines
co2 = nil
pos = 0
loop do
  epsilon = calculate(candidates, :epsilon)
  candidates = candidates.select {|l| l[pos] == epsilon[pos]}
  if candidates.length == 1
    co2 = candidates.first.join.to_i(2)
    break
  else
    pos += 1
  end
end
puts co2 * oxygene