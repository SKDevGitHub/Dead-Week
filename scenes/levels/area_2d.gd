extends Area2D

@export var message: String
@onready var speech_bubble = $SpeechBubble  # Assuming it's a child of the Area2D

func _on_body_entered(body):
	if body.name == "Player":  # Ensure it reacts only to the player
		speech_bubble.show_message("I don't want to go to class today!")
