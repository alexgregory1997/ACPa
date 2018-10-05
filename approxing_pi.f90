program approxing_pi
  implicit none
  integer, parameter :: dp=selected_real_kind(15,300)
  real(kind=dp)      :: approx_pi, approx_func, rms_error
  integer            :: i, n, ios, n_start, n_final, n_spacing, count, ierr, dim
  real(kind=dp), dimension(:), allocatable :: store_pi_approx

  ! initialise variables
  approx_pi = 0.0_dp
  count = 1

  read*, n_start
  read*, n_final
  read*, n_spacing

  ! dimensions of array
  dim = ((n_final-n_start)/n_spacing)+1

  ! allocate array
  allocate (store_pi_approx(3*dim),stat=ierr)
  if (ierr.ne.0) stop 'error allocating store_pi_approx array'

  ! open files
  open(unit=50, file='pi.dat', iostat=ios)
  if (ios.ne.0) stop 'error opening pi.dat'

  ! loop over different values of n
  do n = n_start, n_final, n_spacing

    ! run the approximate function
    do i = 1,n
      approx_pi = approx_pi + (4.0_dp/real(n,dp))*approx_func(n, i)
    end do

    ! write what n it ran for, the approximation of pi and the root-mean-square error
    write(50,*) n, approx_pi, rms_error(approx_pi)

    ! store error, N and Pi approximation
    store_pi_approx(count)   = rms_error(approx_pi)
    store_pi_approx(count+1) = N
    store_pi_approx(count+2) = approx_pi

    ! count the number of iterations, adding 3 to avoid overwriting data
    count = count + 3

    ! reinitialise for new n
    approx_pi = 0.0_dp

  end do

  ! print minimum value of pi found between two N values and associated N and RMSE
  ! note - I can use this method since the RMSE will always be the smallest value within the array
  ! and associated N and Pi is stored with it
  print*, 'Best Pi Approx:  ', store_pi_approx(minloc(store_pi_approx)+2)
  print*, 'Associated N:    ', store_pi_approx(int(minloc(store_pi_approx)+1))
  print*, 'Associated RMSE: ', minval(store_pi_approx)

  ! close files
  close(unit=50,iostat=ios)
  if (ios.ne.0) stop 'error closing pi.dat file'

  ! deallocate arrays
  deallocate(store_pi_approx,stat=ierr)
  if (ierr.ne.0) stop 'error deallocating store_pi_approx array'

end program approxing_pi

! function containing the summation term of the approximation of pi formula
function approx_func(limit, counter)
  implicit none
  integer, parameter  :: dp=selected_real_kind(15,300)
  real(kind=dp)       :: approx_func
  integer, intent(in) :: limit, counter

  approx_func = 1.0_dp/(1.0_dp+((real(counter,dp)-0.5_dp)/real(limit,dp))**2.0_dp)

end function approx_func

! function for calculating the root-mean-square error
function rms_error(approx_pi)
  implicit none
  integer, parameter       :: dp=selected_real_kind(15,300)
  real(kind=dp), parameter :: pi=3.141592653589793_dp
  real(kind=dp)            :: rms_error, approx_pi

  rms_error = sqrt((pi-approx_pi)**2.0_dp)

end function rms_error
