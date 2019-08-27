defmodule Pool do
  @moduledoc """

  """

  def fill_with(num, nuclide, ticks) do
    {:ok, monitor} = Monitor.start(num, nuclide)

    pids = Nucleus.spawn(num, nuclide, ticks, monitor)

    # TODO wait while Enum.any? Process.alive?(pid), then:
    # {:reply, total_energy} = Monitor.print_total_energy(monitor)
    # {:reply, particle_count} = Monitor.print_particle_count(monitor)
  end
end
