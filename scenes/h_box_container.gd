extends HBoxContainer

var heart_full = preload("res://assets/menus/heart.png")
var heart_empty = preload("res://assets/menus/heart_empty.png")

@onready var player = $"../.."

func _process(delta: float) -> void:
	update_empty(player.health)

func update_empty(value):
	for i in get_child_count():
		if value > i:
			get_child(i).texture = heart_full
		else:
			get_child(i).texture = heart_empty
