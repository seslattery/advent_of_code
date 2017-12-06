defmodule AOC05_II do
  @moduledoc """
  Documentation for AdventOfCode.
  """

  @doc """

  ## Examples

      iex> AdventOfCode.from_file

  """

  def run_it(list) do
    index_list_to_map(list)
    |> jump
  end

  def count_from_file(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> run_it
  end

  def index_list_to_map(list) do
    list |> Enum.with_index |> Enum.into(%{}, fn {k, v} -> {v, k} end)
  end

  defp jump(map, index \\ 0, count \\ 0)

  defp jump(map, index, count) when (index >= map_size(map)) or (index < 0) do
    IO.puts "Count: #{count}"
  end

  defp jump(map, index, count) do
    value = map[index]

    #Part II
    cond do
      value >= 3 ->
        jump(%{map | index => value - 1}, value + index, count + 1)
      value < 3 ->
        jump(%{map | index => value + 1}, value + index, count + 1)
    end
    #IO.puts "Count: #{count}"
    #IO.inspect Map.values(map)
    #IO.puts "Index: #{index}"
    #IO.puts "Value: #{value}"

    #Part I
    #jump(%{map | index => value + 1}, value + index, count + 1)
  end

end
#small test example
#[0,3,0,1,-3]
#IO.inspect AOC05.run_it([0, 3, 0 ,1, -3])

AOC05_II.count_from_file("input.txt")
