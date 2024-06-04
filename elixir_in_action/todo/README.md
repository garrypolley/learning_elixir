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

## Setup For testing

Here's some stuff I've done to get some default data setup. 

```sh
iex -S mix
```

```elixir
Todo.Server.start()
Todo.Server.add_entry(%{date: ~D[2024-06-10], title: "Some Title"})
Todo.Server.add_entry(%{date: ~D[2024-06-10], title: "Some Title Two"})
Todo.Server.add_entry(%{date: ~D[2024-06-10], title: "Some Title Three"})
Todo.Server.add_entry(%{date: ~D[2024-06-10], title: "Some Title Four"})
Todo.Server.add_entry(%{date: ~D[2024-06-11], title: "Some other"})
Todo.Server.add_entry(%{date: ~D[2024-06-11], title: "Some other Two"})
Todo.Server.add_entry(%{date: ~D[2024-06-11], title: "Some other Three"})
Todo.Server.add_entry(%{date: ~D[2024-06-11], title: "Some other Four"})
```

## Default doc

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/todo>.

