class Button {

  Rectangle theRect;
  color theColor;
  String name;
  String commandString;
  PImage buttonImage;
  String imageFilename;
  boolean highlight = false; //show the button label on the screen
  boolean setHighlight = false;

  Boolean active = false; //the button was pressed, needs to be reset?
  float lastPress = 0; //keeps millis of time button was pressed

  int buttonPadding = 20;

  Button(String _name, String _imageFilename, String _commandStr, int _xpos, int _ypos) {
    this.name = _name;

    //load image
    imageFilename = _imageFilename;
    this.buttonImage = loadImage(_imageFilename);

    //command string to send over serial
    this.commandString = _commandStr;

    //preparing the buttonImage
    if (this.buttonImage != null) {
      this.theRect = new Rectangle(_xpos, _ypos,this.buttonImage.width, this.buttonImage.height+this.buttonPadding); 
    }



  }

  Button(Button anotherButton) {
    this.name = anotherButton.name;

    //load image
    imageFilename = anotherButton.imageFilename;
    this.buttonImage = loadImage(anotherButton.imageFilename);

    //command string to send over serial
    this.commandString = anotherButton.commandString;

    this.theRect =  new Rectangle(anotherButton.theRect); 

  }

  void display() {


    image(this.buttonImage, this.theRect.x, this.theRect.y, (float) this.theRect.getWidth(), (float)this.theRect.getHeight()-this.buttonPadding);

    textFont(font);
    fill(238,57,48); //red
    text(this.name, this.theRect.x, (this.theRect.y + (float)this.theRect.getHeight()) );
    noStroke();
    ellipse(this.theRect.x+10+textWidth(this.name), (this.theRect.y + (float)this.theRect.getHeight()-5), 10,10);
    noFill();


  }

  boolean contains( int _x, int _y) {

    return (boolean)this.theRect.contains(_x, _y); 

  }

  void setX(int X) {
    this.theRect.x = X; 
  }

  void setY(int Y) {

    this.theRect.y = Y; 
  }

  int getWidth() {
    return (int)this.theRect.getWidth(); 
  }

  int getHeight() {
    return (int)this.theRect.getHeight();

  }

  void resize(int factor) {

    int newWidth =((int)this.theRect.getWidth())/factor;
    int newHeight =((int)this.theRect.getHeight())/factor;
    this.theRect.setSize(newWidth,newHeight);

  }


  void highlight(boolean _state) {
    this.highlight = _state;
  }

  void setHighlight(boolean _state) {
    this.setHighlight = _state; 
  }

  void updatePosition() {    
    //get offsets
    int offsetX = pmouseX - this.theRect.x;
    int offsetY = pmouseY - this.theRect.y;

    int newX = mouseX - offsetX;
    int newY = mouseY - offsetY;

    if ( (newX > 0) && (newX<width-theRect.width) && (newY>0) && (newY< height-theRect.height-30)) {
      this.theRect.setLocation(newX, newY); 
    }
  }


  void sendCommand() {

    /*
    this.active = true;
     this.lastPress = millis();
     lastButtonPressed = this;
     */
  }


  void resetCommand() {
    this.active = false;
  }


  //return the xmlElement for this button
  proxml.XMLElement getXML() {

    proxml.XMLElement tmpButton =  new proxml.XMLElement("button");
    tmpButton.addAttribute("name",this.name);
    
    proxml.XMLElement tmpImage =  new proxml.XMLElement("image");
    tmpImage.addAttribute("file", this.imageFilename);
    
    proxml.XMLElement tmpPosition =  new proxml.XMLElement("position");
    tmpPosition.addAttribute("xpos",this.theRect.x);
    tmpPosition.addAttribute("ypos",this.theRect.y);
    
    proxml.XMLElement tmpCommand =  new proxml.XMLElement("command");
    tmpCommand.addAttribute("value",this.commandString);

    tmpButton.addChild(tmpImage);
    tmpButton.addChild(tmpPosition);
    tmpButton.addChild(tmpCommand);

    return tmpButton;

  }

}




//global functions

void displayButtonLibrary() {

}





























