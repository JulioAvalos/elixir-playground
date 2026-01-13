# PersistableTodoCache

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `persistable_todo_cache` to your list of dependencies in `mix.exs`:

```elixir. 
def deps do
  [
    {:persistable_todo_cache, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/persistable_todo_cache>.


test commands: 

> {:ok, cache} = Todo.Cache.start()
> bobs_list = Todo.Cache.server_process(cache, "bobs_list")
> Todo.Server.entries(bobs_list, ~D[2025-12-19])
> Todo.Server.entries(bobs_list, ~D[2023-12-19])

add entries:
<!-- Todo.Server.add_entry(
bobs_list,
%{date: ~D[2023-12-19], title: "Dentist"}
) -->


