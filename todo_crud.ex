defmodule TodoList do
  defstruct next_id: 1, entries: %{}

  def new(), do: %TodoList{}

  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.next_id)

    new_entries = Map.put(
      todo_list.entries,
      todo_list.next_id,
      entry
    )

    %TodoList{todo_list |
      entries: new_entries,
      next_id: todo_list.next_id + 1
    }
  end

  def entries(todo_list, date) do
    todo_list.entries
    |> Map.values()
    |> Enum.filter(fn entry -> entry.date == date end)
  end

  def update_entry(todo_list, entry_id, updater_fun) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error -> todo_list

      {:ok, old_entry} ->
        new_entry = updater_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        %TodoList{todo_list | entries: new_entries}
    end
  end

  def delete_entry(todo_list, entry_id) do
    new_entries = Map.delete(todo_list.entries, entry_id)
    %TodoList{todo_list | entries: new_entries}
  end

end

# Example usage:
# todo_list = TodoList.new() |> TodoList.add_entry(%{date: ~D[2023-12-19], title: "Dentist"}) |> TodoList.add_entry(%{date: ~D[2023-12-20], title: "Shopping"}) |> TodoList.add_entry(%{date: ~D[2023-12-19], title: "Movies"})
# TodoList.entries(todo_list, ~D[2023-12-19])

# todo_list = TodoList.add_entry(todo_list, %{date: ~D[2023-12-21], title: "Gym"})
# todo_list = TodoList.add_entry(todo_list, %{date: ~D[2025-10-19], title: "Bowling"})

# todo_list = TodoList.update_entry(todo_list, 1, &Map.put(&1, :date, ~D[2025-12-20]))

# todo_list = %{ 1 => %{date: ~D[2023-12-19], title: "Dentist"}, 2 => %{date: ~D[2023-12-20], title: "Shopping"}, 3 => %{date: ~D[2023-12-19], title: "Movies"}}

# put_in(todo_list[3].title, "Theater")

# todo_list = TodoList.delete_entry(todo_list, 4)
