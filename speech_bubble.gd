extends Control

@export var text_speed: float = 0.05  # Time per letter
@export var font_size: int = 10
@onready var message_label: Label = find_child("Label", true, false)
@onready var bubble_background: NinePatchRect = find_child("NinePatchRect", true, false)

var character_ref: CharacterBody2D = null  # Store reference to the character
var parent_area: Area2D = null  # Reference to the Area2D script

func _ready() -> void:
	hide()
	if message_label:
		message_label.add_theme_font_size_override("font_size", font_size)

func show_message(message: String, character: CharacterBody2D, area: Area2D) -> void:
	if message_label:
		character_ref = character  
		parent_area = area  # Store Area2D reference
		message_label.text = ""  
		show()
		await scroll_text(message)  
		await get_tree().create_timer(0.2).timeout  
		hide()
		if character_ref:
			character_ref.set_physics_process(true)  # Unfreeze player
		if parent_area:
			parent_area.on_message_finished()  # Mark message as played

# Function to gradually display text
func scroll_text(message: String) -> void:
	for i in range(message.length()):
		message_label.text = message.substr(0, i + 1)
		await get_tree().create_timer(text_speed).timeout
