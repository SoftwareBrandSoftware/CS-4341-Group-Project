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
    try {
    Scanner sc = new Scanner(new File(fileName));
     while(sc.hasNext())
    {
     String str = sc.nextLine();
              System.out.println(str);

             String reset = "0000";
             String add   = "0001";
             String sub   = "0010";
             String mult  = "0011";
             String div   = "0100";
             String mod   = "0101";
             
             if(str.equals(reset)) {
             System.out.println("RESET");
             RESET();
             }
             if(str.equals(add)) {
             String SecondLine =sc.nextLine();
                  Result(SecondLine);
             System.out.println("ADD");
            //Read next line to get the digits
             ADD();
             }            
             if(str.equals(sub)) {
             String SecondLine =sc.nextLine();
              Result(SecondLine);
             System.out.println("SUB");
            //Read next line to get the digits
             SUB();
             }
             if(str.equals(mult)) {
             String SecondLine =sc.nextLine();
              Result(SecondLine);
             System.out.println("MULT");
            //Read next line to get the digits
             MUL();
             }
             if(str.equals(div)) {
             String SecondLine =sc.nextLine();
              Result(SecondLine);
             System.out.println("DIV");
            //Read next line to get the digits
             DIV();
             }
             if(str.equals(mod)) {
             String SecondLine =sc.nextLine();
              Result(SecondLine);
             System.out.println("MOD");
            //Read next line to get the digits
             MOD();
             }
            //  }
             
            }
 sc.close();
  }catch (IOException e) {
  //TODO
  e.printStackTrace();
  }
    }
}
	
	
	
