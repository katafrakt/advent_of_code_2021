lines = File.read("input").split("\n")
count = lines.map do |line|
  patterns, outputs = line.split(" | ").map{|part| part.split(" ")}
  outputs.select{|output| [2,3,4,7].include?(output.length)}.size
end.sum
puts count

count2 = lines.map do |line|
  patterns, outputs = line.split(" | ").map{|part| part.split(" ")}
  
  one = patterns.find{|o| o.length == 2}.split("")
  seven = patterns.find{|o| o.length == 3}.split("")
  eight = patterns.find{|o| o.length == 7}.split("")
  four = patterns.find{|o| o.length == 4}.split("")

  top = (seven - one).first

  three_or_two_or_five = patterns.select{|o| o.length == 5}.map{|p| p.split("")}
  middle_or_bottom = eight.select{|l| three_or_two_or_five.all?{|can| can.include?(l)} && l != top}
  middle = middle_or_bottom.find{|l| four.include?(l)}
  bottom = middle_or_bottom.find{|l| l != middle}

  zero = patterns.find{|o| o.length == 6 && !o.include?(middle)}.split("")

  six_or_nine = patterns.select{|o| o.length == 6 && o != zero.join()}.map{|o| o.split("")}
  six_nine_missing = (eight - six_or_nine[0]) + (eight - six_or_nine[1])

  top_right = six_nine_missing.find{|l| one.include?(l)}
  bottom_left = six_nine_missing.find{|l| l != top_right}

  six = six_or_nine.find{|o| o.include?(bottom_left)}
  nine = six_or_nine.find{|o| o.include?(top_right)}

  three = patterns.find{|o| o.length == 5 && !o.include?(bottom_left) && o.include?(top_right)}.split("")
  five = patterns.find{|o| o.length == 5 && !o.include?(bottom_left) && o != three.join}.split("")
  two = patterns.find{|o| o.length == 5 && o != three.join && o != five.join}.split("")

  numbers = [zero, one, two, three, four, five, six, seven, eight, nine]

  numeric = outputs.map do |out|
    letters = numbers.find{|n| n.sort == out.split("").sort}
    numbers.index(letters)
  end

  (numeric[0] * 1000) + (numeric[1] * 100) + (numeric[2] * 10) + (numeric[3])
end.sum

puts count2