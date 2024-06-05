defmodule Todo.Server do
  use GenServer

  def start(name) do
    GenServer.start(__MODULE__, name)
  end

  @impl GenServer
  def init(name) do
    {:ok, {name, nil}, {:continue, :init}}
  end

  @impl GenServer
  def handle_continue(:init, {name, nil}) do
    todo_list = Todo.Database.get(name) || Todo.List.new()
    {:noreply, {name, todo_list}}
  end

  def add_entry(todo_server, entry) do
    GenServer.cast(todo_server, {:add_entry, entry})
  end

  def entries(todo_server, date) do
    GenServer.call(todo_server, {:entries, date})
  end

  def update_entry(todo_server, entry_id, updater_fun) do
    GenServer.cast(todo_server, {:update_entry, entry_id, updater_fun})
  end

  def delete_entry(todo_server, entry_id) do
    GenServer.cast(todo_server, {:delete_entry, entry_id})
  end

  def get_todo_list(todo_server) do
    GenServer.call(todo_server, :get_todo_list)
  end

  @impl GenServer
  def handle_cast({:add_entry, entry}, {name, todo_list}) do
    new_list = Todo.List.add_entry(todo_list, entry)
    Todo.Database.store(name, new_list)
    {:noreply, {name, new_list}}
  end

  @impl GenServer
  def handle_cast({:update_entry, entry_id, updater_fun}, {name, todo_list}) do
    new_list = Todo.List.update_entry(todo_list, entry_id, updater_fun)
    Todo.Database.store(name, new_list)
    {:noreply, {name, new_list}}
  end

  @impl GenServer
  def handle_cast({:delete_entry, entry_id}, state) do
    {:noreply, Todo.List.delete_entry(state, entry_id)}
  end

  @impl GenServer
  def handle_call({:entries, date}, _from, {name, todo_list}) do
    {:reply, Todo.List.entries(todo_list, date), {name, todo_list}}
  end

  @impl GenServer
  def handle_call(:get_todo_list, _from, state) do
    {:reply, Todo.List.get_todo_list(state), state}
  end

  @impl GenServer
  def handle_info(msg, state) do
    IO.puts("Unknown message")
    IO.inspect(msg)
    {:noreply, state}
  end
end
