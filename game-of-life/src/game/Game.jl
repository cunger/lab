include("State.jl")

"""
Runs the simulation, given:

* a board
* a view that determines where and how to render the board
* the number of steps to run (the simulation will stop earlier, however,
  if the board already converged)
* the delay between renders (in seconds)
"""
function play(board::Board, view::View, steps::Int64, delay::Float64)
  this = board
  counter = 0

  for i in 1:steps
    view.clear()
    view.render(this)

    next = next_generation(this)

    if same(this, next)
      println("Board converged.")
      break
    end

    this = next
    counter += 1

    sleep(delay)
  end

  println("Simulation stopped after ", counter , " steps.")
end
