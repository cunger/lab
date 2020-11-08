# include("types.jl")

"""
Creates an empty board of a given width and height (i.e. filled with dead cells).
"""
function empty_board(width::Int64, height::Int64) :: Board
  Board(width, height, fill(false, width, height))
end

"""
Populates a given board with living cells at the provided coordinates.
"""
function populate(board::Board, coordinates::Array{Tuple{Int64, Int64}})
  for coord in coordinates
    board.cells[coord[1], coord[2]] = true
  end
end

"""
Creates an empty board and populates it with a given Figure in the center
(and empty padding around it).

If the board dimensions are smaller then the Figure, this will throw a BoundsError.
"""
function create_board_with(figure::Figure, width::Int64, height::Int64) :: Board
  if width < figure.width; throw(BoundsError()) end
  if height < figure.height; throw(BoundsError()) end

  x_offset = div((width - figure.width), 2)
  y_offset = div((height - figure.height), 2)

  board = empty_board(width, height)
  populate(board, add_padding(figure.coordinates, x_offset, y_offset))

  return board
end

function add_padding(coordinates::Array{Tuple{Int64, Int64}}, x::Int64, y::Int64)
  map(coord -> (coord[1] + y, coord[2] + x), coordinates)
end
