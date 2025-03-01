extends CharacterBody2D


@onready var sprite = $CollisionShape2D/AnimatedSprite2D
@onready var player = $"../Player/player/CollisionShape2D"
const SPEED = 0
const JUMP_VELOCITY = 0
@export var right = false
var greater = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	
	if player.global_position.x > global_position.x:
		if !greater:
			scale.x = scale.x * -1
			right = true
			print_debug("turning right")
			greater = true

	else:
		if greater:
			right = false
			scale.x = scale.x * -1
			print_debug("turning left")
			greater = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	

	move_and_slide()
