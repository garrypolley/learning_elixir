defmodule Concurrent do

  def run(value) do
    Task.async(fn ->
      Process.sleep(1000)
      IO.puts(value) end
    )
  end
end

# run the code 100 times in sequence
tasks = for i <- 1..100 do
  Concurrent.run("running as #{i}")
end

for task <- tasks do
  Task.await(task)
end

send(self(), :hi)

receive do
  message -> IO.inspect(message)
end

send(self(), :hi_again)

# This has to be here a second time to get the sent message.
receive do
  message -> IO.inspect(message)
end

receive do
  {:wait, forever} -> IO.inspect(forever)
after
  3000 -> IO.puts("waited too long")
end
