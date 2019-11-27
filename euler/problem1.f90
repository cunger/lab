! ----------------------------------------------------------------------------
! Project Euler - Problem 1
! https://projecteuler.net/problem=1
!
! If we list all the natural numbers below 10 that are multiples of 3 or 5,
! we get 3, 5, 6 and 9. The sum of these multiples is 23.
! Find the sum of all the multiples of 3 or 5 below 1000.
! ----------------------------------------------------------------------------

PROGRAM problem1
  USE arithmetic
  IMPLICIT NONE

  INTEGER :: limit = 1000
  INTEGER :: sum = 0

  sum = sum_of_multiples_of(3, limit) &
      + sum_of_multiples_of(5, limit) &
      - sum_of_multiples_of(15, limit)

  WRITE (*,*) sum

  CONTAINS

  INTEGER FUNCTION sum_of_multiples_of (i, limit) RESULT(sum)
    IMPLICIT NONE

    ! Calculates the sum of all multiples of i from 1 to limit - 1,
    ! using the sum formula of arithmetic series.
    !
    ! For example, the sequence of all multiples of 3 below 1000 is
    ! (3, 6, 9, 12, ..., 999), which we can write as
    ! 3 * (1, 2, 3, 4, ..., 333), the multiple of an arithmetic series
    ! with 333 elements, 1 being the first one and 333 the last one.
    ! The sum thus can be calculates as: 3 * arithmetic_sum(333, 1, 333)
    !
    ! Complexity: O(1)

    INTEGER, INTENT(IN) :: i
    INTEGER, INTENT(IN) :: limit

    INTEGER :: n ! number of elements in the sequence of multiples,
                 ! as well as the last element in that sequence

    n = (limit - 1) / i
    sum = i * arithmetic_sum(n, 1, n)

    RETURN
  END FUNCTION sum_of_multiples_of
END PROGRAM problem1
