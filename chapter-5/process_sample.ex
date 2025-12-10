# theory behind concurrent query execution

run_query = fn query_def -> Process.sleep(2000); "#{query_def} result" end

Enum.map(
  1..5,
  fn index ->
    query_def = "query #{index}"
    run_query.(query_def)
  end
)

# creating processes

spawn(fn ->
  query_result = run_query.("Query 1")
  IO.puts(query_result)
end)


# concurrent lambda function
async_query =
  fn query_def ->
    spawn(
      fn ->
        query_result = run_query.(query_def)
        IO.puts(query_result)
    end)
  end

# call lambda function
# async_query.("Query 1")

# ---- call lambda function multiple times concurrently (using processes)
# Enum.each(1..5, &async_query.("query #{&1}"))

# ---- message passing between processes

# send(self(), "a message")

# receive do
#   message -> IO.puts(message)
# end

# ---- using pattern matching:

# send(self(), {:message, 1})

# receive do
#   {:message, id} ->
#     IO.puts("Received message : #{id}")
# end

# receive do
#   message -> IO.inspect(message)
# after
#   5000 -> IO.puts("message not received")
# end

# send(self(), {:message, 1})

# receive_result =
#   receive do
#     {:message, x} ->
#       x + 2
#   end

# IO.puts(receive_result)

# ---- synchronous sending
# --- collection query results

# run_query =
#   fn query_def ->
#     Process.sleep(2000)
#     "#{query_def} result"
#   end

# async_query =
#   fn query_def ->

#     caller = self()

#     spawn(
#       fn ->
#         query_result = run_query.(query_def)
#         send(caller, {:query_result, query_result})
#       end)
#     end

# call the queries

# Enum.each(1..5, &async_query.("query #{&1}"))

# lets get the result

# get_result =
#   fn ->
#     receive do
#       {:query_result, result} -> result
#     end
#   end

# pull all the messages:
# results = Enum.map(1..5, fn _ -> get_result.() end)

# alternative...
# 1..5
# |> Enum.map(&async_query.("query #{&1}  "))
# |> Enum.map(fn _ -> get_result.() end)
