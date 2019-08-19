
Playground for simulating nuclear decay.

Each atom has its own BEAM process. It lives for a given number of ticks, where each tick corresponds to one second. For each tick, the atom decides whether to decay or not, where the decay constant is taken as probability that the nucleus decays in that second. If it does, one of the decay modes is chosen based on their probabilities. Gamma decay is assumed to be instantaneous and is thus not modeled, except for isomeric transition.

**Questions:**

* decay constant -> probability (cf. https://physics.stackexchange.com/a/92285)
* What is "Beta + neutron" decay in the nuclide chart?

## TODO

* pool of atoms
* proper logging instead of `IO.puts`

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
