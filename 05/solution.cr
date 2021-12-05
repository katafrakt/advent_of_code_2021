fields = Hash(Tuple(Int32, Int32),Int32).new
File.read("input").split("\n").map do |line|
  if match = line.match(/(\d+),(\d+) -> (\d+),(\d+)/)
    x1 = match[1].not_nil!
    y1 = match[2].not_nil!
    x2 = match[3].not_nil!
    y2 = match[4].not_nil!
    if x1 == x2
      y_lower = [y1.to_i, y2.to_i].min
      y_higher = [y1.to_i, y2.to_i].max
      (y_lower..y_higher).each do |y|
        key = {x1.to_i, y}
        cur = fields.fetch(key, 0)
        fields[key] = cur + 1
      end
    elsif y1 == y2
      x_lower = [x1.to_i, x2.to_i].min
      x_higher = [x1.to_i, x2.to_i].max
      (x_lower..x_higher).each do |x|
        key = {x, y1.to_i}
        cur = fields.fetch(key, 0)
        fields[key] = cur + 1
      end
    end
  end
end

puts fields.count {|x,y| y > 1}