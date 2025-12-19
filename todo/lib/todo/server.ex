defmodule Todo.Server do
  def start do
    server_pid = spawn(fn -> loop(Todo.List.new()) end)
    {:ok, server_pid}
  end

  defp loop(todo_list) do
    new_todo_list =
      receive do
        message -> process_message(todo_list, message)
      end

    loop(new_todo_list)
  end

  def entries(todo_server, date) do
    send(todo_server, {:entries, self(), date})

    receive do
      {:todo_entries, entries} -> entries
    after
      5000 -> {:error, :timeout}
    end
  end

  #
  # --- GROUP ALL process_message CLAUSES HERE ---
  #

  defp process_message(todo_list, {:entries, caller, date}) do
    send(caller, {:todo_entries, Todo.List.entries(todo_list, date)})
    todo_list
  end

  defp process_message(todo_list, {:add_entry, new_entry}) do
    Todo.List.add_entry(todo_list, new_entry)
  end

  defp process_message(todo_list, {:update_entry, entry_id, updater_fun}) do
    Todo.List.update_entry(todo_list, entry_id, updater_fun)
  end

  defp process_message(todo_list, {:delete_entry, entry_id}) do
    Todo.List.delete_entry(todo_list, entry_id)
  end

  #
  # --- PUBLIC API BELOW ---
  #

  def add_entry(todo_server, new_entry) do
    send(todo_server, {:add_entry, new_entry})
  end

  def update_entry(todo_server, entry_id, updater_fun) do
    send(todo_server, {:update_entry, entry_id, updater_fun})
  end

  def delete_entry(todo_server, entry_id) do
    send(todo_server, {:delete_entry, entry_id})
  end
end

# sample usage:
#  {:ok, todo_server} = Todo.Server.start()
# Todo.Server.add_entry(
#  todo_server,
#  %{date: ~D[2025-12-19], title: "Dentist"}
# )

# Todo.Server.entries(todo_server, ~D[2023-12-19])
