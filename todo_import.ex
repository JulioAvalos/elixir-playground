defmodule TodoList do

  defstruct next_id: 1, entries: %{}

  # Create a new todo list from a list of entries
  def new(entries \\ []) do
    Enum.reduce(entries, %TodoList{}, fn entry, todo_list_acc ->
        add_entry(todo_list_acc, entry)
      end)
  end

  # Add a single entry to the todo list
  def add_entry(%TodoList{} = todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.next_id)

    new_entries =
      Map.put(todo_list.entries, todo_list.next_id, entry)

    %TodoList{
      todo_list
      | entries: new_entries,
        next_id: todo_list.next_id + 1
    }
  end

   # Print all entries in a readable format
  def print_all(%TodoList{entries: entries}) do
    IO.puts("\n📋 Your To-Do List:\n")

    entries
    |> Enum.sort_by(fn {id, _} -> id end)
    |> Enum.each(fn {_id, %{date: date, title: title}} ->
      IO.puts("📅 #{date} — #{title}")
    end)

    IO.puts("\n✅ End of list.\n")
  end

end

# todo_list = TodoList.CsvImporter.import("todos.csv")
# content = Stream.map(stream, fn line -> String.trim_trailing(line,"\n") end)
# transformed = Stream.map(content, fn line -> String.split(line, ",") end)
# format_dates = Stream.map(transformed, fn [date, task] ->
#     {:ok, date_struct} = Date.from_iso8601(date)
#     { date_struct, task}
# end)
# todo_list = Stream.map(format_dates, fn {date_struct, task} -> %{date: date_struct, title: task} end)
# Enum.to_list(content) < se hace porque los Streams son perezosos y no se ejecutan hasta que se les pide el resultado

# CSV importer module
defmodule TodoList.CsvImporter do
  def import(filename \\ "todos.csv") do
    filename
    |> File.stream!()
    |> Stream.map(&String.trim_trailing(&1, "\n"))
    |> Stream.map(&String.split(&1, ","))
    |> Stream.map(fn [date, task] ->
      {:ok, date_struct} = Date.from_iso8601(date)
      %{date: date_struct, title: task}
    end)
    |> Enum.to_list()
    |> TodoList.new()
    |> tap(&TodoList.print_all/1)  # Print automatically when done
  end
end
