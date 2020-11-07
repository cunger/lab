module State

export empty_board, populate, next_generation

struct Board
  width :: Int64
  height :: Int64
  cells :: Matrix{Bool}
end

function empty_board(width::Int64, height::Int64) :: Board
  Board(width, height, Matrix{Bool}(false, width, height))
end

function populate(board::Board, cells::Array{Tuple{Int64, Int64}})
end

function next_generation(board::Board) :: Board
end

end
