defmodule AOC06 do
  def cycle(memory_bank, duplicate_map \\ %{},count \\ 0)
  def cycle(memory_bank, duplicate_map, count) do
    cond do
      duplicate_map[memory_bank] == 1 ->
        IO.puts "Count: #{count}"
        IO.inspect memory_bank
      true ->
        {x,i} = max_blocks(memory_bank)
        mem = List.update_at(memory_bank, i, fn _ -> 0 end)
        cycle(reallocate(mem, x, i + 1), Map.put(duplicate_map, memory_bank, 1), count + 1)
    end

  end

  defp max_blocks(memory_bank) do
    max = memory_bank |> Enum.max
    memory_bank
    |> Enum.with_index
    |> Enum.filter(fn {k, _} -> k == max end)
    |> Enum.min
  end

  defp reallocate(memory_bank, biggest, _) when biggest <= 0 do
    memory_bank
  end
  defp reallocate(memory_bank, biggest, index) when index >= length(memory_bank) do
    reallocate(memory_bank, biggest, 0)
  end
  defp reallocate(memory_bank, biggest, index) do
    mem = memory_bank |> List.update_at(index, fn x -> x + 1 end)
    reallocate(mem, biggest - 1, index + 1)
  end

end

#Pt I
#IO.inspect AOC06.cycle([4,1,15,12,0,9,9,5,5,8,7,3,14,5,12,3])
#Pt. II (take solution from Pt. 1 as input)
IO.inspect AOC06.cycle([0, 14, 13, 12, 11, 10, 8, 8, 6, 6, 5, 3, 3, 2, 1, 10])
