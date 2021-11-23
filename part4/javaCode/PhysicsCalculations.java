package application;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;

public class PhysicsCalculations {
	public static final double G = 6.673e-11;
	public static final double time = 24*3600;  // day in seconds
	public static final double pixToM = 1900000;
	public static final int wait = 500;
	
	// using meters, seconds, kilograms
	
	
	static byte[] set = {'1','1','1','1'};
	static byte[] mult = {'0','0','1','0'};
	static byte[] div = {'0','0','1','1'};
	static byte[] add = {'0','0','0','0'};
	static byte[] noop = {'1','1','0','0'};
	
	
	public static double forceGravity(double mass1, double mass2, double obj1X, double obj2X, double obj1Y, double obj2Y) throws IOException, InterruptedException {
		// F = G(m1*m2)/r^2

		FileOutputStream out = null;
		
		double divisor = (Math.pow((obj1X-obj2X)*pixToM, 2)+Math.pow((obj1Y-obj2Y)*pixToM, 2));
		
		//System.out.println(mass1 + " " + mass2 + " " + divisor);
		byte[][] opcode = {set, div, mult, noop};//mult by G
		byte[] newline = {'\n'};
		//double[] inputs = {mass1, Math.pow(2, 20), mass2, divisor, 0.0};
		double[] inputs = {mass1, divisor, mass2, 0.0};
		
		out = new FileOutputStream("v_ops_test.txt");
		for(int i=0; i<opcode.length; i++) {
			//print to file opcode + \n
			out.write(opcode[i]);
			out.write(newline);
			//print to file input + \n
			out.write(ValueConversions.doubleToByteArr(inputs[i]));
			out.write(newline);
		}
		out.close();
		
		Runtime.getRuntime().exec("vvp a.out");
		
		Thread.sleep(wait);
		
		FileInputStream in = new FileInputStream("v_out_test.txt");
		
		double force = 0;
		double place = Math.pow(2, 127);
		Byte b = (byte) in.read();
		while(b != -1 && b != '\n') {
			if(b == '1') {
				force += place;
			}
			place /= 2;
			b = (byte) in.read();
		}
		in.close();
		//force /=Math.pow(2, 20);
		System.out.println(force*G);
		System.out.println((mass1/divisor*mass2*G));
		
		return force*G; 
	}
	
	public static double positionX(double objX, double objV) throws IOException, InterruptedException {
		// xf = xi + vi*dt
		// or use xf = xi + vi*dt + 0.5*a*dt^2
		FileOutputStream out = null;
		
		byte[][] opcode = {set, mult, div, add, noop};
		byte[] newline = {'\n'};
		double[] inputs = {objV*Math.pow(2, 50), time, pixToM, objX*Math.pow(2, 50), 0.0};
		
		out = new FileOutputStream("v_ops_test.txt");
		for(int i=0; i<opcode.length; i++) {
			//print to file opcode + \n
			out.write(opcode[i]);
			out.write(newline);
			//print to file input + \n
			out.write(ValueConversions.doubleToByteArr(inputs[i]));
			out.write(newline);
		}// output is scaled 
		out.close();
		
		Runtime.getRuntime().exec("vvp a.out");
		
		Thread.sleep(wait);
		FileInputStream in = new FileInputStream("v_out_test.txt");
		
		double position = 0;
		double place = Math.pow(2, 127);
		Byte b = (byte) in.read();
		while(b != -1 && b != '\n') {
			if(b == '1') {
				position += place;
			}
			place /= 2;
			b = (byte) in.read();
		}
		// input is scaled down by 2^50
		position /= Math.pow(2, 50);
		System.out.println(position);
		System.out.println(objX + objV*time/pixToM);

		in.close();

		return position;
		//return objX + objV*time/pixToM;
	}
	
	// when call command line, does java wait for command line operation to finish?
	
	public static double velocityX(double obj1V, double obj1Force, double obj1M) throws IOException, InterruptedException {
		// vf = vi + a(dt)
		// F = m*a
		// a = F/m
		// vf = vi + F/m * dt
		FileOutputStream out = null;

		byte[][] opcode = {set, mult, mult,  div, add, noop};
		byte[] newline = {'\n'};
		double[] inputs = {obj1Force, Math.pow(2, 10), time, obj1M, obj1V*Math.pow(2, 10), 0.0};

		out = new FileOutputStream("v_ops_test.txt");
		for(int i=0; i<opcode.length; i++) {
			//print to file opcode + \n
			out.write(opcode[i]);
			out.write(newline);
			//print to file input + \n
			out.write(ValueConversions.doubleToByteArr(inputs[i]));
			out.write(newline);
		}
		out.close();
		
		Runtime.getRuntime().exec("vvp a.out");
		Thread.sleep(wait);
		
		FileInputStream in = new FileInputStream("v_out_test.txt");
		double velocity = 0;
		double place = Math.pow(2, 127);
		Byte b = (byte) in.read();
		while(b != -1 && b != '\n') {
			if(b == '1') {
				velocity += place;
			}
			place /= 2;
			b = (byte) in.read();
		}
		// input is scaled down by 2^50
		velocity /= Math.pow(2, 10);
		System.out.println(velocity);
		System.out.println(obj1V + obj1Force/obj1M * time);
		in.close();
		
		//System.exit(0);
		return velocity;
		//return obj1V + obj1Force/obj1M * time;
	}
}
