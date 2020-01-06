program test_mod_parallel
  use mod_parallel, only: tiles

  integer, dimension(3, 2) :: ts
  integer :: i

  ts = tiles(10, 3)
  ! ts = tiles(10, num_images())

  do i = 1, 3
    write(*,*) ts(i, 1), ts(i, 2)
  end do
end program test_mod_parallel
