extends Control

@onready var credits = $RichTextLabel3
@export var scroll_speed = 0.07
@onready var pause_menu = $"../paused"
@onready var paused = false

func _ready() -> void:
	credits.visible_ratio = 0
	
func _process(delta: float) -> void:
	if credits.visible_ratio < 1.0:  
		credits.visible_ratio += scroll_speed * delta
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
	get_tree().quit()
