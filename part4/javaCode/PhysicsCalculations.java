package application;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigInteger;

public class PhysicsCalculations {
	public static final double G = 6.673e-11;
	public static final double time = 24*3600;  // in seconds
	public static final double pixToM = 1900000;
	
	// using meters, seconds, kilograms
	
	
	static byte[] set = {'1','1','1','1'};
	static byte[] mult = {'0','0','1','0'};
	static byte[] div = {'0','0','1','1'};
	static byte[] add = {'0','0','0','0'};
	static byte[] noop = {'1','1','0','0'};
	
	
	public static double forceGravity(double mass1, double mass2, double obj1X, double obj2X, double obj1Y, double obj2Y) throws IOException {
		// F = G(m1*m2)/r^2
		//FileInputStream in = new FileInputStream("v_out_test.txt");
		//BufferedReader br = new BufferedReader(new InputStreamReader(in));
		FileOutputStream out = null;
		/*
		double divisor = (Math.pow((obj1X-obj2X)*pixToM, 2)+Math.pow((obj1Y-obj2Y)*pixToM, 2));
		
		byte[][] opcode = {set, mult, div, noop};//mult by G
		byte[] newline = {'\n'};
		double[] inputs = {mass1, mass2, divisor, 0.0};
		
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
		//System.out.println(G*(mass1*mass2)/(Math.pow((obj1X-obj2X)*pixToM, 2)+Math.pow((obj1Y-obj2Y)*pixToM, 2)));
		//System.out.println(br.readLine());
		//return 0.0;
		//return ValueConversions.stringToDouble(br.readLine());
		*/
		return G*(mass1*mass2)/(Math.pow((obj1X-obj2X)*pixToM, 2)+Math.pow((obj1Y-obj2Y)*pixToM, 2)); 
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
		
		Thread.sleep(1000);
		FileInputStream in = new FileInputStream("v_out_test.txt");
		BufferedReader br = new BufferedReader(new InputStreamReader(in));
		
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

		br.close();
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
		FileInputStream in = new FileInputStream("v_out_test.txt");
		BufferedReader br = new BufferedReader(new InputStreamReader(in));
		FileOutputStream out = null;

		byte[][] opcode = {set, mult, div, mult, add, noop};
		byte[] newline = {'\n'};
		double[] inputs = {obj1Force, time, obj1M, Math.pow(2, 50), obj1V*Math.pow(2, 50), 0.0};

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
		
		Thread.sleep(1000);
		
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
		velocity /= Math.pow(2, 50);
		
		System.out.println(velocity);
		System.out.println(obj1V + obj1Force/obj1M * time);
		
		//System.exit(0);
		return velocity;
		//return obj1V + obj1Force/obj1M * time;
	}
}
