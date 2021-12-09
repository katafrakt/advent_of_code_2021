fields =
  File.stream!("input")
  |> Stream.with_index()
  |> Stream.map(fn {line, idx} ->
    line
    |> String.trim()
    |> String.split("")
    |> Enum.reject(& &1 == "")
    |> Enum.with_index()
    |> Enum.map(fn {digit, idx2} -> {idx, idx2, String.to_integer(digit)} end)
  end)
  |> Enum.to_list()
  |> List.flatten()

minima =
  Enum.filter(fields, fn {x, y, h} ->
    adjacent = Enum.filter(fields, fn {x1, y1, _} ->
      abs(x1 - x) <= 1 and abs(y1 - y) <= 1 and (x1 != x or y1 != y)
    end)
    Enum.all?(adjacent, fn {_, _, h1} -> h1 >= h end)
  end)

Enum.map(minima, fn {_, _, h} -> h + 1 end)
|> Enum.sum()
|> IO.puts

defmodule Basin do
  def find_size(fields, points = %MapSet{}) do
    original_size = MapSet.size(points)
    adjacent =
      points
      |> Enum.map(fn {x, y, _} ->
        Enum.filter(fields, fn {x1, y1, h} ->
          abs(x1 - x) <= 1 and abs(y1 - y) <= 1 and (x1 == x or y1 == y) and (x1 != x or y1 != y) and h != 9
        end)
      end)
      |> List.flatten()
      |> Enum.uniq()
      |> Enum.reject(& MapSet.member?(points, &1))

    case adjacent do
      [] -> original_size
      new_points ->
        find_size(fields, MapSet.union(points, MapSet.new(new_points)))
    end
  end
end

Enum.map(minima, & Basin.find_size(fields, MapSet.new([&1])))
|> Enum.sort()
|> Enum.reverse()
|> Enum.take(3)
|> Enum.reduce(1, fn elem, acc -> acc * elem end)
|> IO.puts
