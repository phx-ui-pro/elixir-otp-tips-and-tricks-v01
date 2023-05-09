defmodule SampleApp.Services.StudentService.CacheSupervisor do
  use Supervisor
  alias SampleApp.Services.StudentService.Cache

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args)
  end

  @impl true
  def init(args) do
    children = [
      {Cache, args}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
