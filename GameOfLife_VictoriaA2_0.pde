GameObject [][] cells;
GameObject [][] gridBuffer;
int cellsize = 7;
int percentage = 10;
int numberOfRows;
int numberofColumns;
//Percent and size
  
void setup() 
{   //center, so that it starts in the middle of the screen
    size (700, 500);
    rectMode (CENTER);
    frameRate(5);

    numberofColumns = (int)Math.floor(width/cellsize);
    numberOfRows = (int)Math.floor(height/cellsize);

    cells = new GameObject[numberofColumns][numberOfRows];
    gridBuffer = new GameObject[numberofColumns][numberOfRows];
    //To make the cells stay inside the screen

    for (int x = 0; x < numberofColumns; x++)
    {
        for (int y = 0; y < numberOfRows; y++)
        {
            cells[x][y] = new GameObject (x * cellsize, y * cellsize, cellsize);
            gridBuffer[x][y] = new GameObject (x * cellsize, y * cellsize, cellsize);
            
            //0-100 easier with 10% if its 10 out of 100
            if (random(0, 100) < percentage) 
            {
                cells[x][y].alive = true;
            }
        }
    }
}


void draw() 
{
    background (300, 600, 200);
    //Column and Row for cells
    for (int x = 0; x < numberofColumns; x++) 
    {
        for (int y = 1; y < numberOfRows; y++) 
        {
            cells[x][y].draw();
        }  
    }
   
    updateGrid();
}


void updateGrid()
{   //Column and Row for neighbours
    for (int x = 0; x < numberofColumns; x++) 
    {
        for (int y = 0; y < numberOfRows; y++)
        {
            gridBuffer[x][y].alive = Neighbours(x, y);
        }
    }
     
    for (int x = 0; x < numberofColumns; x++) 
    {
        for (int y = 0; y < numberOfRows; y++) 
        {
            cells[x][y].alive = gridBuffer[x][y].alive;
        }
    }
}


boolean Neighbours(int x, int y) 
{
    int neighbours = 0;
        //make eight if statements instead of two for loops after eachother
    for (int i = -1; i <= 1; i++) 
    {
        for (int v = -1; v <= 1; v++) 
        {    
            if (i == 0 && v == 0)
                continue;

            //too close to the edge, don't look there
            if (x + i >= cells.length || y + v >= cells[0].length || x + i < 0 || y + v < 0)
                continue;
            
            if (cells[x + i][y + v].alive) 
                neighbours++;
            
            if (neighbours > 3)
                return false;
        }
    }
    //neighbours live
    if (neighbours == 3)
        return true;
        
    //neighbours die
    if (neighbours < 2)
        return false;
    
    return cells[x][y].alive;
}


public class GameObject 
{
    float x, y;
    float size;
    //Dead from start, the fewer cells alive
    boolean alive = false;

    public GameObject (float x, float y, float cellsize) 
    {
        this.x = x;
        this.y = y;
        this.size = cellsize;
    }

    void draw() 
    {
        if (alive)
        {   //Object = Cell
            fill (500, 100, 200);
            stroke (500, 100, 200);
            rect (x, y, size, size);
        }
    }
}
