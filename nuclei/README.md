
Playground for implementing nuclear decay as a Markov chain Monte Carlo simulation.

Each atom has its own BEAM process. It lives for a given number of ticks, where a tick corresponds to the time resolution. Currently each tick corresponds to one second. Gamma decay is therefore assumed to be instantaneous and is not modeled, except for isomeric transition.

For each tick, the atom decides whether to decay or not, based on its probability to survive the passed time. If it does, one of the decay modes is chosen based on their probabilities. 

## Examples

```
Pool.fill_with(10, Nuclides.bromine_90(), 100)
```

## Build

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
