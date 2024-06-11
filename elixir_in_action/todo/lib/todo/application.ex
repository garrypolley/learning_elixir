defmodule Todo.Application do
  use Application

  def start(_type, _args) do
    Todo.Server.start(:todo_server)
  end
end
