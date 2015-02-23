

import de.bezier.guido.*;
public final static int NUM_ROWS = 30;
public final static int NUM_COLS = 30;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>();//ArrayList of just the minesweeper buttons that are mined
public boolean gameover = false;

public void setup ()
{
    size(600, 600);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    

    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r=0; r < NUM_ROWS; r++)
    {
        for(int c=0; c < NUM_COLS; c++)
        {
            buttons [r] [c] = new MSButton(r,c);
        }
    }
    setBombs();
}
public void setBombs()
{
    while(bombs.size() < 60)
    {
        int row = (int)(Math.random()*NUM_ROWS);
        int col = (int)(Math.random()*NUM_COLS);
        if(bombs.contains(buttons[row][col]) == false)
        {
            bombs.add(buttons[row][col]);
        }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    for(int r=0; r < NUM_ROWS; r++)
    {
        for(int c=0; c < NUM_COLS; c++)
        {
            if(!buttons[r][c].isClicked() && !bombs.contains(buttons[r][c]))
            {
                return false;
            }
        }
    }
    return true;
}
public void displayLosingMessage()
{
    gameover = true;
    for(int r=0; r < NUM_ROWS; r++)
    {
        for(int c=0; c < NUM_COLS; c++)
        {
            if(bombs.contains(buttons[r][c]))
            {
                buttons[r][c].setLabel("B");
            }
        }
    }
    String blah = new String("GAME OVER!");
    for(int i=0; i < blah.length(); i++)
    {
        buttons[15][10+i].setLabel(blah.substring(i,i+1));
    } 

}
public void displayWinningMessage()
{
    String blah = new String("YOU WIN!");
    for(int i=0; i < blah.length(); i++)
    {
        buttons[15][11+i].setLabel(blah.substring(i,i+1));
    }  
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 600/NUM_COLS;
        height = 600/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        if(gameover || isWon()) return;
        if(mouseButton == LEFT)
        {
            clicked = true;
        }
        if(mouseButton == RIGHT && !isClicked())
        {
            marked = !marked;
        }
        else if(bombs.contains(this) && !marked)
        {
            gameover = true;
            displayLosingMessage();
        }
        else if(countBombs(r,c) > 0)
        {
            label = "" + countBombs(r,c);
        }
        else
        {
            if(isValid(r,c-1) && buttons[r][c-1].clicked == false)
            {
                buttons[r][c-1].mousePressed();
            }
            if(isValid(r,c+1) && buttons[r][c+1].clicked == false)
            {
                buttons[r][c+1].mousePressed();
            }
            if(isValid(r-1,c) && buttons[r-1][c].clicked == false)
            {
                buttons[r-1][c].mousePressed();
            }
            if(isValid(r+1,c) && buttons[r+1][c].clicked == false)
            {
                buttons[r+1][c].mousePressed();
            }
            if(isValid(r-1,c-1) && buttons[r-1][c-1].clicked == false)
            {
                buttons[r-1][c-1].mousePressed();
            }
            if(isValid(r-1,c+1) && buttons[r-1][c+1].clicked == false)
            {
                buttons[r-1][c+1].mousePressed();
            }
            if(isValid(r+1,c-1) && buttons[r+1][c-1].clicked == false)
            {
                buttons[r+1][c-1].mousePressed();
            }
            if(isValid(r+1,c+1) && buttons[r+1][c+1].clicked == false)
            {
                buttons[r+1][c+1].mousePressed();
            }
        }
    }
    public void draw () 
    {    
        if (marked)
            fill(0);
        else if(clicked && bombs.contains(this)) 
            fill(255,0,0);
        else if(clicked)
            fill(200);
        else 
            fill(100);

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
        {
            return true;
        }
        //your code here
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row+1,col) && bombs.contains(buttons[row+1][col]))
        {
            numBombs++;
        }
        if(isValid(row-1,col) && bombs.contains(buttons[row-1][col]))
        {
            numBombs++;
        }
        if(isValid(row,col+1) && bombs.contains(buttons[row][col+1]))
        {
            numBombs++;
        }
        if(isValid(row,col-1) && bombs.contains(buttons[row][col-1]))
        {
            numBombs++;
        }
        if(isValid(row+1,col+1) && bombs.contains(buttons[row+1][col+1]))
        {
            numBombs++;
        }
        if(isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1]))
        {
            numBombs++;
        }
        if(isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1]))
        {
            numBombs++;
        }
        if(isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1]))
        {
            numBombs++;
        }
        //your code here
        return numBombs;
    }
}



