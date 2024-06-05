# Todo

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `todo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:todo, "~> 0.1.0"}
  ]
end
```

## Setup For testing server

Here's some stuff I've done to get some default data setup. 

```sh
iex -S mix
```

```elixir
{:ok, todo_server} = Todo.Server.start()
Todo.Server.add_entry(todo_server, %{date: ~D[2024-06-10], title: "Some Title"})
Todo.Server.add_entry(todo_server, %{date: ~D[2024-06-10], title: "Some Title Two"})
Todo.Server.add_entry(todo_server, %{date: ~D[2024-06-10], title: "Some Title Three"})
Todo.Server.add_entry(todo_server, %{date: ~D[2024-06-10], title: "Some Title Four"})
Todo.Server.add_entry(todo_server, %{date: ~D[2024-06-11], title: "Some other"})
Todo.Server.add_entry(todo_server, %{date: ~D[2024-06-11], title: "Some other Two"})
Todo.Server.add_entry(todo_server, %{date: ~D[2024-06-11], title: "Some other Three"})
Todo.Server.add_entry(todo_server, %{date: ~D[2024-06-11], title: "Some other Four"})

Todo.Server.get_todo_list(todo_server)
```

## Setup for testing cache

```elixir
{:ok, cache} = Todo.Cache.start()
bob_cache = Todo.Cache.server_process(cache, "Bob Cache")
alice_cache = Todo.Cache.server_process(cache, "Alice Cache")

Todo.Server.add_entry(bob_cache, %{date: ~D[2024-06-10], title: "Some Title"})
Todo.Server.add_entry(bob_cache, %{date: ~D[2024-06-10], title: "Some Title Two"})
Todo.Server.add_entry(bob_cache, %{date: ~D[2024-06-10], title: "Some Title Three"})

Todo.Server.add_entry(alice_cache, %{date: ~D[2024-06-10], title: "Alice Title"})
Todo.Server.add_entry(alice_cache, %{date: ~D[2024-06-10], title: "Alice Title Two"})
Todo.Server.add_entry(alice_cache, %{date: ~D[2024-06-10], title: "Alice Title Three"})

Todo.Server.entries(bob_cache, ~D[2024-06-10])

Todo.Server.entries(alice_cache, ~D[2024-06-10])
```

## Initial test for cache that uses disk

```elixir
{:ok, cache} = Todo.Cache.start()
bobs_list = Todo.Cache.server_process(cache, "bobs_list")
Todo.Server.add_entry(bobs_list, %{date: ~D[2024-06-04], title: "hi there"})
```
## Default doc

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/todo>.

