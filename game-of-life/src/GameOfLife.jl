module GameOfLife

include("game/types.jl")
include("game/SetUp.jl")
include("game/Console.jl")
include("game/Game.jl")

function start()
  include("src/config/configuration.jl")

  board = create_board_with(figure, width, height)
  play(board, console(), steps, delay)
end

end
