program tsunami
  use iso_fortran_env, only: compiler_version, compiler_options
  use mod_initialization, only: init_gaussian
  use mod_finite_difference, only: finite_difference

  implicit none

  ! Discrete approximation of the advection equation with finite differences:
  !
  !    dh/dt + v*(dh/dt) = 0
  !
  ! Which, spelled out, corresponds to:
  !
  !    (h(x,t+1) - h(x,t))/dt + v*(h(x,t) - h(x-1,t))/dx = 0
  !
  ! Solving for the water height at the next time step, this gives:
  !
  !    h(x,t+1) = h(x,t) + v*(h(x,t) - h(x-1,t))/dx * dt
  !
  ! Where h(x,t) is the water height at the current time step,
  ! (h(x,t) - h(x-1,t))/dx is the gradient, i.e. the rate of change in space,
  ! multiplied by the velocity v, giving the rate of change in time.
  !
  ! We hold only the present time step in memory, calculating h(x) at that
  ! time step by:
  ! * calculating the difference dh(x) = h(x) - h(x-1)
  ! * calculating the new value of h(x)

  integer, parameter :: grid_size = 100
  integer, parameter :: time_steps = 100

  real, parameter :: dt = 1. ! time step [s]
  real, parameter :: dx = 1. ! grid spacing [m]
  real, parameter :: v  = 1. ! background flow speed [m/s]

  integer :: x, t

  real, dimension(grid_size) :: h  ! water height (for each point in the grid)
  real, dimension(grid_size) :: dh ! finite difference of water height

  ! Compiler info

  print *, 'Compiled with: ', compiler_version(), ' ', compiler_options()

  ! Check of input parameters.

  if (grid_size < 1) stop 'grid_size must be >= 1'
  if (dt <= 0) stop 'time step dt must be > 0'
  if (dx <= 0) stop 'grid spacing dx must be > 0'
  if (v  <= 0) stop 'background flow speed v must be > 0'

  call init_gaussian(h)

  print *, 0, h

  do t = 1, time_steps
    h = h - v * finite_difference(h) / dx * dt

    ! print *, t, h
  end do
end program tsunami
