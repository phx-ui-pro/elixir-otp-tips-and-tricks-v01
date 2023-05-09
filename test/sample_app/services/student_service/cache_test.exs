defmodule SampleApp.Services.StudentService.CacheTest do
  use SampleApp.DataCase
  alias SampleApp.Services.StudentService.Cache

  describe "start_link/1" do
    test "SUCCESS: Can start the cache" do
      assert {:ok, pid} = Cache.start_link(student_class_name: "class_a")
      assert Cache.get_state(pid) == %Cache{students: [], student_class_name: "class_a"}
    end

    test "FAIL: should not be able to create two caches for the name student class" do
      assert {:ok, pid} = Cache.start_link(student_class_name: "class_a")
      assert {:error, {:already_started, ^pid}} = Cache.start_link(student_class_name: "class_a")
    end
  end
end
