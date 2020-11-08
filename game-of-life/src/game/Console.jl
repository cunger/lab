
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
  for row in eachrow(board.cells)
    for cell in row
      print(cell ? "o" : "-")
    end
    print("\n")
  end
  print("\n")
end
