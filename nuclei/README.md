
_Markov chain simulation of nuclear decay._

## How it works

`Nuclide` models species of nuclei, comprising information about the number of protons
and neutrons, and optionally its energy if it is in an excited state,
as well as its decay constant and possible decay modes if it is not stable.

For example, Nitrogen-14 is a stable isotope with 7 protons and 7 neutrons.
```
nitrogen_14 = Nuclide.new(7, 14)
```

Carbon-14 is an unstable isotope with 6 protons and 8 neutrons, and it decays
to Nitrogen-14 via beta minus decay, with a halflife of 5370 years.
```
carbon_14 = Nuclide.new(6, 14, Halflife.of(5370, :years), [
  %Decay.BetaMinus{
    probability: Probability.of(100, :percent),
    target: nitrogen_14
    energy: Energy.of(0.156, :MeV)
  }
])
```

A `Nucleus` is an instantiation of a nuclide. It is spawned as its own
BEAM process and then loops through its lifetime, once tick at a time.
Currently each tick corresponds to one second. (Gamma decay is therefore
assumed to be instantaneous and is not modeled, except for isomeric transition.)

In each second, the nucleus decides whether it decays or not, and if it does,
a decay mode is chosen based on their probabilities. Depending on that mode,
a new nucleus corresponding to the decay product is spawned, and the decayed
nucleus process stops.

For example, a Bromine-90 nucleus decays via beta minus decay to a Krypton-90
nucleus, releasing 10.35 MeV of energy.
```
35-Br-90 --BetaMinus--> 36-Kr-90 + 10.35 MeV
```
Krypton-90 then further decays to either Rubidium-90 or Rubidium-89.
```
36-Kr-90 --BetaMinus--> 37-Rb-90 + 4.392 MeV
36-Kr-89 --BetaMinus--> 37-Rb-89 + 4.99 MeV
```
Both of which then further decay.
```
37-Rb-90 --BetaMinus--> 38-Sr-90 + 6.587 MeV
37-Rb-89 --BetaMinus--> 38-Sr-89 + 4.501 MeV
```
And so on.

To start a simulation, simply create a pool with a given number of nuclei,
together with the number of ticks the simulation should run:
```
Pool.fill_with(10, Nuclides.bromine_90(), 100)
```

## Build and run

```
mix compile
```

Run tests:
```
mix espec
```

Load in iex:
```
iex -S mix
```
