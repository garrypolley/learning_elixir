defmodule TailSum do
  def sum(%Range{first: first, last: last}), do: sum(Enum.to_list(first..last))
  def sum(list), do: do_sum(0, list)

  defp do_sum(current_sum, []), do: current_sum

  defp do_sum(current_sum, [head | tail]), do: do_sum(current_sum + head, tail)
end
