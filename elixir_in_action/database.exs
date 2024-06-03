defmodule Database do
  def start do
    spawn(&loop/0)
  end

  defp loop do
    receive do
      stuff -> IO.puts("Received: #{stuff}")
    end

    loop()
  end
end
