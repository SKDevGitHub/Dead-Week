extends CharacterBody2D


var pos:Vector2
var speed = 1000
var dir : float

func _ready():
	global_position=pos
func _physics_process(delta):

	velocity = Vector2(speed,0).rotated(dir)
	move_and_slide()
