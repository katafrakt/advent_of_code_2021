input = File.readlines("input").map(&:chomp)
polymer = input.shift.split("")
input.shift
rules = input.map do |line|
  from, _, to = line.split(" ")
  [from.split(""), to]
end.to_h

10.times do
  new_polymer = polymer.each_cons(2).map do |pair|
    if rules.key?(pair)
      [pair[0], rules[pair]]
    else
      pair[0]
    end
  end.flatten
  new_polymer << polymer.last
  polymer = new_polymer
end

p polymer.tally

freqs = polymer.tally.values.sort
puts freqs.last - freqs.first