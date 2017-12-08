defmodule AOC07 do
  #Need to revist this solution, especially for part_II

  def part_I(filename) do
    read_from_file(filename) |> find_root |> IO.puts
  end
  def part_II(filename) do
    input = read_from_file(filename)
    root = input |> find_root
    tree = build_tree(input)
    weighted_tree = tree
    |> Map.keys
    |> Map.new(fn k -> {k, Tuple.insert_at(tree[k], 2, get_total_weight(k, tree))} end)
    IO.inspect weighted_tree["lnpuarm"]
    #final = balance_tree(root, weighted_tree) |> Enum.uniq
    #{}"Final: #{final}"
  end

  defp balance_tree(node, wtree, above \\ nil) do
    uniques = elem(wtree[node],1)
    |> Enum.map(fn x -> elem(wtree[x],2) end)
    |> Enum.uniq
    #IO.inspect uniques
    cond do
      length(uniques) > 1 ->
        #IO.puts "False"
        elem(wtree[node],1)
        |> Enum.map(fn x -> balance_tree(x, wtree, node) end)
      true ->
        IO.puts "True"
        IO.inspect elem(wtree[above],1)
        uniq = elem(wtree[above],1)
        |> Enum.map(fn x -> elem(wtree[x],2) end)
        |> Enum.uniq

        all = elem(wtree[above],1)
        |> Enum.map(fn x -> elem(wtree[x],2) end)
        IO.inspect all
        desired = all -- uniq
        wrong = uniq -- desired |> hd()
        IO.puts "Wrong: #{wrong}"
        elem(wtree[above],1)
        |> Enum.map(fn x -> {x, elem(wtree[x],2)} end)
        |> Enum.filter(fn {_,v} -> v == wrong end)
        #Enum.map(fn x -> wtree[x] end)
        |> IO.inspect
        |> Enum.map(fn {k,_} -> Integer.to_string(elem(wtree[k],0))  end)
    end
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
    head = get_name(hd)
    cond do
      String.contains?(hd, "->") ->
        kids = get_children(hd)
        find_root(tl, parents ++ [head], children ++ kids)
      true ->
        find_root(tl, parents ++ [head], children)
    end
  end
  defp build_tree(_, tree \\ %{})
  defp build_tree([], tree) do
    tree
  end
  defp build_tree([hd | tl], tree) do
    children = cond do
      String.contains?(hd, "->") ->
        get_children(hd)
      true ->
        []
    end
    build_tree(tl, Map.put(tree, get_name(hd), {get_weight(hd), children}))
  end

  defp get_name(a) do
    [head | _] = String.split(a, " ", trim: true)
    head
  end
  defp get_children(a) do
    [_ | tail] = String.split(a, "->")
    kids = tail
    |> hd()
    |> String.trim
    |> String.replace(",", "")
    |> String.split(" ")
    kids
  end
  defp get_weight(a) do
    [_ | [mass | _]] = String.split(a, " ", trim: true)
    weight = mass
    |> String.replace("(","")
    |> String.replace(")","")
    |> String.to_integer()
    weight
  end
  defp get_total_weight(node, tree) do
    cond do
      elem(tree[node],1) == [] ->
        elem(tree[node],0)
      true ->
        elem(tree[node],0) + Enum.reduce(elem(tree[node],1), 0, fn x,acc -> get_total_weight(x, tree) + acc end)
    end
  end
end
IO.inspect AOC07.part_II("input.txt")
