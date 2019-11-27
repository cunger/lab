MODULE arithmetic
  IMPLICIT NONE

  CONTAINS

  INTEGER FUNCTION arithmetic_sum (n, a_1, a_n) RESULT(sum)
    IMPLICIT NONE

    ! Calculates the sum of an arithmetic sequence using the
    ! artihmetic series formula: sum = 0.5 * n * (a_1 + a_n)
    ! Where n the number of elements in the sequence,
    ! a_1 is the first and a_n is the last element.

    INTEGER, INTENT(IN) :: n    ! number of elements in the sequence
    INTEGER, INTENT(IN) :: a_1  ! first element
    INTEGER, INTENT(IN) :: a_n  ! last element

    sum = 0.5 * n * (a_1 + a_n)

    RETURN
  END FUNCTION arithmetic_sum
END MODULE arithmetic
