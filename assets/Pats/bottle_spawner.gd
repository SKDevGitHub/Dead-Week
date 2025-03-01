extends Node2D

@onready var bottle: PackedScene = preload("res://assets/Pats/bottle.tscn")  # Load scene properly
@onready var raycast = $RayCast2D
@onready var sprite = $"../CollisionShape2D/AnimatedSprite2D"
@onready var timer: Timer = $Timer
#@onready var player = 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	timer.timeout.connect(throw)
	timer.start()
	sprite.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer.is_stopped():
		timer.start()
		throw()
func throw() -> void:
	var bottle = load("res://assets/Pats/bottle.tscn")  # Load just before instantiating
	if not bottle:
		print("Error: Failed to load bottle scene!")
		return
	var projectile = bottle.instantiate() 
	add_child(projectile)
	
	projectile.global_position = raycast.global_position
	if raycast.is_colliding():
		var target_pos = raycast.get_collision_point()
		var direction = (target_pos - projectile.global_position).normalized()
		
		projectile.apply_impulse(direction * 100)
	
