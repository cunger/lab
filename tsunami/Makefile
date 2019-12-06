FC = gfortran
DEVFLAGS = -g -fcheck=all -fbacktrace
MODULES = mod_initialization.f90 mod_finite_difference.f90

default: tsunami.f90
	$(FC) $(DEVFLAGS) -c $(MODULES)
	$(FC) $(DEVFLAGS) -c $^
	$(FC) *.o -o tsunami
	rm *.o *.mod

build: tsunami.f90
	$(FC) -c $(MODULES)
	$(FC) -c $^
	$(FC) *.o -o tsunami
	rm *.o *.mod
