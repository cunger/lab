defmodule Monitor do
  use GenServer

  defmodule Report do
    defstruct [total_energy: 0]
  end

  ## Client

  def start() do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def report_released_energy_to(pid, energy) do
    GenServer.cast(pid, {:energy_released, energy})
  end

  ## Server

  @impl true
  def init(:ok) do
    {:ok, %Monitor.Report{}}
  end

  @impl true
  def handle_cast({:energy_released, energy}, report) do
    IO.puts("#{report.total_energy + energy} MeV")
    {:noreply, %Monitor.Report{ report | total_energy: report.total_energy + energy}}
  end
end
