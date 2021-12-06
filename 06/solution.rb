fish_population = [0, 0, 0, 0, 0, 0, 0, 0, 0]
input = File.read("input").split(",").map(&:to_i).each {|f| fish_population[f] += 1}
(1..256).each do |i|
  reproducers = fish_population.shift
  fish_population[6] += reproducers
  fish_population[8] = reproducers
  puts fish_population.sum if i == 80
end
puts fish_population.sum
