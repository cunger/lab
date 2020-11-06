module InitialStates

function rip_jon_conway() :: Board
  width = 11
  height = 11
  cells = Matrix{Bool}(false, width, height)
  board = Board(width, height, cells)

  populate(board, [
    (2,5), (2,6), (2,7),
    (3,5), (3,7),
    (4,5), (4,7),
    (5,6),
    (6,3), (6,5), (6,6), (6,7),
    (7,4), (7,6), (7,8),
    (8,6),
    (8,9),
    (9,5), (9,7),
    (10,5), (10,7)
  ])

  return board
end

end
