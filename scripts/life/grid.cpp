#include "grid.h"
#include <iostream>

Grid::Grid(const int width, const int height) {
	this->cells1 = new bool[width*height];
	this->cells2 = new bool[width*height];
	this->cells = cells1;
	this->width = width;
	this->height = height;
}

Grid::~Grid() {
	delete this->cells;
}

void Grid::tick() {
	bool* newCells = cells==cells1?cells2:cells1;
	std::cout << "buffer " << (newCells == cells2) << std::endl;

	for (int x=0; x<width; x++) {
		for (int y=0; y<height; y++) {
			int alive = 0;
			bool state = getCell(x, y);

			// count alive cells
			for (int nx = -1; nx <= 1; nx++) {
				for (int ny = -1; ny <= 1; ny ++) {
					int myX = x + nx;
					int myY = y + ny;
			
					//if (state) std::cout << myX << "," << myY << std::endl;		

					if (! (nx == 0 && ny == 0) ){
						bool myVal = getCell(myX, myY);
						//if (state) std::cout << "state check" << nx << "," << ny << " alive:" << myVal << std::endl;		
						if (myVal) alive++;
					}
				}
			}


			if (state) {
				//std::cout << "alive: " << alive << std::endl;
				state = (alive ==  2 || alive == 3);
			} else {
				state = (alive == 3) /*|| ((8 - alive) == 6)*/;
			}

			newCells[x + y * width] = state;
		}
	}

	this->cells = newCells;
}

void Grid::setCell(int x, int y, bool val) {
	this->cells[x + y * width] = val;
}

int Grid::getWidth() {
	return width;
}

int Grid::getHeight() {
	return height;
}

bool Grid::getCell(int x, int y) {
	int xMod = x % width;
	int yMod = y % height;
	return this->cells[xMod + yMod * width];
}

void Grid::draw(std::ostream &stream) {
	for (int x=0; x<width; x++) {
		for (int y=0; y<height; y++) {
			stream << (this->cells[x + y * width]?"██":"  ");
		}
		stream << std::endl;
	}
}
