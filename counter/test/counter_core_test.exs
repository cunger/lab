defmodule CounterTest do
  use ExUnit.Case

  test "increments the count by the given number of steps" do
    assert Counter.Core.increase(0, 1) == 1
    assert Counter.Core.increase(2, 3) == 5
  end
end
