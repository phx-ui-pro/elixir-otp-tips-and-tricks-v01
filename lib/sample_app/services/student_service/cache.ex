defmodule SampleApp.Services.StudentService.Cache do
  defstruct students: [], student_class_name: ""

  @type t :: %__MODULE__{
          students: list(),
          student_class_name: binary()
        }
  use GenServer, restart: :transient
  alias SampleApp.Services.StudentService.Cache
  alias SampleApp.Services.StudentService.Core

  ##############
  # PUBLIC API #
  ##############

  @spec start_link(keyword()) :: GenServer.on_start()
  def start_link([student_class_name: student_class_name] = args) when is_list(args) do
    GenServer.start_link(__MODULE__, args, name: via(student_class_name))
  end

  @doc """
  Example call: SampleApp.Services.StudentService.Cache.get_state(pid)
  """
  @spec get_state(any()) :: Cache.t()
  def get_state(pid) do
    GenServer.call(pid, :get_state)
  end

  #############
  # CALLBACKS #
  #############

  @impl true
  def init(args) do
    {:ok, new(args), {:continue, :fetch_users}}
  end

  @impl true
  def handle_continue(:fetch_users, %__MODULE__{student_class_name: student_class_name} = state) do
    students = Core.list_students(%{"student_class_name" => student_class_name})

    {:noreply, assign_students(state, students)}
  end

  @impl true
  def handle_call(:get_state, _from, %__MODULE__{} = state) do
    {:reply, state, state}
  end

  ############
  # REDUCERS #
  ###########

  @spec assign_students(Cache.t(), list()) :: Cache.t()
  defp assign_students(state, students) do
    %{state | students: students}
  end

  #####################
  # PRIVATE FUNCTIONS #
  #####################

  defp new(), do: __struct__()
  defp new(args), do: __struct__(args)

  defp via(student_class_name) do
    {:via, Registry, {StudentClassRegistry, student_class_name}}
  end
end
