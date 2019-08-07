defmodule CounterAPITest do
  use ExUnit.Case

  test "counter initialization through API" do
    pid = Counter.start(0)

    assert Counter.state(pid) == 0
  end

  test "counter ticking through API with steps" do
    pid = Counter.start(0)
    Counter.tick(pid, 2)

    assert Counter.state(pid) == 2
  end

  test "counter ticking through API with default steps" do
    pid = Counter.start(0)
    Counter.tick(pid)

    assert Counter.state(pid) == 1
  end
end
