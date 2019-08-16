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
    :math.floor(num * 100) / 10000
  end

  @doc """
  Calculates the probability of a nucleus decaying after some time period,
  given its decay constant.
  """
  def of_decay_after(seconds, decay_constant) do
    min(1, decay_constant * seconds)
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
    # and 6000...10_000 count as `false`.
    # `:rand.uniform` is used to draw one of those integers.
    :rand.uniform(10_000) <= :math.floor(p * 10_000)
  end

  @doc """
  Samples on of the given options based on their probabilities.
  It pressuposes:
  * Each option is assumed to have a method or field `probability/0`.
  * The probabilities of all options sum up to 1.
  """
  def sample(options) do
    # Modelled as randomly drawing from an urn which contains all integers
    # from 1 to 10_000, where each option has a range determined by its
    # probability. For example, for three options with probabilities 0.6,
    # 0.3 and 0.1, `ranges` are [6000, 3000, 1000] and:
    # * if the randomly drawn integer is in 0...6000, option 1 is picked
    # * if it is in 6000...(6000 + 3000), option 2 is picked, and
    # * if it is in (6000 + 3000)...(6000 + 3000 + 1000), option 3 is picked.

    ranges = for option <- options do
      :math.floor(option.probability * 10_000)
    end

    index = ranges
    |> Enum.with_index
    |> find(0, :rand.uniform(10_000))

    Enum.at(options, index)
  end

  defp find([ {range, index} | _ ], offset, draw)
    when draw <= offset + range, do: index
  defp find([ {range, _} | remaining ], offset, draw) do
    find(remaining, range + offset, draw)
  end
end
