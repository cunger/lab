defmodule Probability do
  @moduledoc """
  Functionality for taking random decisions based on probabilities.
  """

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
    num / 100
  end

  @doc """
  Calculates the probability of a nucleus decaying after some time period,
  given its decay constant.

  Derived from the decay equation: N(t) = N(0)e^{-\lambda t}.
  N(t)/N(0) is the fraction of nuclides surviving up to time t,
  which can also be seen as the proability of a single nucleus
  to survive until time t. Thus 1 - N(t)/N(0) is the probability
  of that nucleus to have decayed after time t. This probability
  is 1 - e^{-\lambda t}, since N(t)/N(0) = e^{-\lambda t}.
  """
  def of_decay_after(seconds, decay_constant) do
    1 - :math.exp(- decay_constant * seconds)
  end

  @doc """
  Determines whether the probability `p` happens or not, modelled as a simple
  random drawing from an urn, which is filled according to `p`, which has to
  be within [0,1].
  """
  def happens(0), do: false
  def happens(1), do: true
  def happens(p) when p < 0 or p > 1, do: raise("Probability has to be in [0,1].")
  def happens(p) do
    :rand.uniform < p
  end

  @doc """
  Samples on of the given options based on their probabilities.
  It pressuposes:
  * Each option is assumed to have a method or field `probability/0`.
  * The probabilities of all options sum up to 1.
  """
  def sample(options) do
    ranges = for option <- options do
      option.probability
    end

    index = ranges
    |> Enum.with_index
    |> find(0, :rand.uniform)

    Enum.at(options, index)
  end

  defp find([ {range, index} | _ ], offset, draw)
    when draw <= offset + range, do: index
  defp find([ {range, _} | remaining ], offset, draw) do
    find(remaining, range + offset, draw)
  end
end
