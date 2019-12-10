module mod_logging
  use iso_fortran_env, only: &
    stdout => output_unit, &
    stderr => error_unit

  implicit none

  private
  public :: log_info, log_error

contains

  subroutine log_info(msg)
    character(len=*), intent(in) :: msg

    write(stdout, '(a)') trim(msg)
  end subroutine log_info

  subroutine log_error(msg)
    character(len=*), intent(in) :: msg

    write(stderr, '(a)') trim(msg)
  end subroutine log_error
end module mod_logging
