extends Node2D
@onready var pause_menu = $Pause

var paused = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_Menu()

func pause_Menu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else: 
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused


func _on_resume_pressed() -> void:
	Engine.time_scale = 1
	pause_menu.hide()
	paused = !paused

func _on_keep_playing_pressed() -> void:
	pause_menu.hide()
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	Engine.time_scale = 1 
	paused = !paused

func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/dorm.tscn")
	Engine.time_scale = 1
