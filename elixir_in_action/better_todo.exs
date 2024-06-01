defmodule BetterTodo do
  defstruct next_id: 1, entries: %{}

  def new(), do: %BetterTodo{}

  def new(entries) do
    add_entries(%BetterTodo{}, entries)
  end

  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.next_id)

    new_entries = Map.put(
      todo_list.entries,
      todo_list.next_id,
      entry
    )

    # Stateless auto incrementing id, kind of cool
    %BetterTodo{
      todo_list |
      entries: new_entries,
      next_id: todo_list.next_id + 1
    }
  end

  def add_entries(todo_list, entries) do
    Enum.reduce(entries, todo_list, &add_entry(&2, &1))
  end

  def entries(todo_list, date) do
    todo_list.entries
    |> Map.values()
    |> Enum.filter(&(&1.date == date))
  end

  def update_entry(todo_list, entry_id, updater_fun) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list
      {:ok, old_entry} ->
        new_entry = updater_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, entry_id, new_entry)
        %BetterTodo{todo_list | entries: new_entries}
    end
  end

  def delete_entry(todo_list, entry_id) do
    new_entries = Map.delete(todo_list.entries, entry_id)
    %BetterTodo{todo_list | entries: new_entries}
  end
end

defmodule BetterTodo.CsvImporter do
  def import(filename) do
    File.stream!(filename)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&(String.split(&1, ",")))
    |> Stream.map(&(%{date: Date.from_iso8601!(Enum.fetch!(&1, 0)), title: Enum.fetch!(&1, 1)}))
    |> BetterTodo.new()
  end
end

defimpl String.Chars, for: BetterTodo do
  def to_string(todo_list) do
    todo_list.entries
    |> Map.values()
    |> Enum.map(&inspect/1)
    |> Enum.join("\n")
  end
end

defimpl Collectable, for: BetterTodo do
  def into(original) do
    {original, &into_callback/2}
  end

  defp into_callback(todo_list, {:cont, entry}) do
    BetterTodo.add_entry(todo_list, entry)
  end

  defp into_callback(todo_list, :done), do: todo_list
  defp into_callback(_todo_list, :halt), do: :ok
end

# Add 5 items to the list and then print it
list_of_five = BetterTodo.new()
|> BetterTodo.add_entry(%{date: ~D[2019-01-01], title: "Do the thing"})
|> BetterTodo.add_entry(%{date: ~D[2019-01-02], title: "Do the other thing"})
|> BetterTodo.add_entry(%{date: ~D[2019-01-03], title: "Do the third thing"})
|> BetterTodo.add_entry(%{date: ~D[2019-01-03], title: "Do the fourth thing"})
|> BetterTodo.add_entry(%{date: ~D[2019-01-05], title: "Do the fifth thing"})
|> IO.inspect()

# Only print those items for the 3rd
{:ok, %{id: id}} = BetterTodo.entries(list_of_five, ~D[2019-01-03])
|> IO.inspect()
|> Enum.fetch(0)

BetterTodo.delete_entry(list_of_five, id)
|> IO.inspect()

# Print the list from the csv
BetterTodo.CsvImporter.import("./todos.csv")
|> IO.inspect()
|> IO.puts()

IO.puts("\n\nI'm a break\n\n")

entries = [
  %{date: ~D[2019-01-01], title: "Do the thing"},
  %{date: ~D[2019-01-02], title: "Do the other thing"},
  %{date: ~D[2019-01-03], title: "Do the third thing"},
  %{date: ~D[2019-01-03], title: "Do the fourth thing"},
  %{date: ~D[2019-01-05], title: "Do the fifth thing"}
]
Enum.into(entries, BetterTodo.new())
|> IO.puts()
