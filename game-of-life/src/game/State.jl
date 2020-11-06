module State

export Board, populate, next_generation

struct Board
  width :: Int64
  height :: Int64
  cells :: Matrix{Bool}
end

function populate(board::Board, cells::Array{Tuple{Int64, Int64}})
end

function next_generation(board::Board) :: Board
end

end
