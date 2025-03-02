extends CharacterBody2D


@onready var sprite = $CollisionShape2D/AnimatedSprite2D
@onready var player = $"../Player/player/CollisionShape2D"
const SPEED = 0
const JUMP_VELOCITY = 0
@export var right = false
var greater = false
var health
var max_health = 5

func _ready() -> void:
	player = get_tree().current_scene.get_node("Player/player")
	health = max_health
	
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

	move_and_slide()
	
func take_damage(damage):
	health -= damage
	if health <= 0:
		die()

func die():
	queue_free()
