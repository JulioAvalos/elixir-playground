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

# spawn(fn ->
# end)
