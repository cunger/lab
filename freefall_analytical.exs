defmodule FreeFall do
  @g 9.81 # N/kg

  @doc """
  Exact calculation of the vertical position and velocity at some time t.
  """
  def calculate(height, t) do
    v0 = 0
    y0 = height

    y = y0 + v0 * t - 0.5 * @g * :math.pow(t, 2)
    v = v0 - @g * t

    %{ t: t, y: y, v: v }
  end
end

# Example: free fall from a height of 23.5 m for 2 s

result = FreeFall.calculate(23.5, 2)

IO.puts "t = #{result.t} s"
IO.puts "y = #{result.y} m"
IO.puts "v = #{result.v} m/s"
