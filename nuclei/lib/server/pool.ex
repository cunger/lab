defmodule Pool do
  # initiate monitoring/logging Agent
  # start nucleus processes and give it the logger's pid, so they can report to him

  def fill_with(num, nuclide, ticks) do
    {:ok, monitor} = Monitor.start

    Nucleus.spawn(num, nuclide, ticks, monitor)
  end
end
