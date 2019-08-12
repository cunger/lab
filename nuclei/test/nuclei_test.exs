defmodule NucleiTest do
  use ExUnit.Case
  doctest Nuclei

  test "greets the world" do
    assert Nuclei.hello() == :world
  end
end
