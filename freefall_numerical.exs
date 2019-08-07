defmodule FreeFall do
  @g 9.81 # N/kg

  @doc """
  Approximation of the change in vertical position and velocity
  per time step delta t, given an initial height in meters and
  assuming an initial velocity of 0, until a target time t.
  """
  def approximate(height, t, dt) do
    t0 = 0
    v0 = 0
    y0 = height

    euler(t0, dt, y0, v0, t)
  end

  defp euler(t, _dt, y, v, target_t) when t >= target_t do
    %{ t: t, y: y, v: v }
  end

  defp euler(t, dt, y, v, target_t) do
    y = y + v * dt
    v = v - @g * dt

    euler(t + dt, dt, y, v, target_t)
  end
end

# Example: free fall from a height of 23.5 m for 2 s

result = FreeFall.approximate(23.5, 2, 0.01)

IO.puts "t = #{result.t} s"
IO.puts "y = #{result.y} m"
IO.puts "v = #{result.v} m/s"
