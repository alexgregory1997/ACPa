program approxing_pi
  implicit none
  integer, parameter :: dp=selected_real_kind(15,300)
  real(kind=dp)      :: approx_pi, approx_func, rms_error
  integer            :: i, n, ios, n_start, n_final, n_spacing

  ! initialise variables
  approx_pi = 0.0_dp

  read*, n_start
  read*, n_final
  read*, n_spacing

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

    ! reinitialise for new n
    approx_pi = 0.0_dp

  end do

  ! close files
  close(unit=50,iostat=ios)
  if (ios.ne.0) stop 'error closing pi.dat file'

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
