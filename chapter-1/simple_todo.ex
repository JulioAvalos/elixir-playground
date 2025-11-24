# script to test functions
# todo_list = TodoList.new() |> TodoList.add_entry(~D[2023-12-19], "Dentist") |> TodoList.add_entry(~D[2023-12-20], "Shopping") |> TodoList.add_entry(~D[2023-12-19], "Movies")
# TodoList.entries(todo_list, ~D[2023-12-19])

defmodule TodoList do

  def new(), do: MultiDict.new()

  def add_entry(todo_list, date, title) do
    MultiDict.add(todo_list, date, title)
  end

  def entries(todo_list, date) do
    MultiDict.get(todo_list, date)
  end

end

# iex todo_multi_dict.ex simple_todo.ex

# entry = %{date: ~D[2023-12-19], title: "Dentist"}
# entry.date
# entry.title
