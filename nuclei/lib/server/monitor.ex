defmodule Monitor do
  use GenServer

  defmodule Report do
    defstruct [total_energy: 0, particle_count: %{}]
  end

  ## Client

  def start() do
    GenServer.start_link(__MODULE__, %Monitor.Report{})
  end

  def start(num, nuclide) do
    GenServer.start_link(__MODULE__, %Monitor.Report{
      particle_count: %{key(nuclide) => num}
    })
  end

  def report_decay_to(pid, tick, source, event) do
    GenServer.cast(pid, {:decay, tick, source, event})
  end

  def print_total_energy(pid) do
    GenServer.call(pid, {:print, :total_energy})
  end

  def print_particle_count(pid) do
    GenServer.call(pid, {:print, :particle_count})
  end

  ## Server

  @impl true
  def init(report) do
    {:ok, report}
  end

  @impl true
  def handle_call({:print, :total_energy}, _from, report) do
    {:reply, "#{report.total_energy} MeV"}
  end

  @impl true
  def handle_call({:print, :particle_count}, _from, report) do
    {:reply, "#{report.particle_count}"}
  end

  @impl true
  def handle_cast({:decay, tick, source, event}, report) do
    IO.puts("#{tick}: #{source} #{event}")

    updated_particle_count = decrease_count(report.particle_count, source)
    updated_particle_count = Enum.reduce(event.targets, updated_particle_count, fn (target, counts) ->
      increase_count(counts, target)
    end)

    updated_report = %Monitor.Report{
      total_energy: report.total_energy + event.released_energy,
      particle_count: updated_particle_count
    }

    {:noreply, updated_report}
  end

  defp key(nuclide), do: "#{nuclide}"

  defp decrease_count(counts, nuclide) do
    Map.put(counts, key(nuclide), max(0, Map.get(counts, key(nuclide), 0) - 1))
  end

  def increase_count(counts, nuclide) do
    Map.put(counts, key(nuclide), Map.get(counts, key(nuclide), 0) + 1)
  end
end
