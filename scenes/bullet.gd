extends Area2D

@export var direction:Vector2 = Vector2.ZERO

func _ready():
	pass
	
func _process(delta: float) -> void:
	position += direction* delta * 750

func _on_VisibilityNotifier2D_screen_exited():
	queue_free() 
