/*
1) /data/buttons.xml file is read and buttons are created.
2) Click and drag buttons 
3) on mouse release the buttons.xml is updated and saved.
*/

import java.awt.*;
import proxml.*;

proxml.XMLElement buttons, layouts;
XMLInOut xmlButtons, xmlLayouts;

ArrayList theButtons;
ArrayList theLayouts;

PFont font;

boolean buttonsLocked = false;

void setup() {
  size(800,500);

  theButtons = new ArrayList();
  theLayouts = new ArrayList();

  //proXML object to read in button layout and command information via xml file controllerInfo.xml
  xmlButtons = new XMLInOut(this);
  loadControllerInfo();

  //load font
  font = loadFont("Futura-CondensedMedium-18.vlw");

}


void draw() {
  background(255); //clear the screen each time

  //loop through and display buttons
  for(int i=0; i < theButtons.size(); i++) {
    Button tb = (Button) theButtons.get(i);
    tb.display(); 

  }//end button loop

}

//initialize buttons.xml
void loadControllerInfo() {

  //load ellipses from file if it exists
  xmlButtons = new XMLInOut(this);
  try{
    xmlButtons.loadElement("xml/buttons.xml");

  }
  catch(Exception e){
    println("file not found");
  }
}

//read and create buttons
void xmlEvent(proxml.XMLElement element){
  String currentElement = element.getName();
  println("--------------------------------------");
  println("Loading XML <" + currentElement + ">");


  buttons = element;

  //prepare button objects from xml data
  println("There are  " + buttons.countChildren() + " buttons");
  for(int i =0; i< buttons.countChildren(); i++) {

    proxml.XMLElement tempButton = buttons.getChild(i);
    proxml.XMLElement tempButtonElements[] = tempButton.getChildren();   

    //get the button name
    String buttonName = tempButton.getAttribute("name");
    println(buttonName);
    String buttonImage = "";
    int buttonXPos = 0;
    int buttonYPos = 0;
    String buttonCommand = "";

    //get the button elements
    for(int e=0; e<tempButton.countChildren(); e++ ) {
      proxml.XMLElement tempElement = tempButton.getChild(e);

      if (tempElement.getElement().equals("image")) {
        buttonImage = tempElement.getAttribute("file");
      } 

      else if (tempElement.getElement().equals("command")) {
        buttonCommand = tempElement.getAttribute("value");
      } 

      else if (tempElement.getElement().equals("position")) {
        buttonXPos = Integer.parseInt(tempElement.getAttribute("xpos"));
        buttonYPos = Integer.parseInt(tempElement.getAttribute("ypos"));

      } 

    } //end of for loop for button elements

    Button tb = new Button(buttonName, buttonImage,buttonCommand, buttonXPos, buttonYPos);
    theButtons.add(tb);

  } //end of for loop for buttons   

}


void mouseDragged() {
  if (!buttonsLocked) {

    for(int i=0; i < theButtons.size(); i++ ){
      Button tb = (Button)theButtons.get(i);
      if ( tb.contains(mouseX, mouseY)  ) {

        tb.updatePosition();

      } //end if button contains 


    }  //end for loop

  }
}


void mouseReleased(){
  if (!buttonsLocked ) {

    proxml.XMLElement buttonsXML = new proxml.XMLElement("buttons");


      for(int i=0; i < theButtons.size();i++) {
        Button tmpB =(Button) theButtons.get(i);
        buttonsXML.addChild(tmpB.getXML());
      }
    
    //save updated positions
    xmlButtons.saveElement(buttonsXML,"xml/buttons.xml");

  } //end if buttonslocked

  

}


Button getButtonByName(String name) {
  Button foundButton = null;

  for(int i=0; i<theButtons.size(); i++) {
    Button tButton = (Button) theButtons.get(i);
    if (tButton.name.equals(name)){
      foundButton = tButton; 
    } 
  } 

  return foundButton;
}



