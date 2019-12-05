module mod_initialization
  implicit none

  private
  public :: init_gaussian

  integer, parameter :: xcenter = 25 ! position of peak
  real, parameter :: xdecay = 0.02   ! controls its width

contains

  subroutine init_gaussian(h)
    real, intent(in out) :: h(:)
    integer :: x

    do concurrent (x = 1:size(h))
      h(x) = exp(-xdecay * (x - xcenter)**2)
    end do
  end subroutine init_gaussian

end module mod_initialization
