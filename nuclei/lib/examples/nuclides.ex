defmodule Nuclides do
  alias TimePeriod, as: Halflife
  
  def bromine_90() do
    Nuclide.new(35, 90, Halflife.of(1.91, :seconds), [
      %Decay.BetaMinus{
        probability: Probability.of(74.8, :percent),
        target: krypton_90(),
        energy: Energy.of(10.35, :MeV)
      },
      %Decay.BetaMinus{ # Beta + Neutron
        probability: Probability.of(25.2, :percent),
        target: krypton_89(),
        energy: Energy.of(4.04, :MeV)
      }
    ])
  end

  def krypton_89() do
    Nuclide.new(36, 89, Halflife.of(3.15, :minutes), [
      %Decay.BetaMinus{
        probability: Probability.of(100, :percent),
        target: rubidium_89(),
        energy: Energy.of(4.99, :MeV)
      }
    ])
  end

  def krypton_90() do
    Nuclide.new(36, 90, Halflife.of(32.32, :seconds), [
      %Decay.BetaMinus{
        probability: Probability.of(99.99, :percent),
        target: rubidium_90(),
        energy: Energy.of(4.392, :MeV)
      },
      %Decay.BetaMinus{
        probability: Probability.of(0.01, :percent),
        target: excited_rubidium_90(),
        energy: Energy.of(4.392, :MeV)
      }
    ])
  end

  def rubidium_89() do
    Nuclide.new(37, 89, Halflife.of(15.15, :minutes), [
      %Decay.BetaMinus{
        probability: Probability.of(100, :percent),
        target: strontium_89(),
        energy: Energy.of(4.501, :MeV)
      }
    ])
  end

  def rubidium_90() do
    Nuclide.new(37, 90, Halflife.of(158, :seconds), [
      %Decay.BetaMinus{
        probability: Probability.of(100, :percent),
        target: strontium_90(),
        energy: Energy.of(6.587, :MeV)
      }
    ])
  end

  def excited_rubidium_90() do
    Nuclide.new(37, 90, Energy.of(0.681, :MeV), Halflife.of(3.19, :hours), [
      %Decay.IsomericTransition{
        probability: Probability.of(99.99, :percent),
        target: rubidium_90(),
        energy: Energy.of(0.682, :MeV)
      },
      %Decay.BetaMinus{
        probability: Probability.of(0.01, :percent), # actually: 0.0018%
        target: zirconium_90(),
        energy: Energy.of(2.962, :MeV)
      }
    ])
  end

  def strontium_89() do
    Nuclide.new(38, 89, Halflife.of(50.53, :days), [
      %Decay.BetaMinus{
        probability: Probability.of(100, :percent),
        target: yttrium_89(),
        energy: Energy.of(1.495, :MeV)
      }
    ])
  end

  def strontium_90() do
    Nuclide.new(38, 90, Halflife.of(28.79, :years), [
      %Decay.BetaMinus{
        probability: Probability.of(100, :percent),
        target: yttrium_90(),
        energy: Energy.of(0.546, :MeV)
      }
    ])
  end

  def yttrium_89() do
    Nuclide.new(39, 89)
  end

  def yttrium_90() do
    Nuclide.new(39, 90, Halflife.of(64, :hours), [
      %Decay.BetaMinus{
        probability: Probability.of(100, :percent),
        target: zirconium_90(),
        energy: Energy.of(2.28, :MeV)
      }
    ])
  end

  def zirconium_90() do
    Nuclide.new(40, 90)
  end
end
