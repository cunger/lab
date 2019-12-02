program tsunami
  implicit none

  integer, parameter :: grid_size = 100
  integer, parameter :: time_steps = 100

  real, parameter :: dt = 1. ! time step [s]
  real, parameter :: dx = 1. ! grid spacing [m]
  real, parameter :: v  = 1. ! background flow speed [m/s]

  integer :: x, t

  real, dimension(grid_size) :: h  ! water height (for each point in the grid)
  real, dimension(grid_size) :: dh ! finite difference of water height

  ! For initiating the water height perturbation as a Gaussian shape.
  integer, parameter :: xcenter = 25 ! its position
  real, parameter :: xdecay = 0.02   ! controls its width

  ! Check of input parameters.

  if (grid_size < 1) stop 'grid_size must be > 1'
  if (dt <= 0) stop 'time step dt must be > 0'
  if (dx <= 0) stop 'grid spacing dx must be > 0'
  if (v  <= 0) stop 'background flow speed v must be > 0'

  ! Initiating the blob as a Gaussian shape.
  
  do concurrent (x = 1:grid_size)
    h(x) = exp(-xdecay * (x - xcenter)**2)
  end do

  print *, 0, h

  do t = 1, time_steps
    ! Calculate finite difference dh.
    ! 1. Boundary condition on the left.
    dh(1) = h(1) - h(grid_size)
    ! 2. All other values.
    do concurrent (x = 2:grid_size)
      dh(x) = h(x) - h(x - 1)
    end do

    ! Calculate h for this time-step based on dh.
    do concurrent (x = 1:grid_size)
      h(x) = h(x) - ((v * dh(x)) / dx) * dt
    end do

    print *, t, h
  end do
end program tsunami
