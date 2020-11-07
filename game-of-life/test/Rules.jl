using Test
import GameOfLife.State: empty_board, populate, next_generation, is_alive

@time @testset "populated cell with no neighbor dies of solitude" begin
  board = empty_board(4, 4)
  populate(board, [(2,2), (4,4)])

  next_board = next_generation(board)

  @test !is_alive((2,2), next_board)
  @test !is_alive((4,4), next_board)
end

@time @testset "populated cell with one neighbor dies of solitude" begin
  board = empty_board(4, 4)
  populate(board, [(2,2), (3,3)])

  next_board = next_generation(board)

  @test !is_alive((2,2), next_board)
  @test !is_alive((3,3), next_board)
end

@time @testset "populated cell with two neighbors survives" begin
  board = empty_board(4, 4)
  populate(board, [(1,1), (2,2), (3,3)])

  next_board = next_generation(board)

  @test is_alive((2,2), next_board)
  @test !is_alive((1,1), next_board)
  @test !is_alive((3,3), next_board)
end

@time @testset "populated cell with three neighbors survives" begin
  board = empty_board(4, 4)
  populate(board, [(1,1), (1,2), (2,2), (3,3)])

  next_board = next_generation(board)

  @test is_alive((2,2), next_board)
  @test is_alive((2,1), next_board)
  @test is_alive((1,1), next_board)
  @test is_alive((1,2), next_board)
  @test !is_alive((3,3), next_board)
end

@time @testset "populated cell with four neighbors dies of overpopulation" begin
  board = empty_board(4, 4)
  populate(board, [(1,1), (1,2), (2,2), (3,1), (3,3)])

  next_board = next_generation(board)

  @test !is_alive((2,2), next_board)
  @test is_alive((1,1), next_board)
  @test is_alive((1,2), next_board)
  @test !is_alive((3,1), next_board)
  @test !is_alive((3,3), next_board)
end

@time @testset "populated cell with more than four neighbors dies of overpopulation" begin
  board = empty_board(4, 4)
  populate(board, [(1,1), (1,2), (1,3), (2,2), (3,1), (3,3)])

  next_board = next_generation(board)

  @test !is_alive((2,2), next_board)
  @test is_alive((1,1), next_board)
  @test is_alive((1,2), next_board)
  @test is_alive((1,3), next_board)
  @test !is_alive((3,1), next_board)
  @test !is_alive((3,3), next_board)
end

@time @testset "empty cell with three neighbors becomes populated" begin
  board = empty_board(4, 4)
  populate(board, [(1,1), (1,2), (3,3)])

  next_board = next_generation(board)

  @test is_alive((2,2), next_board)
  @test !is_alive((1,1), next_board)
  @test !is_alive((1,2), next_board)
  @test !is_alive((3,3), next_board)
end
