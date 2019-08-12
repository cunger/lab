defmodule Nuclide do
  @moduledoc """
  A species of nuclei.

  Example:

  Nitrogen-14 is a stable isotope:
  > Nuclide.new(7, 14)

  Carbon-14 decays to Nitrogen-14 via B- decay:
  > Nuclide.new(6, 14, Halflife.of(5370, :years), [
      %Decay.BetaMinus{
        probability: Probability.of(100, :percent),
        target: nitrogen_14
        energy: Energy.of(0.156, :MeV)
      }
    ]}
  """

  defstruct [ :a, :z, decay_constant: 0, energy: 0, decay_modes: [] ]

  def new(z, a, halflife) do
    %Nuclide{a: a, z: z,
      decay_constant: DecayConstant.from(halflife)
    }
  end

  def new(z, a, halflife, decays) do
    %Nuclide{a: a, z: z,
      decay_constant: DecayConstant.from(halflife),
      decay_modes: decays
    }
  end

  def tick(nuclide) do
    p = nuclide.decay_constant / 100

    # If Probability.happens(p), then decay
    # (i.e. determine which decay mode based on their probabilities),
    # otherwise stay as you are.
  end

  # Pretty printing

  def to_string(%Nuclide{a: a, z: z, energy: e}) when e > 0 do
    "#{z}-#{Element.symbol(z)}*-#{a}"
  end

  def to_string(%Nuclide{a: a, z: z}) do
    "#{z}-#{Element.symbol(z)}-#{a}"
  end

  defimpl Inspect, for: Nuclide do
    def inspect(nuclide, _opts) do
      Nuclide.to_string(nuclide) <> " #{nuclide.energy} MeV"
    end
  end

  defimpl String.Chars, for: Nuclide do
    def to_string(nuclide) do
      Nuclide.to_string(nuclide)
    end
  end
end
