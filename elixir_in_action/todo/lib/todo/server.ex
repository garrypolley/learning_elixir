defmodule Todo.Server do
  use GenServer

  def start do
    GenServer.start(__MODULE__, %Todo.List{})
  end

  @impl GenServer
  def init(init_arg) do
    {:ok, init_arg}
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
  def handle_cast({:add_entry, entry}, state) do
    {:noreply, Todo.List.add_entry(state, entry)}
  end

  @impl GenServer
  def handle_cast({:update_entry, entry_id, updater_fun}, state) do
    {:noreply, Todo.List.update_entry(state, entry_id, updater_fun)}
  end

  @impl GenServer
  def handle_cast({:delete_entry, entry_id}, state) do
    {:noreply, Todo.List.delete_entry(state, entry_id)}
  end

  @impl GenServer
  def handle_call({:entries, date}, _from, state) do
    {:reply, Todo.List.entries(state, date), state}
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
