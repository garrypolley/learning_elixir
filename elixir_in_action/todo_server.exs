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

defmodule TodoServer do
  def start do
    spawn(fn -> loop(BetterTodo.new()) end)
  end

  def add_entry(todo_server, entry) do
    send(todo_server, {:add_entry, entry})
  end

  def entries(todo_server, date) do
    send(todo_server, {:entries, date})
  end

  def update_entry(todo_server, entry_id, updater_fun) do
    send(todo_server, {:update_entry, entry_id, updater_fun})
  end

  def delete_entry(todo_server, entry_id) do
    send(todo_server, {:delete_entry, entry_id})
  end

  def get_todo_list(todo_server) do
    send(todo_server, :get_todo_list)
  end

  defp loop(todo_list) do
    new_list = receive do
      message -> process_message(todo_list, message)
        # code
    end

    loop(new_list)
  end

  defp process_message(todo_list, {:add_entry, entry}) do
    BetterTodo.add_entry(todo_list, entry)
  end

  defp process_message(todo_list, {:entries, date}) do
    IO.inspect(BetterTodo.entries(todo_list, date))
    todo_list
  end

  defp process_message(todo_list, {:update_entry, entry_id, updater_fun}) do
    BetterTodo.update_entry(todo_list, entry_id, updater_fun)
  end

  defp process_message(todo_list, {:delete_entry, entry_id}) do
    BetterTodo.delete_entry(todo_list, entry_id)
  end

  defp process_message(todo_list, :get_todo_list) do
    IO.inspect(todo_list)
  end

  defp process_message(todo_list, message) do
    IO.inspect("Unknown message: #{message}")
    todo_list
  end
end
