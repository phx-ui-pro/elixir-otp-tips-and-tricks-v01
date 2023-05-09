defmodule SampleApp.Services.StudentService.StudentRegistryHelper do
  @doc """
  Example call: SampleApp.Services.StudentService.StudentRegistryHelper.list_all_caches()
  """
  def list_all_caches() do
    Registry.select(StudentClassRegistry, [{{:"$1", :"$2", :_}, [], [%{id: :"$1", pid: :"$2"}]}])
  end

  @doc """
  Example call: SampleApp.Services.StudentService.StudentRegistryHelper.list_all_students_cache_by_student_class_name("class_a")
  """
  def list_all_students_cache_by_student_class_name(student_class_name) do
    match_all = {:"$1", :"$2", :"$3"}
    guards = [{:==, :"$1", student_class_name}]
    map_result = [%{id: :"$1", pid: :"$2"}]
    Registry.select(StudentClassRegistry, [{match_all, guards, map_result}])
  end
end
