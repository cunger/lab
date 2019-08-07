# Counter

Slightly adapted example from Chapter 1 of [_Designing Elixir Systems with OTP](https://pragprog.com/book/jgotp/designing-elixir-systems-with-otp).

## Example

```
$ iex -S mix

iex(1)> counter_pid = Counter.start(0)
#PID<0.154.0>
iex(2)> Counter.tick(counter_pid)
{:tick, 1, #PID<0.152.0>}
iex(3)> Counter.tick(counter_pid, 10)
{:tick, 10, #PID<0.152.0>}
iex(4)> Counter.state(counter_pid)   
11

```

`Counter.start(0)` spawns a new process, which calls `Counter.Server.run(0)`, which in turn will run `Counter.Server.listen(0)`. Here `0` is the current state, and `listen` just waits for a message. Whenever a message arrives, `listen` will compute the new state (increasing the count to `1` in case of a `:tick` message and leaving the count at `0` in case of a `:state` message) and return it, at which point `Counter.server.run/1` will call itself again with this new state, which then calls `Counter.Server.listen(1)`, which again waits for an incoming message.

In the interaction above, `#PID<0.154.0>` is the PID of the process spawned by `Counter.start/1`, and `#PID<0.152.0>` is `self()`.
