module mod_initialization
  implicit none

  private
  public :: init_gaussian

contains

  subroutine init_gaussian(h, xcenter, xdecay)
    real, intent(in out) :: h(:)   ! array of x-positions
    integer, intent(in) :: xcenter ! position of peak
    real, intent(in) :: xdecay     ! controls its width
    integer :: x                   ! current position

    do concurrent (x = 1:size(h))
      h(x) = exp(-xdecay * (x - xcenter)**2)
    end do
  end subroutine init_gaussian

end module mod_initialization
