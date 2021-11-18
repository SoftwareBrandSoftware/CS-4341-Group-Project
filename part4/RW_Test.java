import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class RW_Test {

	public static void main(String[] args) throws IOException {
		// create the verilog program's input
		FileOutputStream out = null;
		out = new FileOutputStream("v_ops_test.txt");
		
		byte[] opcode = {'1','1','1','1','\n'};
		out.write(opcode);
		byte[] inputB = {'0','0','0','0','1','1','1','1','0','0','1','1','0','0','1','1','\n'};
		out.write(inputB);
		
		opcode[0] = '0';
		opcode[1] = '0';
		opcode[2] = '0';
		opcode[3] = '0';
		out.write(opcode);
		// This loop assigns the binary value of ib to inputB
		int ib = 1;
		int i = 0;
		for(int place = (int) Math.pow(2, 15); place > 0; place /= 2) {
			if(ib / place == 1) {
				ib = ib % place;
				inputB[i] = '1';
			} else {
				inputB[i] = '0';
			}
			i++;
		}
		out.write(inputB);
		
		opcode[0] = '0';
		opcode[1] = '0';
		opcode[2] = '1';
		opcode[3] = '0';
		out.write(opcode);
		// This loop assigns the binary value of ib to inputB
		ib = 2;
		i = 0;
		for(int place = (int) Math.pow(2, 15); place > 0; place /= 2) {
			if(ib / place == 1) {
				ib = ib % place;
				inputB[i] = '1';
			} else {
				inputB[i] = '0';
			}
			i++;
		}
		out.write(inputB);
		
		out.close();
		
		// execute a.out in the current directory
		// unimplemented
		
		// read the verilog program's output
		double values[] = {0, 0, 0};
		FileInputStream in = null;
		in = new FileInputStream("v_out_test.txt");
		
		for(int j = 0; j < 3; j++) {
			double place = Math.pow(2, 31);
			Byte b = (byte) in.read();
			while(b != -1 && b != '\n') {
				if(b == '1') {
					values[j] += place;
				}
				place /= 2;
				b = (byte) in.read();
			}
		}
		
		in.close();
		
		// print values
		for(int j = 0; j < values.length; j++) {
			System.out.print(values[j]);
		}
	}

}
