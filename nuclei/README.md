
Playground for simulating nuclear decay.

Each atom has its own BEAM process. ... ticks, where each tick corresponds to 1 second. For each tick, the atom decides whether to decay or not, where the decay constant is taken as probability that the nucleus decays in that second. If it does, one of the decay modes is chosen based on their probabilities. Gamma decay is assumed to be instantaneous and is thus not modeled, except for isomeric transition.

**Questions:**

* If the half-life is in seconds, is the decay constant indeed the probability of being decayed after delta t of one second?

## TODO

* pool of atoms
* proper logging instead of `IO.puts`
* over all processes, collect total released energy as well as which nuclei currently exist

## Examples

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
