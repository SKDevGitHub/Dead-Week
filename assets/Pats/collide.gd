extends Area2D
@onready var area = $"."
@export var damage = 1
@onready var bottle = $".."
@onready var parent = $"../pats"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.body_entered.connect(on_body_entered)	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_body_entered(body):
	print(body.get_parent().name)
	if body.has_method("take_damage") and !(body.get_parent().name == "Pats"):
		body.take_damage(damage)
		bottle.queue_free()
