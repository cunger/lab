defmodule Decay do
  @moduledoc """
  mode = :Alpha
       | :BetaPlus
       | :BetaMinus
       | :IsomericTransition
       | :ElectronCapture
       | :SpontaneousFission
  """

  defstruct [:probability, :mode, :released_energy, :targets]

  def to_string(decay) do
    "--#{decay.mode}--> "
    <> (decay.targets |> Enum.map(&Nuclide.to_string/1) |> Enum.join(", "))
    <> " + #{decay.released_energy} MeV"
  end

  defimpl Inspect, for: Decay do
    def inspect(decay, _opts) do
      Decay.to_string(decay)
    end
  end

  defimpl String.Chars, for: Decay do
    def to_string(decay) do
      Decay.to_string(decay)
    end
  end
end
