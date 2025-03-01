extends Control

@export var display_time: float = 3.0
@export var font_size: int = 10  # Set a fixed font size
@onready var message_label: Label = find_child("Label", true, false)
@onready var bubble_background: NinePatchRect = find_child("NinePatchRect", true, false)  # Optional background

func _ready() -> void:
	hide()  # Ensures the speech bubble is hidden initially
	if message_label:
		message_label.add_theme_font_size_override("font_size", font_size)  # Set fixed font size

func show_message(message: String) -> void:
	if message_label:
		message_label.text = message
		show()
		await get_tree().create_timer(display_time).timeout
		hide()
	else:
		print("ERROR: Label not found in SpeechBubble")
