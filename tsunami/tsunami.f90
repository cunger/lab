program tsunami
  use iso_fortran_env, only: compiler_version, compiler_options
  use mod_logging, only: log_info, log_error
  use mod_initialization, only: init_gaussian
  use mod_finite_difference, only: finite_difference
  use mod_data2js, only: file_name, prepare_output, write_data

  implicit none

  integer, parameter :: grid_size = 100
  integer, parameter :: time_steps = 5000

  integer :: t

  real, parameter :: dt = 0.02  ! time step [s]
  real, parameter :: dx = 1.    ! grid spacing [m]
  real, parameter :: g  = 9.81  ! gravitational acceleration [m/s²]
  real, parameter :: hmean = 10

  real, dimension(grid_size) :: v  ! water velocity (for each point in the grid)
  real, dimension(grid_size) :: h  ! water height (for each point in the grid)
  real, dimension(grid_size) :: dh ! finite difference of water height

  ! Compiler info

  call log_info('Compiled with: ' // compiler_version() // ' ' // compiler_options())

  ! Check of input parameters.

  if (grid_size < 1) stop 'grid_size must be >= 1'
  if (dt <= 0) stop 'time step dt must be > 0'
  if (dx <= 0) stop 'grid spacing dx must be > 0'

  call prepare_output

  call init_gaussian(h, 25, 0.02)
  call write_data(0, h)

  v = 0.
  do t = 1, time_steps
    v = v - (v * finite_difference(v) + g * finite_difference(h)) / dx * dt
    h = h - finite_difference(v * (hmean + h)) / dx * dt
    call write_data(t, h)
  end do

  call log_info('Data written to: ' // file_name)
end program tsunami
