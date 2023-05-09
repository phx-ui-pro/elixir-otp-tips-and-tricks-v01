defmodule SampleApp.Services.StudentService.Core do
  def list_students(criteria) do
    student_class_name = Map.get(criteria, "student_class_name")

    [
      %{
        "name" => "Eduardo",
        "student_class_name" => "class_a"
      },
      %{
        "name" => "Jorge",
        "student_class_name" => "class_a"
      },
      %{
        "name" => "Maria",
        "student_class_name" => "class_a"
      },
      %{
        "name" => "Jose",
        "student_class_name" => "class_b"
      },
      %{
        "name" => "Joao",
        "student_class_name" => "class_b"
      },
      %{
        "name" => "Leonardo",
        "student_class_name" => "class_b"
      }
    ]
    |> Enum.filter(fn student ->
      student["student_class_name"] == student_class_name
    end)
  end
end
