defmodule TodoList do
  def new(), do: MultiDict.new()

  def add_entry(todo_list, date, title) do
    MultiDict.put(todo_list, date, title)
  end

  def entries(todo_list, date) do
    MultiDict.get(todo_list, date)
  end
end

defmodule MultiDict do
  def new(), do: %{}

  def put(multi_dict, key, value) do
    Map.update(multi_dict, key, [value], &([value | &1]))
  end

  def get(multi_dict, key) do
    Map.get(multi_dict, key, [])
  end
end
