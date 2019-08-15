defmodule Nucleus do
  @moduledoc """
  A specific nucleus.

  Once it is spawned, it loops through its lifetime, once second at a time.
  In each second, it is decided whether it decays or not, and if it does,
  a decay mode is picked. Depending on that mode, a new nucleus corresponding
  to the decay product is spawned, and the decayed nucleus process stops.
  """

  def spawn(nuclide, ticks) do
    spawn(fn () -> tick(nuclide, ticks) end)
  end

  def tick(nuclide, 0), do: :stop
  def tick(nuclide, remaining_ticks) do
    p = nuclide.decay_constant

    if Probability.happens(p) do
      IO.puts "#{remaining_ticks} #{nuclide} Decaying!"

      decay = Probability.sample(nuclide.decay_modes)
      spawn(decay.target, remaining_ticks - 1)
    else
      IO.puts "#{remaining_ticks} #{nuclide} (decay probability = #{p})"

      tick(nuclide, remaining_ticks - 1)
    end
  end
end
