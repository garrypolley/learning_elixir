defmodule TestNumber do
  def test_number(number) when is_number(number) and number > 0 do
    :positive
  end

  def test_number(number) when is_number(number) and number < 0 do
    :negative
  end

  def test_number(number) when is_number(number) and number == 0 do
    :zero
  end
end

# Using the TestNumber module
IO.puts("Test number 5: #{TestNumber.test_number(5)}")
IO.puts("Test number -5: #{TestNumber.test_number(-5)}")
IO.puts("Test number 0: #{TestNumber.test_number(0)}")

# Tests a string passed to the test_number
IO.puts("Test number '5': #{TestNumber.test_number(~c"5")}")
