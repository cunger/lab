module mod_data2js
  implicit none

  private
  public :: file_name, prepare_output, finish_output, write_data

  character(len=23), parameter :: file_name = 'visualization/data2d.js'
  integer :: output ! I/O unit to which the output file will be attached

contains

  subroutine prepare_output
    open(newunit = output, file = file_name, status = 'replace', action = 'write')
    write(output, *) 'var data = {'
  end subroutine prepare_output

  subroutine finish_output
    write(output, *) '};'
  end subroutine finish_output

  subroutine write_data(t, h)
    integer, intent(in) :: t
    real, intent(in) :: h(:)
    integer :: i

    character(len=:), allocatable :: format_open, format_element, format_close;
    format_open = '(2x, i4, a3)'
    format_element = '(8x, a5, i3, a5, es11.4, a3)'
    format_close = '(2x, a2)'

    write (output, format_open) t, ': ['
    do i = 1, size(h)
      write (output, format_element) '{ x: ', i, ', h: ', h(i), ' },'
    end do
    write (output, format_close) '],'
  end subroutine write_data
end module mod_data2js
