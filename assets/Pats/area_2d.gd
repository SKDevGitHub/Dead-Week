extends Area2D

var velocity = Vector2.ZERO  # Initial velocity
var speed = 500  # Initial throw speed
func _ready():
	var angle_radians = deg_to_rad(45)  # Throw angle
	velocity = Vector2.RIGHT.rotated(angle_radians) * speed  # Set initial velocity

func _process(delta):
	velocity.y += gravity * delta  # Simulate gravity
	global_position += velocity * delta  # Move the bottle
