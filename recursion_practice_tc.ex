# recursion practice using tail call optimization
# implement the following functions using recursion:
# list_len/1 - returns the length of a list
# range/2 - returns a list of integers from 'from' to 'to'
# positive/1 - returns a list of only the positive numbers from a list

#  list = Enum.to_list(1..500_000_000)


defmodule MyList2 do
  def list_len(list), do: do_list_len(list, 0)

  defp do_list_len([], acc), do: acc
  defp do_list_len([_ | tail], acc), do: do_list_len(tail, acc + 1)
end

defmodule MyRange do
  def range(from, to), do: do_range(from, to, [])

  defp do_range(from, to, acc) when from > to, do: Enum.reverse(acc)
  defp do_range(from, to, acc), do: do_range(from + 1, to, [from | acc])
end

defmodule MyPositive do
  def positive(list), do: do_positive(list, [])

  defp do_positive([], acc), do: Enum.reverse(acc)
  defp do_positive([head | tail], acc) when head > 0, do: do_positive(tail, [head | acc])
  defp do_positive([_ | tail], acc), do: do_positive(tail, acc)
end
