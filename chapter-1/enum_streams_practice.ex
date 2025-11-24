# lines_lengths!/1	Try mapping each line to String.length(line)
# longest_line_length!/1	Try combining Enum.max_by/2 or Enum.max/1
# longest_line!/1	Try keeping the whole line instead of just its length
# words_per_line!/1	Experiment with String.split(line) and length/1

# stream = File.stream!("sample.txt")
# lines = LargeLines.lines_lengths!(stream)

defmodule LargeLines do

  # Enum.to_list(lines)
  def lines_lengths(stream) do
    stream
    |> Stream.map(&String.length/1)
  end

  # result = LargeLines.longest_line_length(stream)
  def longest_line_length(stream) do
    stream
    |> Stream.map(&String.length/1)
    |> Enum.max()
  end

  def longest_line(stream) do
    stream
    |> Enum.max_by(&String.length/1)
  end

  def words_per_line(stream) do
    stream
    |> Stream.map(&String.split(&1))
    |> Stream.map(&length/1)
  end


end
