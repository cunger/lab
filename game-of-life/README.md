# Game of Life

### Run game

```
julia> using GameOfLife
[ Info: Precompiling GameOfLife [4d24e96b-6611-496d-b3f5-dc94928b86e6]

julia> GameOfLife.start()
```

The configuration (board dimensions, figure, steps and delay between renders) is specified in `src/config/configuration.jl`.

### Run tests

```
(v1.3) pkg> activate .
GameOfLife> test
```
