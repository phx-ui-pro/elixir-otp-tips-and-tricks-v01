defmodule SampleApp.Services.StudentService.CacheSpawner do
  alias SampleApp.Services.StudentService.CacheSupervisor

  @doc """
    Example call: SampleApp.Services.StudentService.CacheSpawner.spawn_child(student_class_name: "class_a")
  """
  def spawn_child(args) do
    DynamicSupervisor.start_child(StudentClassSpawner, {CacheSupervisor, args})
  end
end
