defmodule Pool do
  @moduledoc """
  
  """

  def fill_with(num, nuclide, ticks) do
    {:ok, monitor} = Monitor.start

    Nucleus.spawn(num, nuclide, ticks, monitor)
  end
end
