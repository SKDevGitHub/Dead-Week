extends Camera2D

func _ready():
	limit_left = -10  # Adjust based on your level size
	limit_right = 1000000  # Adjust based on your level width
	limit_top = 10
	limit_bottom = 5  # Adjust based on your level height
