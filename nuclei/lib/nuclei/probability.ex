defmodule Probability do

  @doc """
  Constructs a probability in [0,1] from a given percentage.
  Takes into account two significant digits; excess digits
  are cut off without rounding.

  Examples:

  > Probability.of(99.99, :percent)
    0.9999
  > Probability.of(0.016, :percent)
    0.0001
  """
  def of(num, :percent) do
    :math.floor(num * 100) / 10000
  end

  @doc """
  Determines whether the probability `p` happens or not, modelled as a simple
  random drawing from an urn, which is filled according to `p`.
  `p` has to be within [0,1] and the calculation takes into account only
  four significant digits.
  """
  def happens(0), do: false
  def happens(1), do: true
  def happens(p) when p < 0 or p > 1, do: raise("Probability has to be in [0,1].")
  def happens(p) do
    # Modelled as randomly drawing from an urn which contains all integers
    # from 1 to 10_000. The first p * 10_000 integers stand for `true`,
    # the others for `false`. For example, 0.4 means the urn is filled
    # with 10_000 integers, where 1...4000 count as `true`
    # and 6000...10_000 count as `false`. `:rand.uniform` is used to draw
    # one of those integers.
    :rand.uniform(10_000) <= :math.floor(p * 10_000)
  end
end
