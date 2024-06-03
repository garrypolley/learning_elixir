defmodule Lines do
  def count!(file_path) do
    File.stream!(file_path)
    |> Stream.map(&String.trim/1)
    |> Stream.with_index()
    |> Enum.each(&IO.puts("Line: #{elem(&1, 1) + 1} - #{String.length(elem(&1, 0))}"))
  end

  def longestLine!(file_path) do
    File.stream!(file_path)
    |> Stream.map(&String.trim/1)
    |> Enum.max_by(&String.length(&1))
  end

  def longestLineLength!(file_path) do
    File.stream!(file_path)
    |> Stream.map(&String.trim/1)
    |> Enum.map(&String.length/1)
    |> Enum.max()
  end
end

Lines.count!(~c"./my_module.exs")
IO.puts(Lines.longestLine!(~c"./my_module.exs"))
IO.puts(Lines.longestLineLength!(~c"./my_module.exs"))
