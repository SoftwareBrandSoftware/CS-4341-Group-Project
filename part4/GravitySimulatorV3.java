package application;
	
import javafx.application.Application;
import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Bounds;
import javafx.scene.layout.Pane;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import javafx.util.Duration;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import java.nio.ByteBuffer;

public class Main extends Application {
	public final double G = 6.673e-11; 
	public final double offset = 15000;
	public static byte[] BB;

	@Override
	public void start(Stage arg0) throws Exception {
		double mass =  6e24;
		//double offset = 10000;
		boolean fixed = true;
		double gx = 1000;
		double gy = 1000;
		
		double cx = 200;
		double cy = 200;
		
		Pane p = new Pane();
		Scene s = new Scene(p,800,800, Color.BLUE);
		Circle object1 = new Circle(10,Color.GREEN);
		Circle object2 = new Circle(50, Color.YELLOW);
		
		Circle object3 = new Circle(30, Color.PURPLE);
		
		
		object1.setLayoutX(100);
		object2.setLayoutY(100);
		object2.setLayoutX(400);
		object2.setLayoutY(400);
		
		object3.setLayoutX(800);
		object3.setLayoutY(800);
		
		
		p.getChildren().add(object1);
		p.getChildren().add(object2);
		
		p.getChildren().add(object3);
		
		gx = ((G * mass) / Math.pow(Math.sqrt(Math.pow(((object1.getLayoutX()* offset) - (object2.getLayoutX())*offset),2) + Math.pow(((object1.getLayoutY()*offset) - (object2.getLayoutY())*offset),2) ),2))/50;
		
		cx = ((G * mass) / Math.pow(Math.sqrt(Math.pow(((object2.getLayoutX()* offset) - (object3.getLayoutX())*offset),2) + Math.pow(((object2.getLayoutY()*offset) - (object3.getLayoutY())*offset),2) ),2))/50;
		
		arg0.setTitle("Gravity Sim");
		arg0.setScene(s);
		arg0.show();
		
		//Gravitational acceleration = 9.81m/s^2
		//1000 / 20 millis = 50 
		//9.81/50 = 0.1962
		
		gx /= 50;
		System.out.print(gx);
		
		Timeline line = new Timeline(new KeyFrame(Duration.millis(20), new EventHandler <ActionEvent>()
				{
			
			double x_vel = 0;
			double y_vel = 0;
			
			double gx = ((G * mass) / Math.pow(Math.sqrt(Math.pow(((object1.getLayoutX()* offset) - (object2.getLayoutX())*offset),2) + Math.pow(((object1.getLayoutY()*offset) - (object2.getLayoutY())*offset),2) ),2))/50;
			
			double xx_vel = 100;
			double yy_vel = 100;
			
			double cx = ((G * mass) / Math.pow(Math.sqrt(Math.pow(((object1.getLayoutX()* offset) - (object2.getLayoutX())*offset),2) + Math.pow(((object1.getLayoutY()*offset) - (object2.getLayoutY())*offset),2) ),2))/50;
			//double 
			
			@Override
			public void handle(ActionEvent t) {
				object1.setLayoutX(object1.getLayoutX() + x_vel);
				object1.setLayoutY(object1.getLayoutY() + y_vel);
				
				Bounds boundaries = p.getBoundsInLocal();
				
				if(object1.getLayoutX() <= (400))
						{
					           x_vel = x_vel + gx;
						}
				else if(	object1.getLayoutX() >=  (400) )
	
				{
					 x_vel = x_vel - gx;
				}
				if(object1.getLayoutY() >= (400))
				{
					y_vel = y_vel - gx;
				}
				else if(object1.getLayoutY() <= (400))
				{
					y_vel = y_vel + gx;
				}
				
				
				object3.setLayoutX(object2.getLayoutX() + xx_vel);  //change to object 1
				object3.setLayoutY(object1.getLayoutY() + yy_vel);  //change to object 1
				
				       boundaries = p.getBoundsInLocal();
				
				 double Convert = ByteBuffer.wrap(BB).getDouble(); // Byte Array to Double. Convert Byte binary digit to Double
				 System.out.println(Convert); 
				 
				if(object3.getLayoutX() <= (600))
				{
			           xx_vel = xx_vel + cx + Convert;   //Subtract Binary Digit from Text file which is now a double
						if(xx_vel > 0)
						{
							xx_vel = xx_vel* -1;
						}
						else
						{
							xx_vel = xx_vel* -1;
						}

				}
				else if( object3.getLayoutX() >=  (600) )
				{
					xx_vel = xx_vel - cx + Convert;
				}
				if(object3.getLayoutY() >= (600))
				{
					yy_vel = yy_vel - cx - Convert;   //Subtract Binary Digit from Text file which is now a Double 
				}
				else if(object3.getLayoutY() <= (600))
				{
					yy_vel = yy_vel + cx + Convert;
					if(yy_vel > 0)
					{
						yy_vel = yy_vel* -1;
					}
					else
					{
						yy_vel = yy_vel* -1;
					}

				}
				
				
			}
			
		}));
		line.setCycleCount(Timeline.INDEFINITE);
		line.play();
		
	}
	

	
	public static void main(String arg2[]) throws IOException
	{
		launch();
		
		// create the verilog program's input
		FileOutputStream out = null;
		out = new FileOutputStream("C:\\Users\\User\\eclipse-workspace\\Tester\\src\\v_ops_test.txt");
		
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
		
		BB = inputB;
		
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
		in = new FileInputStream("C:\\Users\\User\\eclipse-workspace\\Tester\\src\\v_out_test.txt");
		
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
