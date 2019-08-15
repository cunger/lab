defmodule Bromine90 do

  bromine_90 = Nucleus.new(35, 90, Halflife.of(1.91, :seconds), [
      %Decay.BetaMinus{
        probability: Probability.of(74.8, :percent),
        target: krypton_90
        energy: Energy.of(10.35, :MeV)
      },
      %Decay.BetaMinus{ # Beta + Neutron
        probability: Probability.of(25.2, :percent),
        target: krypton_89
        energy: Energy.of(4.04, :MeV)
      }
    ])

  krypton_89 = Nucleus.new(36, 89)
  krypton_90 = Nucleus.new(36, 90)

  # Simple example of decay of one atom over 10 seconds:
  # Nucleus.spawn(Nuclide.new(1, 3, Halflife.of(2,:seconds), [%Decay.BetaMinus{probability: 1, target: Nuclide.new(1, 1), energy: 4.04}]), 10)
end
