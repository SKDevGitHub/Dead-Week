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
	spawn_projectile()
func spawn_projectile():
	var projectile = bottle.instantiate() as Node2D  # Use Node2D for manual movement
	add_child(projectile)

	projectile.global_position = global_position  # Start position

	var tween = get_tree().create_tween()

	# Define the arc path
	var peak_position = global_position + Vector2(75, -100)  # Peak of the arc
	var end_position = global_position + Vector2(150, 0)  # End of the arc

	# Move to peak (upward motion)
	tween.tween_property(projectile, "global_position", peak_position, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	# Move to end position (downward motion)
	tween.tween_property(projectile, "global_position", end_position, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
