defmodule AOC07 do
  def part_I(filename) do
    read_from_file(filename) |> find_root |> IO.puts
  end
  defp read_from_file(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
  end
  defp find_root(input, parents \\ [], children \\ [])
  defp find_root([], parents, children) do
    parents -- children |> hd()
  end
  defp find_root([hd | tl], parents, children) do
    [head | _] = String.split(hd, " ", trim: true)
    cond do
      String.contains?(hd, "->") ->
        [_ | tail] = String.split(hd, "->")
        kids = tail
        |> hd()
        |> String.trim
        |> String.replace(",", "")
        |> String.split(" ")
        find_root(tl, parents ++ [head], children ++ kids)
      true ->
        find_root(tl, parents ++ [head], children)
    end
  end
end
AOC07.part_I("input.txt")
