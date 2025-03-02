extends Node2D

@export_file("*.tscn") var next_scene: String = "res://scenes/levels/exam_level.tscn"
@onready var label: Label = $Label
@onready var canvas_layer: CanvasLayer = $CanvasLayer
var can_enter = false
var loading_scene = false

func _ready():
	label.visible = false
	can_enter = false

func _on_trigga_body_entered(body: Node2D) -> void:
	label.visible = true
	can_enter = true

func _on_trigga_body_exited(body: Node2D) -> void:
	label.visible = false
	can_enter = true
	
func _process(delta) -> void:
	if Input.is_action_pressed("go_through_door"):
		if can_enter:
			change_scene(next_scene)

func change_scene(path: String):
	await canvas_layer.fade_out()
	ResourceLoader.load_threaded_request(path)
	while ResourceLoader.load_threaded_get_status(path) == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		await get_tree().process_frame
	loading_scene = ResourceLoader.load_threaded_get(path)
	if loading_scene:
		get_tree().change_scene_to_packed(loading_scene)
	else:
		print("Failed to load scene:", path)
