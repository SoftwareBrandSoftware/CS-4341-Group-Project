package Changer;

import java.io.*;
import java.io.FileNotFoundException;
import java.util.Scanner;


public class FileManipulator {

public static void main(String[] args) {
// TODO Auto-generated method stub
    System.out.println("nothing here");
    System.out.println("        ");    
    System.out.println("        ");
    System.out.println("        ");
   
    readTextFileUsingScanner("C:\\Users\\Ray_R\\eclipse-workspace\\The_Fiel_Manipulator\\src\\Changer\\File3.txt");
   
}

static void RESET() {
System.out.println("DO NOTHING BUT RESET");
}

static void ADD() {
System.out.println("DO NOTHING BUT RESET");
}

static void SUB() {
System.out.println("DO NOTHING BUT RESET");
}

static void MUL() {
System.out.println("DO NOTHING BUT RESET");
}

static void DIV() {
System.out.println("DO NOTHING BUT RESET");
}

static void MOD() {
System.out.println("DO NOTHING BUT RESET");
}

    public static void readTextFileUsingScanner(String fileName)
    {
    BufferedReader br = null;
        try {
            File file = new File(fileName); // java.io.File
            FileReader fr = new FileReader(file); // java.io.FileReader
            br = new BufferedReader(fr); // java.io.BufferedReader
            String line;
            while ((line = br.readLine()) != null) {
              System.out.println(line);
              for(int i = 0; i < line.length(); i++)
              {
             String reset = "0000";
             String add   = "0001";
             String sub   = "0010";
             String mult  = "0011";
             String div   = "0100";
             String mod = "0101";
             if(line == reset) {
             System.out.println("RESET");
             RESET();
             }
             if(line == add) {
             System.out.println("RESET");
            //Read next line to get the digits
             ADD();
             }            
             if(line == sub) {
             System.out.println("RESET");
            //Read next line to get the digits
             SUB();
             }
             if(line == mult) {
             System.out.println("RESET");
            //Read next line to get the digits
             MUL();
             }
             if(line == div) {
             System.out.println("RESET");
            //Read next line to get the digits
             DIV();
             }
             if(line == mod) {
             System.out.println("RESET");
            //Read next line to get the digits
             MOD();
             }
              }
            }
          }
          catch(IOException e) { e.printStackTrace();}
          finally
          {
              try { if (br != null) br.close(); }
              catch(IOException e) { e.printStackTrace(); }
          }
    }
   

}
