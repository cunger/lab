module State

export empty_board, populate, next_generation

struct Board
  width :: Int64
  height :: Int64
  cells :: Matrix{Bool}
end

function empty_board(width::Int64, height::Int64) :: Board
  Board(width, height, fill(false, width, height))
end

function populate(board::Board, coordinates::Array{Tuple{Int64, Int64}})
  for coord in coordinates
    board.cells[coord[1], coord[2]] = true
  end
end

function next_generation(board::Board) :: Board
end

end
