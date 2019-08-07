defmodule Counter.Server do
  # `count` is the current state, and `new_count` is the new state
  # after listening and reacting to the incoming message.
  def run(count) do
    new_count = listen(count)
    run(new_count)
  end

  def listen(count) do
    # Listen for an incoming message and react as soon as it arrives.
    receive do
      { :tick, step, _pid } ->
        Counter.Core.increase(count, step)

      { :state, pid } ->
        send(pid, { :count, count })
        count
    end
  end
end
