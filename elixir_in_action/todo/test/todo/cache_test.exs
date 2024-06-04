defmodule Todo.CacheTest do
  use ExUnit.Case

  test "server_process" do
    {:ok, cache} = Todo.Cache.start()

    garry_pid = Todo.Cache.server_process(cache, "garry")
    meow_pid = Todo.Cache.server_process(cache, "meow")

    assert garry_pid != meow_pid
    assert garry_pid == Todo.Cache.server_process(cache, "garry")
  end

  test "todo operations" do
    {:ok, cache} = Todo.Cache.start()

    garry_pid = Todo.Cache.server_process(cache, "garry")
    meow_pid = Todo.Cache.server_process(cache, "meow")

    Todo.Server.add_entry(garry_pid, %{date: ~D[2020-01-01], description: "First entry"})
    Todo.Server.add_entry(garry_pid, %{date: ~D[2020-01-01], description: "Second entry"})

    entries = Todo.Server.entries(garry_pid, ~D[2020-01-01])

    assert entries == [
             %{id: 1, date: ~D[2020-01-01], description: "First entry"},
             %{id: 2, date: ~D[2020-01-01], description: "Second entry"}
           ]

    Todo.Server.add_entry(meow_pid, %{date: ~D[2020-01-01], description: "Third entry"})
    entries = Todo.Server.entries(meow_pid, ~D[2020-01-01])
    assert entries == [%{id: 1, date: ~D[2020-01-01], description: "Third entry"}]
  end
end
