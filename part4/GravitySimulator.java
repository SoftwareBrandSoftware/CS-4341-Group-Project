import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Bounds;
import javafx.scene.Scene;
import javafx.scene.layout.Pane;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import javafx.stage.Stage;
import javafx.util.Duration;

public class GravitySimulator extends Application{

	public final double G = 6.673e-11; 
	public final double offset = 15000;

	@Override
	public void start(Stage arg0) throws Exception {
		double mass =  6e24;
		//double offset = 10000;
		boolean fixed = true;
		double gx = 0;
		double gy = 0;
		Pane p = new Pane();
		Scene s = new Scene(p,800,800, Color.BLUE);
		Circle object1 = new Circle(10,Color.GREEN);
		Circle object2 = new Circle(50, Color.YELLOW);
		object1.setLayoutX(100);
		object2.setLayoutY(100);
		object2.setLayoutX(400);
		object2.setLayoutY(400);
		
		p.getChildren().add(object1);
		p.getChildren().add(object2);
		
		gx = ((G * mass) / Math.pow(Math.sqrt(Math.pow(((object1.getLayoutX()* offset) - (object2.getLayoutX())*offset),2) + Math.pow(((object1.getLayoutY()*offset) - (object2.getLayoutY())*offset),2) ),2))/50;
		
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
				
			}
			
		}));
		line.setCycleCount(Timeline.INDEFINITE);
		line.play();
		
	}
	public static void main(String arg2[])
	{
		launch();
	}
	
}