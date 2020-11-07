# Game of Life

### Set up

In the Julia REPL, type `]` to enter the package manager.  
```
(v1.3) pkg> dev .
(v1.3) pkg> status
```

### Run tests

```
$ julia test/runtests.jl
```

Or:
```
(v1.3) pkg> activate .
GameOfLife> test
```

### Run game

```
$ julia src/GameOfLife.jl
```
