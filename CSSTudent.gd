extends CharacterBody2D


const SPEED = 50.0
@onready var sprite = $CollisionShape2D/AnimatedSprite2D
@onready var player = $"../Player/player/CollisionShape2D"
@export var right = false
@export var detection_range = 200
var greater = false

func _ready() -> void:
	player = get_tree().current_scene.get_node("Player/player/CollisionShape2D")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	
	if player.global_position.x < self.global_position.x:
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

	if player and global_position.distance_to(player.global_position) < detection_range:
		var direction = (player.global_position - global_position).normalized()
		velocity.x = direction.x * SPEED  # Move only in the X direction
	else:
		velocity.x = 0  # Stop moving when out of range



	move_and_slide()
