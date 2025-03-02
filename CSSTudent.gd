extends CharacterBody2D


const SPEED = 50.0

@onready var sprite = $AnimatedSprite2D
@onready var player = $"../Player/player/CollisionShape2D"
@onready var death_cloud = $"../Area2D/death_cloud"
@onready var cloud_sprite = $"../Area2D/AnimatedSprite2D2"
@onready var cs_sprite = $AnimatedSprite2D
@onready var cs_collider = $CollisionShape2D
@onready var timer = $"../Timer"
@onready var area2d = $"../Area2D"

@export var right = false
@export var detection_range = 200
var greater = false
var damage = 1
var health
var max_health = 5
var dead = false

func _ready() -> void:
	player = get_tree().current_scene.get_node("Player/player/CollisionShape2D")
	death_cloud.disabled = true
	health = max_health

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	
	if player.global_position.x < self.global_position.x and !dead:
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
		sprite.play("walk")
	else:
		velocity.x = 0  # Stop moving when out of range
		sprite.play("idle")
	
	if player and global_position.distance_to(player.global_position) <= 30:
		dead = true
		die()
	move_and_slide()
	
func take_damage(damage):
	health -= damage
	if health <= 0:
		dead = true
		die()
		
func die():
	timer.start()
	area2d.global_position = global_position + Vector2(0, -20)
	death_cloud.disabled = false
	cloud_sprite.show()
	cloud_sprite.play("gas_cloud")
	cs_sprite.hide()
	cs_collider.disabled = true
	
func _on_timer_timeout() -> void:
	$"..".queue_free()
