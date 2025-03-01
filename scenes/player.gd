extends CharacterBody2D

var shooting = false
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var sprite := $AnimatedSprite2D
@onready var shoot_timer := $Timer
func _ready() -> void:
	change_anim("default")

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
	var bullet = bullet_path.instantiate()
	bullet.dir = 1
	bullet.pos = $spawner.global_position
	get_parent().add_child(bullet)
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump_button"):
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
				change_anim("run")
			if Input.is_action_pressed("left_button") and !Input.is_action_pressed("right_button"):
				sprite.flip_h = true
				change_anim("run")
			if !Input.is_action_pressed("right_button") and !Input.is_action_pressed("left_button"):
				change_anim("default")
			if Input.is_action_pressed("right_button") and Input.is_action_pressed("left_button"):
				change_anim("default")
		else:
			change_anim("jump")
			if Input.is_action_pressed("right_button") and !Input.is_action_pressed("left_button"):
				sprite.flip_h = false
			if Input.is_action_pressed("left_button") and !Input.is_action_pressed("right_button"):
				sprite.flip_h = true
	else:
		if is_on_floor():
			if Input.is_action_pressed("right_button") and !Input.is_action_pressed("left_button"):
				sprite.flip_h = false
				sprite.animation = "run_shoot"
			if Input.is_action_pressed("left_button") and !Input.is_action_pressed("right_button"):
				sprite.flip_h = true
				sprite.animation = "run_shoot"
			if !Input.is_action_pressed("right_button") and !Input.is_action_pressed("left_button"):
				change_anim("default_shoot")
			if Input.is_action_pressed("right_button") and Input.is_action_pressed("left_button"):
				change_anim("default_shoot")
		else:
			change_anim("jump_shoot")
			if Input.is_action_pressed("right_button") and !Input.is_action_pressed("left_button"):
				sprite.flip_h = false
			if Input.is_action_pressed("left_button") and !Input.is_action_pressed("right_button"):
				sprite.flip_h = true

	move_and_slide()

	
	
	
