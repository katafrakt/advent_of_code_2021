defmodule Board do
  alias __MODULE__

  defstruct [:rows, :cols]

  def new do
    %Board{rows: [], cols: [[],[],[],[],[]]}
  end

  def add_row(board, list) do
    rows = [list | board.rows]
    cols =
      board.cols
      |> Enum.with_index()
      |> Enum.map(fn {col, idx} -> [Enum.at(list, idx) | col] end)

    %Board{board | rows: rows, cols: cols}
  end

  def mark(board, number) do
    rows = Enum.map(board.rows, & List.delete(&1, number))
    cols = Enum.map(board.cols, & List.delete(&1, number))
    %Board{board | rows: rows, cols: cols}
  end

  def win?(board) do
    Enum.any?(board.rows, &Enum.empty?/1) or Enum.any?(board.cols, &Enum.empty?/1)
  end

  def calculate_score(board, number) do
    numbers = List.flatten(board.rows)
    Enum.sum(numbers) * number
  end
end

defmodule Game do
  alias __MODULE__

  defstruct [:numbers, :boards]

  def new(numbers) do
    %Game{numbers: numbers, boards: []}
  end

  def load(filename) do
    with {:ok, file} <- File.read(filename) do
      lines = String.split(file, "\n")
      numbers = load_numbers(List.first(lines))
      game = Game.new(numbers)
      lines = Enum.drop(lines, 1)
      load_boards(game, lines)
    end
  end

  defp add_board(game, board = %Board{}), do: %Game{game | boards: [board | game.boards]}

  defp load_numbers(line) do
    line
    |> String.split(",")
    |> Enum.map(& String.to_integer(&1))
  end

  defp load_boards(game, []), do: game

  defp load_boards(game, lines) do
    board_lines =
      lines
      |> Enum.take(6)
      |> Enum.drop(1)

    board =
      Enum.reduce(board_lines, Board.new(), fn line, board ->
        line
        |> String.split(" ")
        |> Enum.reject(& &1 == "")
        |> Enum.map(& String.to_integer(&1))
        |> then(& Board.add_row(board, &1))
      end)

    load_boards(add_board(game, board), Enum.drop(lines, 6))
  end

  def play(game, mode \\ :first) do
    {number, board} = do_play(game.boards, game.numbers, mode)
    Board.calculate_score(board, number)
  end

  defp do_play(boards, numbers, mode) do
    number = List.first(numbers)
    boards = Enum.map(boards, &Board.mark(&1, number))

    case mode do
    :first ->
      case Enum.find(boards, &Board.win?/1) do
        nil -> do_play(boards, Enum.drop(numbers, 1), mode)
        board -> {number, board}
      end

    :last ->
      case {Enum.find(boards, &Board.win?/1), length(boards)} do
        {nil, 1} -> do_play(boards, Enum.drop(numbers, 1), mode)
        {board, 1} -> {number, board}
        _ -> do_play(Enum.reject(boards, &Board.win?/1), Enum.drop(numbers, 1), mode)
      end
    end
  end
end

game = Game.load("input")

Game.play(game)
|> IO.puts

Game.play(game, :last)
|> IO.puts
