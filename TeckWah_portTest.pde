/*
 Author: Benjamin Low (benjamin.low@digimagic.com.sg)
 
 Description: 
 A standalone app to test whether all the serial ports listed in the settings.txt file are working and being detected correctly
 
 Last updated: 2 Feb 2016
 */

import processing.net.*;
import processing.serial.*;

//USER DEFINED SETTINGS
final int NUM_ARDUINOS = 11; 
OS this_OS = OS.WINDOWS; //see other tab for enum def
boolean DEBUG = true; //to see print statements in the Processing IDE console
/*!!!IMPORTANT - define the comports according to the order in the settings.txt file in the other tab*/

Serial[] serialPorts;
SERIALPORTS serialPortIndex; //see other tab for enum def

final int BAUDRATE = 9600;

String[] comport_numbers; 

boolean[] is_port_init;

void setup() {

        size(300, 600);

        textSize(16);

        if (DEBUG) 
        {
                println("this OS: " + this_OS);
                println("Available serial ports: ");
                printArray(Serial.list());
        }

        String[] textlines;

        serialPorts = new Serial[NUM_ARDUINOS];
        is_port_init = new boolean[NUM_ARDUINOS];

        if (this_OS == OS.WINDOWS)  textlines = loadStrings("windows_settings.txt"); 
        else textlines = loadStrings("macosx_settings.txt"); 

        comport_numbers = new String[NUM_ARDUINOS]; 

        for (int i=0; i<NUM_ARDUINOS; i++) 
        { //get the comport numbers
                String[] a_number = split(textlines[i], '=');
                comport_numbers[i] = a_number[1];
        }

        for (int i=0; i<NUM_ARDUINOS; i++) 
        {
                try
                {
                        if (this_OS == OS.MACOSX) 
                        {
                                serialPorts[i] = new Serial(this, "/dev/cu.usbmodem" + comport_numbers[i], BAUDRATE);
                        } 
                        else if (this_OS == OS.WINDOWS)
                        {
                                serialPorts[i] = new Serial(this, "COM" + comport_numbers[i], BAUDRATE);
                        }
                        is_port_init[i] = true;
                }
                catch (RuntimeException e)
                {
                        if (e.getMessage().contains("<init>")) {
                                is_port_init[i] = false;
                        }
                }  
        }
} 


void draw() 
{
        background(0);
       
        text("RFID 1 port:- ", 20, 50);
        if (is_port_init[0]) text("OK", 200, 50);
        else text("NOT OK", 200, 50);
        
        text("RFID 2 port:- ", 20, 100);
        if (is_port_init[1]) text("OK", 200, 100);
        else text("NOT OK", 200, 100);
        
        text("CAPTOUCH 1 port:- ", 20, 150);
        if (is_port_init[2]) text("OK", 200, 150);
        else text("NOT OK", 200, 150);
        
        text("CAPTOUCH 2 port:- ", 20, 200);
        if (is_port_init[3]) text("OK", 200, 200);
        else text("NOT OK", 200, 200);
        
        text("STEPPER 1 port:- ", 20, 250);
        if (is_port_init[4]) text("OK", 200, 250);
        else text("NOT OK", 200, 250);
        
        text("STEPPER 2 port:- ", 20, 300);
        if (is_port_init[5]) text("OK", 200, 300);
        else text("NOT OK", 200, 300);
        
        text("STEPPER 3 port:- ", 20, 350);
        if (is_port_init[6]) text("OK", 200, 350);
        else text("NOT OK", 200, 350);
        
        text("NEOPIXEL 1 port:- ", 20, 400);
        if (is_port_init[7]) text("OK", 200, 400);
        else text("NOT OK", 200, 400);
        
        text("NEOPIXEL 2 port:- ", 20, 450);
        if (is_port_init[8]) text("OK", 200, 450);
        else text("NOT OK", 200, 450);
        
        text("LINEAR ACT 1 port:- ", 20, 500);
        if (is_port_init[9]) text("OK", 200, 500);
        else text("NOT OK", 200, 500);
        
        text("LINEAR ACT 2 port:- ", 20, 550);
        if (is_port_init[10]) text("OK", 200, 550);
        else text("NOT OK", 200, 550);
}

