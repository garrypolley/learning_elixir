defmodule Todo.Server do
  use GenServer

  def start do
    GenServer.start(__MODULE__, %Todo.List{},  name: __MODULE__)
  end

  @impl GenServer
  def init(init_arg) do
    {:ok, init_arg}
  end

  def add_entry(entry) do
    GenServer.cast(__MODULE__, {:add_entry, entry})
  end

  def entries(date) do
    GenServer.call(__MODULE__, {:entries, date})
  end

  def update_entry(entry_id, updater_fun) do
    GenServer.cast(__MODULE__, {:update_entry, entry_id, updater_fun})
  end

  def delete_entry(entry_id) do
    GenServer.cast(__MODULE__, {:delete_entry, entry_id})
  end

  def get_todo_list do
    GenServer.call(__MODULE__, :get_todo_list)
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
