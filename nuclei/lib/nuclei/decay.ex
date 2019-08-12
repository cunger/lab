defmodule Decay do
  defmodule Alpha do
    defstruct [:probability, :target, :energy]
  end

  defmodule BetaMinus do
    defstruct [:probability, :target, :energy]
  end

  defmodule BetaPlus do
    defstruct [:probability, :target, :energy]
  end

  defmodule IsomericTransition do
    defstruct [:probability, :energy]
  end

  defmodule ElectronCapture do
    defstruct [:probability, :target, :energy]
  end

  defmodule SpontaneousFission do
    defstruct [:probability, :targets]
  end
end
