extends Control
@export var display_time: float = 3.0
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func show_message(message: String) -> void:
	label.text = ""
	show()
	await get_tree().create_timer(display_time).timeout
	hide()
