defmodule PatternMatchModule do
  def area({:rectangle, width, height}) do
    width * height
  end

  def area({:circle, radius}) do
    3.14 * radius * radius
  end

  def area({:square, side}) do
    side * side
  end

  def area({:triangle, base, height}) do
    0.5 * base * height
  end

  def area(unknown) do
    {:error, {:unknown_shape, unknown}}
  end
end

# A few examples of pattern matching
IO.puts("Rectangle area: #{PatternMatchModule.area({:rectangle, 10, 20})}")
IO.puts("Circle area: #{PatternMatchModule.area({:circle, 10})}")
IO.puts("Square area: #{PatternMatchModule.area({:square, 10})}")
IO.puts("Triangle area: #{PatternMatchModule.area({:triangle, 10, 20})}")
IO.inspect(PatternMatchModule.area({:meow, 10, 20}))
