defmodule MyModule do
  def my_function do
    IO.puts("👋 Hello, places!")
  end

  def wrap_in_string(number) do
    "The number is #{number}"
  end
end

MyModule.my_function()

# This was a cool way to see the pipe operator

1..5
|> Enum.map(&MyModule.wrap_in_string/1)
|> Enum.each(&IO.puts/1)
