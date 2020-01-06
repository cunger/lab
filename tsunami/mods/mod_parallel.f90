module mod_parallel
  implicit none

  private
  public :: tiles

contains

  function tiles(array_size, number_of_images)
    integer, intent(in) :: number_of_images
    integer, intent(in) :: array_size
    integer, allocatable, dimension(:,:) :: tiles

    integer :: status
    integer :: tile_size
    integer :: image, index

    tile_size = nint(real(array_size) / real(number_of_images))

    allocate(tiles(number_of_images, 2), stat=status)
    if (status > 0) stop 'not enough memory to allocate `tiles` in mod_parallel'

    index = 0
    do image = 1, number_of_images
      ! start index
      index = index + 1
      tiles(image, 1) = index

      ! end index
      index = min(index + tile_size - 1, array_size)
      if (array_size - index < tile_size / 2.0) then
        index = array_size
      end if

      tiles(image, 2) = index
    end do
  end function tiles
end module mod_parallel
