defmodule Geometry do

  def area({:rectangle, a, b}) do
    a * b
  end

  def area({:square, a}) do
    a * a
  end

  def area({:circle, r}) do
    r * r * 3.14
  end

  # raise an error for unknown shapes
  def area(unknown) do
    {:error, {:unknown_shape, unknown}}
  end

end
