defmodule AOC04 do
  def part_II(filename) do
    read_file(filename)
  end
  def read_file(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
    |> count_valid
  end
  def count_valid(input, count \\ 0)
  def count_valid([], count), do: count
  def count_valid([hd | tl], count) do
   list = hd
   |>Enum.map(fn x -> String.split(x,"") end)
   |>Enum.map(fn x -> Enum.sort(x) end)
   |>Enum.uniq
   if length(hd) == length(list) do
     count_valid(tl,count + 1)
   else
     count_valid(tl,count)
   end
  end
  #part_I:
  #def count_valid([hd | tl], count) do
  #  if length(hd) == length(Enum.uniq(hd)) do
  #    count_valid(tl,count + 1)
  #  else
  #    count_valid(tl,count)
  #  end
  #end
end
IO.puts "Part II: #{AOC04.part_II("input.txt")}"
