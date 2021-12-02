defmodule SubmarineLang do
  def eval_file(name) do
    input =
      name
      |> File.read!()
      |> to_charlist()

    {:ok, tokens, _} = :lexer.string(input)
    {:ok, ast} = :parser.parse(tokens)
    eval(ast)
  end

  defp eval(ast) when is_list(ast), do: Enum.reduce(ast, {0, 0}, &eval/2)
  defp eval({{:move, :forward}, {:number, x}}, {h, depth}), do: {h + x, depth}
  defp eval({{:move, :down}, {:number, x}}, {h, depth}), do: {h, depth + x}
  defp eval({{:move, :up}, {:number, x}}, {h, depth}), do: {h, depth - x}
end
