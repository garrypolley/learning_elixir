defmodule MultiClausePatterns do
  def factorial(0), do: 1
  def factorial(n), do: n * factorial(n - 1)

  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)
  def sum(%Range{first: first, last: last}), do: sum(Enum.to_list(first..last))
end
