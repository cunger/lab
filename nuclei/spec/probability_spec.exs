defmodule ProbabilitySpec do
  use ESpec

  alias TimePeriod, as: Halflife

  describe "TimePeriod" do
    it do
      TimePeriod.of(2, :hours) |> should(be 7200)
      TimePeriod.of(1, :day) |> should(be 86_400)
      TimePeriod.of(12.3, :years) |> should(be 387_892_800)
    end
  end

  describe "Decay constant" do
    it do
      Nuclide.new(1, 3, Halflife.of(12.3, :years)).decay_constant
      |> should(be 1.7869555211129088e-9)
    end

    it "A halflife of 1 second leads to a decay probability of ln(2)." do
      Nuclide.new(100, 100, Halflife.of(1, :second)).decay_constant
      |> should(be :math.log(2))
    end
  end
end
