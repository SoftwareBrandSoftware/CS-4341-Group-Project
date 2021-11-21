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

public class Planet {
	public Planet(double mass, double velocityX, double velocityY, Circle shape) {
		this.mass = mass;
		this.velocityX = velocityX;
		this.velocityY = velocityY;
		this.shape = shape;
	}
	double mass;
	double velocityX;
	double velocityY;
	double accelerationX = 0;
	double accelerationY = 0;
	
	Circle shape;
	
}
