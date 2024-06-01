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

  def add(%Fraction{num: num1, den: den1}, %Fraction{num: num2, den: den2}) do
    new(num1 * den2 + num2 * den1, den1 * den2)
  end
end

Fraction.new(1, 2)
|> Fraction.to_string()
|> IO.puts()

Fraction.new(1, 2)
|> Fraction.value()
|> IO.puts()

# Make 3/4ths nice view
Fraction.new(1,4)
|> Fraction.add(Fraction.new(1,2))
|> Fraction.to_string()
|> IO.puts()

# Make 3/4ths with some pipes
Fraction.new(1,4)
|> Fraction.add(Fraction.new(1,2))
|> Fraction.value()
|> IO.puts()
