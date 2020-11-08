
"""
A view that renders boards to the terminal.
"""
function console() :: View
  View(clear, render)
end

function clear()
  run(`clear`)
end

function render(board)
  for col in eachcol(board.cells)
    for cell in col
      print(cell ? "▪" : "-")
    end
    print("\n")
  end
  print("\n")
end
