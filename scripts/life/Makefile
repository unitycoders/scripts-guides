CPPFLAGS = -Wall -std=c++11

gol : gol.cpp grid.o
	g++ $(CPPFLAGS) gol.cpp grid.o -o gol

%.o: %.cpp
	g++ $(CPPFLAGS) -c $<

clean:
	rm gol grid.o
