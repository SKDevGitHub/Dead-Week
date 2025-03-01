extends StaticBody2D
@onready var area = $"."
@export var damage = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.body_entered.connect(on_body_entered)	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_body_entered(body):
	if body.has_method("take_damage"):
			body.take_damage(damage)
