defmodule FirstMixProjectTest do
  use ExUnit.Case
  doctest FirstMixProject

  test "greets the world" do
    assert FirstMixProject.hello() == :world
  end
end
