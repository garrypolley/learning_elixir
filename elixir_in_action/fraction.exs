defmodule Fraction do
  defstruct num: 0, den: 1

  def new(num, den) do
    %Fraction{num: num, den: den}
  end

  def to_string(%Fraction{num: num, den: den}) do
    "#{num}/#{den}"
  end

  def value(%Fraction{num: num, den: den}) do
    num / den
  end
end

one_half = Fraction.new(1, 2)
IO.puts(Fraction.to_string(one_half))
IO.puts(Fraction.value(one_half))
