extends Node2D

@onready var timer: Timer = $Timer
@onready var trapdoors = $Trapdoors

func _on_timer_timeout() -> void:
	var childs = trapdoors.get_children()
	if !childs.is_empty():
		childs[0].queue_free()

func _on_trigga_body_entered(body: Node2D) -> void:
	timer.start()
	print("Enter")
