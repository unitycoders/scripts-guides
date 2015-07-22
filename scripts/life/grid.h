#include <iostream>

class Grid {
	private:
		bool* cells;
		bool* cells1;
		bool* cells2;
		int width;
		int height;
	
	public:
		Grid(int width, int height);
		~Grid();
		void setCell(int x, int y, bool value);
		bool getCell(int x, int y);
		int getWidth();
		int getHeight();
		void tick();
		void draw(std::ostream &stream);
};

