defmodule Decay do

  @doc """
  Radioactive dating: Calculates the age of a sample, given the present amount
  of the element in the sample, the initial amount of the element in living
  tissue, and the half-life of the element.

  Since the calculation uses the ratio `present/initial`, it doesn't matter
  which unit is used (as long as they're in the same unit). Also, the age
  will be returned in the same unit as the given half life.
  """
  def age(present, initial, half_life) do
    :math.log(present / initial) / -decay_constant(half_life)
  end

  defp decay_constant(half_life) do
    :math.log(2) / half_life
  end
end

defmodule Example do
  # Example: We have a sample with only 10 percent of the initial amount
  # of carbon-14 left. It is thus ~ 18 935 years old.
  IO.puts "#{Decay.age(5, 50, 5700)} years"
end
