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

AUTOCOMPLETE_POINTS = {
  ")" => 1,
  "]" => 2,
  "}" => 3,
  ">" => 4
}

lines = File.read("input").split("\n")
sums = lines.map do |line|
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

  num2 = stack.reverse.reduce(0) {|acc, paren| acc = (acc * 5) + AUTOCOMPLETE_POINTS[PAIRS[paren]] }

  [num, num2]
end
puts sums.map {|x| x[0]}.sum
sums2 = sums.reject{|x| x[0] > 0}
puts sums2.map {|x| x[1]}.sort[sums2.length/2]
