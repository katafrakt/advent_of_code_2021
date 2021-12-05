def points_of_line(x1 : Int32, x2 : Int32, y1 : Int32, y2 : Int32, with_diagonals : Bool) : Array(Tuple(Int32, Int32))
  dir = (x1 - x2).to_f/(y1 - y2).to_f
  if x1 == x2
    ([y1, y2].min..[y1, y2].max).map {|y| {x1, y}}
  elsif y1 == y2
    ([x1, x2].min..[x1, x2].max).map {|x| {x, y1}}
  elsif with_diagonals && (dir == 1 || dir == -1)
    x_sign = (x1 - x2).sign
    y_sign = (y1 - y2).sign
    current = {x1, y1}
    fields = [current]
    loop do
      current = {current[0] - x_sign, current[1] - y_sign}
      fields << current
      break if current == {x2, y2}
    end
    fields
  else
    Array(Tuple(Int32, Int32)).new
  end
end

def count(with_diagonals = false)
  fields = Hash(Tuple(Int32, Int32), Int32).new

  File.read("input").split("\n").map do |line|
    if match = line.match(/(\d+),(\d+) -> (\d+),(\d+)/)
      x1 = match[1].not_nil!.to_i
      y1 = match[2].not_nil!.to_i
      x2 = match[3].not_nil!.to_i
      y2 = match[4].not_nil!.to_i
      
      points_of_line(x1, x2, y1, y2, with_diagonals).each do |point|
        cur = fields.fetch(point, 0)
        fields[point] = cur + 1
      end
    end
  end
  fields.count {|x,y| y > 1}
end

puts count()
puts count(true)