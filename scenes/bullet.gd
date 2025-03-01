extends Area2D

@onready var area = $"."
@export var direction:Vector2 = Vector2.ZERO
@export var damage = 1

func _ready():
	area.body_entered.connect(on_body_entered)
	
func _process(delta: float) -> void:
	position += direction* delta * 500

func on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free() 
