defmodule Server do
  def start(callback_module) do
    spawn(fn ->
      loop(callback_module, callback_module.init())
    end)
  end

  defp loop(callback_module, current_state) do
    receive do
      {request, caller} ->
       {response, new_state} =
        callback_module.handle_call(
          request,
          current_state
        )
        send(caller, {:response, response})
        loop(callback_module, new_state)
    end
  end
end
