defmodule DecayConstant do
  @moduledoc """
  Calculates the decay constant of a particle given its half-life in seconds.

  Example:

  > DecayConstant.from(Halflife.of(5370, :years))
  """

  def from(seconds) do
    :math.log(2) / seconds
  end
end
