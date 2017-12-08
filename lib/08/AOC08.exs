defmodule AOC08 do
  #Day 8: I Heard You Like Registers
  def part_I(filename) do
    normalize_input(filename)
    |> process
    |> elem(0)
    |> Map.values
    |> Enum.max
  end
  def part_II(filename) do
    normalize_input(filename)
    |> process
    |> elem(1)
    |> Enum.max
  end
  def normalize_input(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
    #["b", "inc", "5", "if", "a", ">", "1"]
    |> Enum.map(fn [register1, operation1, value1, _, register2, operation2, value2] ->
      {
        register1,
        String.to_atom(operation1),
        String.to_integer(value1),
        register2,
        String.to_atom(operation2),
        String.to_integer(value2)
      }
    end)
  end
  def process(instructions, registers \\ %{}, values \\ [])
  def process([], registers, values), do: {registers, values}
  def process([hd | tl], registers, values) do
    if apply(Kernel, elem(hd,4), [Map.get(registers, elem(hd, 3), 0), elem(hd, 5)]) do
      value = apply(__MODULE__, elem(hd,1), [Map.get(registers, elem(hd, 0), 0), elem(hd, 2)])
      process(tl, Map.put(registers, elem(hd, 0), value), [value] ++ values)
    else
      process(tl, registers, values)
    end
  end
  def inc(a, b), do: a + b
  def dec(a, b), do: a - b
end
IO.puts "Part I: #{AOC08.part_I("input.txt")}"
IO.puts "Part II: #{AOC08.part_II("input.txt")}"
