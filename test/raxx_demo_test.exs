defmodule RaxxDemoTest do
  use ExUnit.Case
  doctest RaxxDemo

  test "greets the world" do
    assert RaxxDemo.hello() == :world
  end
end
