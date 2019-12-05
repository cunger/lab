module mod_finite_difference
  implicit none

  private
  public :: finite_difference

contains

  pure function finite_difference(h) result(dh)
    ! Determines at what rate the values in an array change
    ! from one element to the next.
    !
    ! For all elements: dh(x) = h(x) - h(x-1)
    ! Except for the first one, our boundary condition on the left:
    ! The grid is assumed to be connected, i.e. When the blob leaves
    ! the grid at the right side, it enters again at the left side.

    real, intent(in) :: h(:)
    real :: dh(size(h))

    integer :: l
    l = size(h)

    dh(1) = h(1) - h(l)
    dh(2:l) = h(2:l) - h(1:l-1)
  end function finite_difference
end module mod_finite_difference
