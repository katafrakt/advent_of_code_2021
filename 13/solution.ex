{points, instructions} =
  File.stream!("input")
  |> Enum.to_list()
  |> Enum.reduce({[], []}, fn line, {points, instructions} ->
    cond do
      String.match?(line, ~r/fold along/) -> {points, [String.trim(line) | instructions]}
      String.trim(line) == "" -> {points, instructions}
      true -> {[String.trim(line) | points], instructions}
    end
  end)

sheet = Enum.reduce(points, MapSet.new(), fn point, acc ->
  [x, y] =
    String.split(point, ",")
    |> Enum.map(&String.to_integer/1)

  MapSet.put(acc, {x,y})
end)

fold_y = fn sheet, fold_line ->
  Enum.reduce(sheet, MapSet.new, fn {x, y}, new_sheet ->
    cond do
      y < fold_line -> MapSet.put(new_sheet, {x, y})
      y == fold_line -> new_sheet
      true -> MapSet.put(new_sheet, {x, fold_line - y + fold_line})
    end
  end)
end

fold_x = fn sheet, fold_line ->
  Enum.reduce(sheet, MapSet.new, fn {x, y}, new_sheet ->
    cond do
      x < fold_line -> MapSet.put(new_sheet, {x, y})
      x == fold_line -> new_sheet
      true -> MapSet.put(new_sheet, {fold_line - x + fold_line, y})
    end
  end)
end

fold = fn sheet, {coord, fold_line} ->
  case coord do
    "x" -> fold_x.(sheet, fold_line)
    "y" -> fold_y.(sheet, fold_line)
  end
end

instructions =
  instructions
  |> Enum.reverse()
  |> Enum.map(fn instr ->
    regex = ~r/fold along (x|y)=(\d+)/
    [_, x_or_y, num] = Regex.run(regex, instr)
    {x_or_y, String.to_integer(num)}
  end)

first_instruction = List.first(instructions)

IO.puts(MapSet.size(fold.(sheet, first_instruction)))

full_folded = Enum.reduce(instructions, sheet, fn instr, sheet ->
  fold.(sheet, instr)
end)

max_x = Enum.max_by(full_folded, fn {x, _} -> x end) |> elem(0)
max_y = Enum.max_by(full_folded, fn {_, y} -> y end) |> elem(1)

for y <- 0..max_y do
  for x <- 0..max_x do
    case MapSet.member?(full_folded, {x, y}) do
      true -> IO.write "#"
      false -> IO.write " "
    end
  end
  IO.puts("")
end
