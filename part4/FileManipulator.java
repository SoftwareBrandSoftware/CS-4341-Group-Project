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


static public int Result(String Input) {

while(Input != null)
{

}

return 0;
}

static void RESET() {
System.out.println("DO NOTHING BUT RESET");
}

static void ADD() {
System.out.println(" ADD");
}

static void SUB() {
System.out.println(" SUB ");
}

static void MUL() {
System.out.println(" MUL ");
}

static void DIV() {
System.out.println(" DIV ");
}

static void MOD() {
System.out.println(" MOD ");
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
             //for(int i = 0; i < line.length(); i++)
            // {
             String reset = "0000";
             String add   = "0001";
             String sub   = "0010";
             String mult  = "0011";
             String div   = "0100";
             String mod   = "0101";
             
             if(line.equals(reset)) {
             System.out.println("RESET");
             
             RESET();
             }
             if(line.equals(add)) {
             System.out.println("ADD");
            //Read next line to get the digits
             ADD();
             }            
             if(line.equals(sub)) {
             System.out.println("SUB");
            //Read next line to get the digits
             SUB();
             }
             if(line.equals(mult)) {
             System.out.println("MULT");
            //Read next line to get the digits
             MUL();
             }
             if(line.equals(div)) {
             System.out.println("DIV");
            //Read next line to get the digits
             DIV();
             }
             if(line.equals(mod)) {
             System.out.println("MOD");
            //Read next line to get the digits
             MOD();
             }
            //  }
             
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
