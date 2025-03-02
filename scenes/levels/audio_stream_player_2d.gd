extends AudioStreamPlayer2D
@onready var player = $"../Player/player"
var has_played_pwned = false
var pwned_track = preload("res://assets/music/2019-01-15_-_You_Just_Got_Pwned_-_David_Fesliyan.mp3")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play() # Replace with function body.

func _process(delta: float) -> void:
	if player and player.dead and !has_played_pwned:  # Ensure 'player' exists before checking 'dead'
		_play_pwned_track()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _play_pwned_track():
	if pwned_track:
		stream = pwned_track  # Set the new track
		play()  # Play the new track
		has_played_pwned = true
