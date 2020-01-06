FC = gfortran
DEVFLAGS = -g -fcheck=all -fbacktrace
ALLFLAGS = -fcoarray=single
MODULES = mods/mod_*.f90

clean:
	rm *.o *.mod

default: tsunami.f90
	$(FC) $(DEVFLAGS) $(ALLFLAGS) -c $(MODULES)
	$(FC) $(DEVFLAGS) $(ALLFLAGS) -c $^
	$(FC) *.o -o tsunami
	rm *.o *.mod

build: tsunami.f90
	$(FC) $(ALLFLAGS) -c $(MODULES)
	$(FC) $(ALLFLAGS) -c $^
	$(FC) *.o -o tsunami
	rm *.o *.mod

test: tests/test_mod_parallel.f90
	$(FC) $(ALLFLAGS) -c mods/mod_parallel.f90
	$(FC) $(ALLFLAGS) -c $^
	$(FC) *.o -o test
	rm *.o *.mod
	./test
