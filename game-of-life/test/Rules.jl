using Test
import GameOfLife.State: empty_board, populate

@testset "populated cell with no neighbor dies of solitude" begin
  board = empty_board(4, 4)
  populate(board, [(2,2)])
  println(board)
  # @test is_empty(board)
end

@testset "populated cell with one neighbor dies of solitude" begin
  board = empty_board(4, 4)
  populate(board, [(2,2), (3,3)])
  print(board)
  # @test is_empty(board)
end

@testset "populated cell with two neighbors survives" begin
end

@testset "populated cell with three neighbors survives" begin
end

@testset "populated cell with four neighbors dies of overpopulation" begin
end

@testset "populated cell with more than four neighbors dies of overpopulation" begin
end

@testset "empty cell with three neighbors becomes populated" begin
end
