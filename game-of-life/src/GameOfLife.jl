module GameOfLife

include("model/State.jl")
include("model/InitialStates.jl")
include("view/View.jl")
include("view/Console.jl")

function run(board, view, steps, delay)
  for i in 1:steps
    view.clear()
    view.render(board)

    board = State.next_generation(board)

    sleep(delay)
  end
end

run(rip_jon_conway(), Console.new(), 13, 0.5)

end
