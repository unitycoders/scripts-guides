#include <iostream>
#include <random>
#include <unistd.h>

#include "grid.h"

void seed_random(Grid* grid) {
	std::random_device generator;
	std::uniform_int_distribution<int> r(0,1);

	for (int x=0; x<grid->getWidth(); x++) {
		for (int y=0; y<grid->getHeight(); y++) {
			grid->setCell(x, y, (bool)r(generator));
		}
	}
}

void seed_blinker(Grid* grid) {
	grid->setCell(3, 1, true);
	grid->setCell(3, 2, true);
	grid->setCell(3, 3, true);
}

int main(int argc, char* argv[]) {
	Grid* grid = new Grid(20, 50);
	seed_random(grid);

	std::cout << "seed" << std::endl;
	grid->draw(std::cout);
	//grid->tick();

	int i = 0;
	while (true) {
		std::cout << "\033[2J\033[1;1H";
		std::cout << "generation " << i++ << std::endl;
		grid->tick();
		grid->draw(std::cout);
		usleep(10000);
	}

	return 0;
}
