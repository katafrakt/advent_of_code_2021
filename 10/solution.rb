PAIRS = {
  "(" => ")",
  "<" => ">",
  "{" => "}",
  "[" => "]"
}

POINTS = {
  ")" => 3,
  "]" => 57,
  "}" => 1197,
  ">" => 25137
}

lines = File.read("input").split("\n")
sum = lines.map do |line|
  stack = []
  num = 0
  line.split("").each do |char|
    if PAIRS.keys.include?(char)
      stack.push(char)
    elsif PAIRS[stack.last] == char
      stack.pop
    else
      num = POINTS[char]
      break
    end
  end
  num
end.sum
puts sum
