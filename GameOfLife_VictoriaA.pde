  public class GameObject 
  {
    float x, y;
    float size;
  
    boolean alive = false;
  
    public GameObject (float x, float y, float cellsize) 
  {
    this.x = x;
    this.y = y;
    this.size = 7;
  }
  
    void draw() 
  {
        if (alive) {
        fill (500, 100, 200);
        stroke (500, 100, 200);
        rect (x, y, size, size);
    }
  }
}

        GameObject [][] Cells;
        GameObject [][] gridBuffer;
        int cellsize = 7;
        int Percentage = 10;
        int numberOfRows;
        int numberofColumns;
        //float cellsize?
  
    void setup() 
  {
      size (700, 500);
      rectMode (CENTER);
      frameRate(5);
    
        numberofColumns = (int)Math.floor(width/cellsize);
        numberOfRows = (int)Math.floor(height/cellsize);
    
        Cells = new GameObject[numberofColumns][numberOfRows];
        gridBuffer = new GameObject[numberofColumns][numberOfRows];
    
        for (int x = 0; x < numberofColumns; x++) {
      
        for (int y = 0; y < numberOfRows; y++) {
      
        Cells[x][y] = new GameObject (x * cellsize, y * cellsize, cellsize);
        gridBuffer[x][y] = new GameObject (x * cellsize, y * cellsize, cellsize);
    
        if (random(0, 300) <Percentage) {
        Cells [x][y].alive = true;
    }
    }
  }  
}
    void draw() {
    background (300, 600, 200);
    
        for (int x = 2; x < numberofColumns-2; x++) {
    
        for (int y = 1; y < numberOfRows-1; y++) {
      
        Cells[x][y].draw();
    }
  }
   
       isAlive(); }
   
    void isAlive() {
     
        for (int x = 0; x < numberofColumns; x++) {
       
        for (int y = 0; y < numberOfRows; y++) {
     
        gridBuffer[x][y].alive = Neighbours (x, y);
    }
  }
     
        for (int x = 0; x < numberofColumns; x++) {
          
        for (int y = 0; y < numberOfRows; y++) {
          
        Cells [x][y].alive = gridBuffer[x][y].alive;
    }
  }
}
        boolean Neighbours(int x, int y) {
        
        int neighbours = 0;
        
        for (int i = -2; i < 2; i++) {
          
        for (int v = -1; v < 2; v++) {
        
        if (i == 0 && v == 0)
        continue;
        
        if (neighbours > 3)
        return false;
        
        if (x + i >= Cells.length||y + v >= Cells[0].length||x + i < 0||y + v < 0)
        continue;
        
        if (Cells[x + i][y + v].alive) {
        neighbours++;
    }
  }
}
        if (neighbours ==3)
        return true;
        
        if (neighbours <2)
        return false;
        
        return Cells[x][y].alive;
}
    
