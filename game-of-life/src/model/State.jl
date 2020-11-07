module State

export Board, empty_board, populate, next_generation

struct Board
  width :: Int64
  height :: Int64
  cells :: Matrix{Bool}
end

function is_alive(coord::Tuple{Int64, Int64}, board::Board)
  board.cells[coord[1], coord[2]]
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
  next_board = empty_board(board.width, board.height)

  for coord in CartesianIndices(board.cells)
    x = coord[1]
    y = coord[2]

    alive = board.cells[x, y]

    neighbors = view(
      board.cells,
      max(1, (x-1)):min(board.width, (x+1)), # x range
      max(1, (y-1)):min(board.height, (y+1)) # y range
    )

    number_of_neighbors = alive ? count(neighbors) - 1 : count(neighbors)

    if (alive && number_of_neighbors == 2) || (number_of_neighbors == 3)
      next_board.cells[x, y] = true
    else
      next_board.cells[x, y] = false
    end
  end

  next_board
end

end
