defmodule MyModule do
  def run do
    IO.puts("Called MyModule.run")
  end
end

MyModule.run

# This is an Elixir script, which is why it has an .exs extension.
# The 's' at the end indicates that this is a script file.

# to run the script and stop BEAM instance after its done
# elixir script.exs

#to keep BEAM instance without terminate it.
# elixir --no-halt script.exs
