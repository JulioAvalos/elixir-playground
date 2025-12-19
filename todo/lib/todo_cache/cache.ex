defmodule Todo.Cache do
  use GenServer

  def init(_) do
    {:ok, %{}}
  end

  def handle_call({:server_process, todo_list_name}, _, todo_servers) do
    case Map.fetch(todo_servers, todo_list_name) do
      {:ok, todo_server} ->
        {:reply, todo_server, todo_servers}

      :error ->
        {:ok, new_server} = Todo.Server.start()

        {
          :reply,
          new_server,
          Map.put(todo_servers, todo_list_name, new_server)
        }
    end
  end

  def start do
    GenServer.start(__MODULE__, nil)
  end

  def server_process(cache_pid, todo_list_name) do
    GenServer.call(cache_pid, {:server_process, todo_list_name})
  end


end

# {:ok, cache} = Todo.Cache.start()
# Todo.Cache.server_process(cache, "Bob's list")
# Todo.Cache.server_process(cache, "Bob's list")
# Todo.Cache.server_process(cache, "Alice's list")

# bobs_list = Todo.Cache.server_process(cache, "Bob's list")
# Todo.Server.entries(bobs_list, ~D[2023-12-19])

# Todo.Cache.server_process(cache, "Alice's list") |> Todo.Server.entries(~D[2023-12-19])

# more cache implementations:
# {:ok, cache} = Todo.Cache.start()
# length(Process.list())

# Enum.each(
#   1..100_000,
#   fn index ->
#   Todo.Cache.server_process(cache, "to-do list #{index}")
#   end
# )
