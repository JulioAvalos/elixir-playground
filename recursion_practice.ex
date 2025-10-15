# recursion practice without using tail call optimization
# implement the following functions using recursion:
# list_len/1 - returns the length of a list
# range/2 - returns a list of integers from 'from' to 'to'
# positive/1 - returns a list of only the positive numbers from a list

#  list = Enum.to_list(1..500_000_000)
defmodule MyList2 do
  def list_len([]), do: 0
  def list_len([_ | tail]), do: 1 + list_len(tail)
end

# MyRange.range(500_000,400_000_000)
defmodule MyRange do
  def range(from, to) when from > to, do: []
  def range(from, to), do: [from | range(from + 1, to)]
end

# MyPositive.positive([-2, 5, 0, 10, -3])
# list = Enum.map(1..1_000_000, fn _ -> Enum.random(-1000..1000) end)
defmodule MyPositive do
  def positive([]), do: []
  def positive([head | tail]) when head > 0, do: [head | positive(tail)]
  def positive([_ | tail]), do: positive(tail)
end
