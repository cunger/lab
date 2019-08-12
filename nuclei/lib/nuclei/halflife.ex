defmodule Halflife do
  @moduledoc """
  Helper for normalizing the halflife of a particle to seconds.

  Example:

  > Halflife.of(2.17, :seconds)
  > Halflife.of(1, :day)
  > Halflife.of(5370, :years)
  """

  def of(num, :s), do: of(num, :seconds)
  def of(num, :sec), do: of(num, :seconds)
  def of(num, :second), do: of(num, :seconds)
  def of(num, :seconds) do
    num
  end

  def of(num, :min), do: of(num, :minutes)
  def of(num, :minute), do: of(num, :minutes)
  def of(num, :minutes) do
    num * 60
  end

  def of(num, :h), do: of(num, :hours)
  def of(num, :hrs), do: of(num, :hours)
  def of(num, :hour), do: of(num, :hours)
  def of(num, :hours) do
    num * 60 * 60
  end

  def of(num, :d), do: of(num, :days)
  def of(num, :day), do: of(num, :days)
  def of(num, :days) do
    num * 24 * 60 * 60
  end

  def of(num, :y), do: of(num, :years)
  def of(num, :yrs), do: of(num, :years)
  def of(num, :year), do: of(num, :years)
  def of(num, :years) do
    num * 365 * 24 * 60 * 60
  end
end
