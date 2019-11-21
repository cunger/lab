PROGRAM helium_balloon
IMPLICIT NONE

! Calculates the time a helium balloon needs to rise to the ceiling
! of MIT's Lobby 7 (corresponding to a height of 26.666 m).
!
! Project assignment of week 2 of the MITx course 'Models in Engineering'.
! Author: Christina Unger

REAL, PARAMETER :: pi = 3.14159
REAL, PARAMETER :: g = 9.81 ! m/s^2

! Gas mix inside the balloon.
REAL, PARAMETER :: density_helium = 0.1785 ! kg/m^3
REAL, PARAMETER :: density_air = 1.293     ! kg/m^3
REAL, PARAMETER :: percentage_air = 0.45

REAL :: density

! Modelling the balloon as a sphere.
REAL, PARAMETER :: mass_balloon = 2.9E-3 ! kg
REAL, PARAMETER :: circumference = 0.8636 ! m ! the other one: 0.7112
REAL, PARAMETER :: cd = 0.4627 ! drag coefficient

REAL :: area, volume, mass

! Parameters of the lobby.
REAL, PARAMETER :: height = 26.666 ! m

! Parameters needed for model 2.
REAL :: path, terminal_velocity, time

! Parameters needed for Euler method.
REAL :: t, dt, rho, beta, gamma, z, dz, ddz

! Observed time for calculating the error.
REAL, PARAMETER :: observed_time = 21.2 ! s ! the other one: 26.2

!--------- Fixed properties of the balloon ------

WRITE (*,*) '---- Balloon ----'

density = density_air * percentage_air + density_helium * (1 - percentage_air)

WRITE (*,*) 'density =', density

volume = (circumference**3) / (6 * pi**2)
area = circumference / pi
mass = mass_balloon + density * volume

WRITE (*,*) 'volume =', volume
WRITE (*,*) 'area =', area
WRITE (*,*) 'mass =', mass

!--------- The path it has to travel ------

WRITE (*,*) '---- Lobby ----'

path = height ! + height * 0.1

WRITE (*,*) 'path =', path, 'm'

!--------- Model 2 ----------------------------

WRITE (*,*) '---- Model 2 ----'

terminal_velocity = SQRT((2 * (density_air * volume - (mass + density_helium * volume)) * g) / (density_air * cd * area))

WRITE (*,*) 'terminal velocity =', terminal_velocity, 'm/s'

time = path / terminal_velocity

WRITE (*,*) 't =', time, 's'

WRITE (*,*) 'error =', 100 * ((time - observed_time) / observed_time), '%'

!--------- Model 3 ----------------------------

WRITE (*,*) '---- Model 3 ----'

t = 0
dt = 0.001

z = 0
dz = 0
ddz = 0

DO WHILE (z < path)
  t = t + dt

  rho = 4.175E-11 * (288.14 - 0.00649 * z)**4.256
  beta = 0.5 * rho * cd * area
  gamma = -1 * ((rho - density) * volume * g - mass_balloon * g)

  z = z + dz * dt + 0.5 * ddz * dt**2
  dz = dz + ddz * dt
  ddz = (-1/mass) * beta * dz**2 - (1/mass) * gamma
END DO

WRITE (*,*) '  t =', t, 's'
WRITE (*,*) '  z =', z, 'm'
WRITE (*,*) ' dz =', dz, 'm/s'
WRITE (*,*) 'ddz =', ddz, 'm/s**2'

WRITE (*,*) 'error =', 100 * ((t - observed_time) / observed_time), '%'

STOP
END PROGRAM helium_balloon
