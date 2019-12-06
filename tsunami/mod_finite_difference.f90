module mod_finite_difference
  implicit none

  private
  public :: finite_difference

contains

  pure function finite_difference(h) result(dh)
    ! Determines at what rate the values in an array change,
    ! based on centered finite difference, i.e. the difference
    ! between the next and the previous element, divided by 2.
    ! Thus, for all elements: dh(x) = 0.5 * (h(x+1) - h(x-1))
    ! Special care needs to be taken of the first element,
    ! as the boundaries of the array are assumed to be connected.

    real, intent(in) :: h(:)
    real :: dh(size(h))

    integer :: length, i
    length = size(h)

    do i = 1, length
      dh(i) = 0.5 * (h(next(i, length)) - h(prev(i, length)))
    end do
  end function finite_difference

  integer pure function prev(index, length)
    integer, intent(in) :: index
    integer, intent(in) :: length

    prev = merge(length, index - 1, index == 1)
  end function prev

  integer pure function next(index, length)
    integer, intent(in) :: index
    integer, intent(in) :: length

    next = merge(1, index + 1, index == length)
  end function next
end module mod_finite_difference
