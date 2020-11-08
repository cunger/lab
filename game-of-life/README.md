# Game of Life

### Run game

```
julia> using GameOfLife
julia> GameOfLife.start()
```

The configuration (board dimensions, figure, steps and delay between renders) is specified in `src/config/configuration.jl`.

### Run tests

```
(v1.3) pkg> activate .
GameOfLife> test
```
