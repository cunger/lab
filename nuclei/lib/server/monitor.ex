defmodule Monitor do
  use GenServer

  defmodule Report do
    defstruct [total_energy: 0]
  end

  ## Client

  def start() do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def report_decay_to(pid, tick, source, event) do
    GenServer.cast(pid, {:decay, tick, source, event})
  end

  ## Server

  @impl true
  def init(:ok) do
    {:ok, %Monitor.Report{}}
  end

  @impl true
  def handle_cast({:decay, tick, source, event}, report) do
    IO.puts("#{tick}: #{source} #{event} (total: #{report.total_energy + event.released_energy} MeV)")
    {:noreply, %Monitor.Report{ report |
      total_energy: report.total_energy + event.released_energy}
    }
  end
end
