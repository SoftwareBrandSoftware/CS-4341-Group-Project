package application;

import javafx.application.Application;
import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.layout.Pane;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import javafx.util.Duration;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.List;

import java.io.PrintWriter;

public class Main extends Application {
	public static byte[] BB;

	@Override
	public void start(Stage arg0) throws Exception {

		// setup scene
		Pane p = new Pane();
		Scene s = new Scene(p, 800, 800, Color.BLUE);

		List<Planet> planets = new ArrayList<>();
		Planet object1 = new Planet(6e24, 0, 0, new Circle(50, Color.YELLOW)); // earth
		planets.add(object1);
		Planet object2 = new Planet(7e22, 900, 0, new Circle(10, Color.GREEN));
		planets.add(object2);
		Planet object3 = new Planet(9e22, 0, 850, new Circle(15, Color.PURPLE));
		planets.add(object3);

		object1.shape.setCenterX(400);
		object1.shape.setCenterY(400);
		object2.shape.setCenterX(400);
		object2.shape.setCenterY(200);
		object3.shape.setCenterX(200);
		object3.shape.setCenterY(600);

		p.getChildren().add(object1.shape);
		p.getChildren().add(object2.shape);
		p.getChildren().add(object3.shape);

		arg0.setTitle("Gravity Sim");
		arg0.setScene(s);
		arg0.show();
		// end setup

		Timeline line = new Timeline(new KeyFrame(Duration.millis(3000), new EventHandler<ActionEvent>() {
			@Override

			public void handle(ActionEvent t) {
				for (Planet i : planets) {
					if (i.shape.getCenterX() == 400 && i.shape.getCenterY() == 400) { // earth is fixed
						continue;
					}
					double fInX = 0;
					double fInY = 0;
					try {
						System.out.println("force");
						for (Planet j : planets) {
							if (!i.equals(j)) {
								// calculate force between i and j
								// add force to force in x direction to total force in x direction for i
								double fTot = PhysicsCalculations.forceGravity(i.mass, j.mass, i.shape.getCenterX(),
										j.shape.getCenterX(), i.shape.getCenterY(), j.shape.getCenterY());
								double hyp = Math.sqrt(Math.pow(j.shape.getCenterX() - i.shape.getCenterX(), 2)
										+ Math.pow(j.shape.getCenterY() - i.shape.getCenterY(), 2));
								fInX += fTot * (j.shape.getCenterX() - i.shape.getCenterX()) / hyp;
								fInY += fTot * (j.shape.getCenterY() - i.shape.getCenterY()) / hyp;
							}
						}


						// calculate new x position for i based on force (in both x and y)
						System.out.println("position");
						i.shape.setCenterX(PhysicsCalculations.positionX(i.shape.getCenterX(), i.velocityX));
						i.shape.setCenterY(PhysicsCalculations.positionX(i.shape.getCenterY(), i.velocityY));
						System.out.println("velocity");
						// calculate new velocity for i based on force (in both x and y)
						i.velocityX = PhysicsCalculations.velocityX(i.velocityX, fInX, i.mass);
						i.velocityY = PhysicsCalculations.velocityX(i.velocityY, fInY, i.mass);
						// System.exit(0);
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					// System.out.println("x force " + fInX + " y force " + fInY + " x vel " +
					// i.velocityX
					// + " y vel " + i.velocityY + " x pos " + i.shape.getCenterX() + " y pos "
					// + i.shape.getCenterY());
					catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}

		}));
		line.setCycleCount(Timeline.INDEFINITE);
		line.play();

	}

	public static void main(String arg2[]) throws IOException {
		Runtime.getRuntime().exec("iverilog verilog.txt");
		launch();
	}
}
