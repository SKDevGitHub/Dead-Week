extends CharacterBody2D

@export var gravity: float = 980  # Gravity force (adjust as needed)
@export var speed: float = 200  # Horizontal movement speed
@export var jump_force: float = -400  # Jump strength

@export var min_x: float = 0
@export var max_x: float = 100000
@export var min_y: float = 0
@export var max_y: float = 600

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():  # Only apply gravity if not on the ground
		velocity.y += gravity * delta  

	# Player movement (left & right)
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	# Jumping
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force  # Apply jump force

	# Move and slide using built-in physics
	move_and_slide()

	# Clamp position to stay within boundaries
	position.x = clamp(position.x, min_x, max_x)
	position.y = clamp(position.y, min_y, max_y)
