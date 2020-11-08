
struct Board
  width :: Int64
  height :: Int64
  cells :: Matrix{Bool}
end

struct Figure
  width :: Int64
  height :: Int64
  coordinates :: Array{Tuple{Int64, Int64}}
end

struct View
  clear :: Function
  render :: Function
end
