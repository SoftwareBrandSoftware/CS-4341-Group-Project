package application;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class PhysicsCalculations {
	public static final double G = 6.673e-11;
	public static final double time = 3600;  // one minute in hours
	public static final double pixToM = 1900000;
	
	// using meters, seconds, kilograms
	
	
	public static double forceGravity(double mass1, double mass2, double obj1X, double obj2X, double obj1Y, double obj2Y, FileOutputStream out) throws IOException {
		// F = G(m1*m2)/r^2
		byte[] set = {'1','1','1','1'};
		byte[] mult = {'0','0','1','0'};
		byte[] div = {'0','0','1','1'};
		byte[] add = {'0','0','0','0'};
		byte[] noop = {'1','1','0','0'};
		byte[][] opcode = {set, mult, div, add, noop};
		byte[] newline = {'\n'};
		double[] inputs = {0.0, 0.0, 0.0, 0.0, 0.0};
		
		for(int i=0; i<opcode.length; i++) {
			//print to file opcode + \n
			out.write(opcode[i]);
			out.write(newline);
			//print to file input + \n
			out.write(ValueConversions.doubleToByteArr(inputs[i]));
			out.write(newline);
		}
		return G*(mass1*mass2)/(Math.pow((obj1X-obj2X)*pixToM, 2)+Math.pow((obj1Y-obj2Y)*pixToM, 2)); 
	}
	
	public static double positionX(double objX, double objV, FileOutputStream out) throws IOException {
		// xf = xi + vi*dt
		// or use xf = xi + vi*dt + 0.5*a*dt^2
		
		byte[] set = {'1','1','1','1'};
		byte[] mult = {'0','0','1','0'};
		byte[] div = {'0','0','1','1'};
		byte[] add = {'0','0','0','0'};
		byte[] noop = {'1','1','0','0'};
		byte[][] opcode = {set, mult, mult, div, add, noop};
		byte[] newline = {'\n'};
		double[] inputs = {objV, 1000000000.0, time, pixToM, objX, 0.0};
		
		for(int i=0; i<opcode.length; i++) {
			//print to file opcode + \n
			out.write(opcode[i]);
			out.write(newline);
			//print to file input + \n
			out.write(ValueConversions.doubleToByteArr(inputs[i]));
			out.write(newline);
		}// output is scaled by 1000000000
		//call cmd
		//read result
		//return result
		return objX + objV*time/pixToM;
	}
	
	// when call command line, does java wait for command line operation to finish?
	
	public static double velocityX(double obj1V, double obj1Force, double obj1M, FileOutputStream out) throws IOException {
		// vf = vi + a(dt)
		// F = m*a
		// a = F/m
		// vf = vi + F/m * dt
		byte[] set = {'1','1','1','1'};
		byte[] mult = {'0','0','1','0'};
		byte[] div = {'0','0','1','1'};
		byte[] add = {'0','0','0','0'};
		byte[] noop = {'1','1','0','0'};
		byte[][] opcode = {set, mult, div, add, noop};
		byte[] newline = {'\n'};
		double[] inputs = {obj1Force, time, obj1M, obj1V, 0.0};

		for(int i=0; i<opcode.length; i++) {
			//print to file opcode + \n
			out.write(opcode[i]);
			out.write(newline);
			//print to file input + \n
			out.write(ValueConversions.doubleToByteArr(inputs[i]));
			out.write(newline);
		}
		
		return obj1V + obj1Force/obj1M * time;
	}
}
