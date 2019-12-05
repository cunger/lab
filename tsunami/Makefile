FC = gfortran
DFLAGS = -g
FLAGS = -fcheck=all -fbacktrace
MODULES = mod_initialization.f90 mod_finite_difference.f90

default: tsunami.f90
	$(FC) $(DFLAGS) $(FLAGS) -c $(MODULES)
	$(FC) $(DFLAGS) $(FLAGS) -c $^
	$(FC) *.o -o tsunami
	rm *.o *.mod
