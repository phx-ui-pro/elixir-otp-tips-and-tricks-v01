defmodule SampleApp.Services.StudentService.CacheSpawnerTest do
  use SampleApp.DataCase
  alias SampleApp.Services.StudentService.Cache
  alias SampleApp.Services.StudentService.CacheSpawner

  describe "spawn_child/1" do
    test "SUCCESS: Can spawn a student class cache" do
      assert {:ok, supervisor_pid} = CacheSpawner.spawn_child(student_class_name: "class_a")

      assert [%{pid: pid}] =
               SampleApp.Services.StudentService.StudentRegistryHelper.list_all_students_cache_by_student_class_name(
                 "class_a"
               )

      assert Cache.get_state(pid) == %Cache{students: [], student_class_name: "class_a"}
    end

    test "SUCCESS: Process is not restarted" do
      assert {:ok, supervisor_pid} = CacheSpawner.spawn_child(student_class_name: "class_a")

      assert [%{pid: pid}] =
               SampleApp.Services.StudentService.StudentRegistryHelper.list_all_students_cache_by_student_class_name(
                 "class_a"
               )

      assert GenServer.stop(pid, :abnormal)
      assert Process.alive?(pid) == false

      Process.sleep(100)

      assert [%{pid: pid2}] =
               SampleApp.Services.StudentService.StudentRegistryHelper.list_all_students_cache_by_student_class_name(
                 "class_a"
               )

      assert pid != pid2
    end
  end
end
