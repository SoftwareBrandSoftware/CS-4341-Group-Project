package application;

public class ValueConversions {
	public static byte[] doubleToByteArr(double input) {
		int i = 0;
		byte[] inputB = new byte[128];
		for(double place = Math.pow(2, 127); place >= 1; place /= 2) {
			if(input / place >= 1) {
				input = input % place;
				inputB[i] = '1';
			} else {
				inputB[i] = '0';
			}
			i++;
		}
		return inputB;
	}
}
