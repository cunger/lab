program tsunami
  use iso_fortran_env, only: compiler_version, compiler_options
  use mod_initialization, only: init_gaussian
  use mod_finite_difference, only: finite_difference

  implicit none

  integer, parameter :: grid_size = 100
  integer, parameter :: time_steps = 5000

  real, parameter :: dt = 0.02  ! time step [s]
  real, parameter :: dx = 1.    ! grid spacing [m]
  real, parameter :: g  = 9.81  ! gravitational acceleration [m/s²]
  real, parameter :: hmean = 10

  real :: x
  integer :: t

  real, dimension(grid_size) :: v  ! water velocity (for each point in the grid)
  real, dimension(grid_size) :: h  ! water height (for each point in the grid)
  real, dimension(grid_size) :: dh ! finite difference of water height

  integer, parameter :: output = 1 ! I/O unit to which the output file is attached
  character(len=23), parameter :: file_name = 'visualization/data2d.js'

  ! Compiler info

  print *, 'Compiled with: ', compiler_version(), ' ', compiler_options()

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

  call finish_output
  print *, 'Data written to: ' // file_name
contains

  subroutine prepare_output
    open(unit = output, file = file_name, status = 'replace', action = 'write')
    write(output, *) 'var data = {'
  end subroutine prepare_output

  subroutine finish_output
    write(output, *) '};'
  end subroutine finish_output

  subroutine write_data(t, h)
    integer, intent(in) :: t
    real, intent(in) :: h(:)
    integer :: i

    100 format ('  ', I4, ': [')
    200 format ('        { x: ', I3, ', h: ', ES11.4, ' },')
    300 format ('  ],')

    write (output, 100) t
    do i = 1, size(h)
      write (output, 200) i, h(i)
    end do
    write (output, 300)
  end subroutine write_data
end program tsunami
