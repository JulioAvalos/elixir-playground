# entries = [
#   %{date: ~D[2023-12-19], title: "Dentist"},
#   %{date: ~D[2023-12-20], title: "Shopping"},
#   %{date: ~D[2023-12-19], title: "Movies"}
# ]

# todo_list = TodoList.new(entries)

defmodule TodoList do

  defstruct next_id: 1, entries: %{}

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %TodoList{},
      fn entry, todo_list_acc ->
        add_entry(todo_list_acc, entry)
      end
    )
  end

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


end
