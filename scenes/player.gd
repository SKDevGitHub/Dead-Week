extends CharacterBody2D

var health 
var shooting = false
const SPEED = 200.0
const JUMP_VELOCITY = -320.0


var max_health: int = 3
@onready var sprite := $AnimatedSprite2D
@onready var shoot_timer := $Timer
@onready var spawner := $spawnerparent/spawner
@onready var spawnerparent := $spawnerparent

@export var dead = false

func _ready() -> void:
	change_anim("default")
	health = max_health
var i: int = 0

var bullet_path: PackedScene = preload("res://scenes/ee_bullet.tscn")

func change_anim(anim: String) -> void:
	if sprite.animation != anim:
		var frame = sprite.frame
		var frame_progress = sprite.frame_progress
		sprite.play(anim)
		sprite.frame = frame
		sprite.frame_progress = frame_progress
		i+=1


func shoot() -> void:
	if shoot_timer.is_stopped():
		var bullet = bullet_path.instantiate()
		get_parent().add_child(bullet)
		bullet.global_position = spawner.global_position
		var direction:Vector2 = Vector2.RIGHT
		if sprite.flip_h:
			direction = Vector2.LEFT
		var bullet_area = bullet.get_node("Area2D")	
		bullet_area.direction = direction
		
		
		

	


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("shoot_button"):
		shoot()
	# Handle jump.
	if Input.is_action_just_pressed("jump_button") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left_button", "right_button")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if shoot_timer.is_stopped():
		if Input.is_action_just_pressed("shoot_button"):
			shoot_timer.start()
		if is_on_floor():
			if Input.is_action_pressed("right_button") and !Input.is_action_pressed("left_button"):
				sprite.flip_h = false
				spawnerparent.scale.x = 1
				change_anim("run")
			if Input.is_action_pressed("left_button") and !Input.is_action_pressed("right_button"):
				sprite.flip_h = true
				spawnerparent.scale.x = -1
				change_anim("run")
			if !Input.is_action_pressed("right_button") and !Input.is_action_pressed("left_button"):
				change_anim("default")
			if Input.is_action_pressed("right_button") and Input.is_action_pressed("left_button"):
				change_anim("default")
		else:
			change_anim("jump")
			if Input.is_action_pressed("right_button") and !Input.is_action_pressed("left_button"):
				sprite.flip_h = false
				spawnerparent.scale.x = 1
			if Input.is_action_pressed("left_button") and !Input.is_action_pressed("right_button"):
				sprite.flip_h = true
				spawnerparent.scale.x = -1
	else:
		if is_on_floor():
			if Input.is_action_pressed("right_button") and !Input.is_action_pressed("left_button"):
				sprite.flip_h = false
				spawnerparent.scale.x = 1
				sprite.animation = "run_shoot"
			if Input.is_action_pressed("left_button") and !Input.is_action_pressed("right_button"):
				sprite.flip_h = true
				spawnerparent.scale.x = -1
				sprite.animation = "run_shoot"
			if !Input.is_action_pressed("right_button") and !Input.is_action_pressed("left_button"):
				change_anim("default_shoot")
			if Input.is_action_pressed("right_button") and Input.is_action_pressed("left_button"):
				change_anim("default_shoot")
		else:
			change_anim("jump_shoot")
			if Input.is_action_pressed("right_button") and !Input.is_action_pressed("left_button"):
				sprite.flip_h = false
				spawnerparent.scale.x = 1
			if Input.is_action_pressed("left_button") and !Input.is_action_pressed("right_button"):
				sprite.flip_h = true
				spawnerparent.scale.x = -1
	move_and_slide()

	
func take_damage(damage):
	health -= damage
	
	if health <= 0:
		dead = true
		
