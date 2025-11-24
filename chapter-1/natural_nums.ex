defmodule NaturalNums do
  def print(1), do: IO.puts(1)

  def print(n) when is_integer(n) and n > 1 do
    print(n - 1)
    IO.puts(n)
  end

  def print(n) when n <= 0, do: IO.puts("Error: only positive integers allowed")
  def print(n) when not is_integer(n), do: IO.puts("Error: only integers allowed")
end

# You may have noticed that the function won’t work correctly if you
# provide a negative integer or a float. This could be resolved with
# additional guards and is left for you as an exercise.
