defimpl Collectable, for: TodoList do
  def into(original) do
    {original, &into_callback/2}
  end

  defp into_callback(todo_list, {:cont, entry}) do
    TodoList.add_entry(todo_list, entry)
  end

  defp into_callback(todo_list, :done), do: todo_list
  defp into_callback(_todo_list, :halt), do: :ok
end

Enum.into(entries, TodoList.new())

entries = [
%{date: ~D[2023-12-19], title: "Dentist"},
%{date: ~D[2023-12-20], title: "Shopping"},
%{date: ~D[2023-12-19], title: "Movies"}
]
