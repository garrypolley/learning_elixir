defmodule Todo.List do
  defstruct next_id: 1, entries: %{}

  def new(), do: %Todo.List{}

  def new(entries) do
    add_entries(%Todo.List{}, entries)
  end

  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.next_id)

    new_entries =
      Map.put(
        todo_list.entries,
        todo_list.next_id,
        entry
      )

    # Stateless auto incrementing id, kind of cool
    %Todo.List{
      todo_list
      | entries: new_entries,
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
        %Todo.List{todo_list | entries: new_entries}
    end
  end

  def delete_entry(todo_list, entry_id) do
    new_entries = Map.delete(todo_list.entries, entry_id)
    %Todo.List{todo_list | entries: new_entries}
  end

  def get_todo_list(todo_list) do
    todo_list.entries
  end
end
