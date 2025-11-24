
# script to read lines from standard input until an empty line is encountered
# usage: elixir input_reader_example.exs
# then type lines followed by Enter, and finish with an empty line

Stream.repeatedly(fn -> IO.gets("> ") end)
|> Stream.map(&String.trim_trailing(&1, "\n"))
|> Enum.take_while(&(&1 != ""))
