extends Area2D

var damage = 1 
func _ready():
	self.body_entered.connect(on_body_entered)

func on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()
