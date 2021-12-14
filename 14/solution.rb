input = File.readlines("input").map(&:chomp)
polymer = input.shift.split("")
LAST_LETTER = polymer.last
input.shift
rules = input.map do |line|
  from, _, to = line.split(" ")
  [from.split(""), to]
end.to_h

pairs = polymer.each_cons(2).to_a.tally

def calc_factor(pairs)
  freqs = {}
  pairs.each do |k,v|
    freqs[k[0]] = freqs.fetch(k[0], 0) + v
  end
  freqs[LAST_LETTER] += 1
  counts = freqs.values.sort
  puts counts.last - counts.first
end

40.times.map do |i|
  new_pairs = {}
  pairs.each do |pair, count|
    if rules.key?(pair)
      pair1 = [pair[0], rules[pair]]
      pair1_count = new_pairs.fetch(pair1, 0) + count
      new_pairs[pair1] = pair1_count
      pair2 = [rules[pair], pair[1]]
      pair2_count = new_pairs.fetch(pair2, 0) + count
      new_pairs[pair2] = pair2_count
    else
      fail "shouldn't happen"
      pair_count = new_pairs.fetch(pair, 0) + count
      new_pairs[pair] = pair_count
    end
  end
  pairs = new_pairs

  calc_factor(pairs) if i == 9
end
calc_factor(pairs)