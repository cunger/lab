
"""
Checks wether a cell at a given coordinate in a given board is alive.
"""
function is_alive(coord::Tuple{Int64, Int64}, board::Board) :: Bool
  board.cells[coord[1], coord[2]]
end

"""
Returns a new board, representing the next generation of the input board,
based on the rules of the game:

* Any live cell with fewer than two live neighbours dies (underpopulation).
* Any live cell with two or three live neighbours lives on to the next generation.
* Any live cell with more than three live neighbours dies (overpopulation).
* Any dead cell with exactly three live neighbours becomes a live cell (reproduction).
"""
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

"""
Checks whether two boards are the same.
"""
function same(board1::Board, board2::Board) :: Bool
  if board1.width != board2.width; return false end
  if board1.height != board2.height; return false end

  board1.cells == board2.cells
end
