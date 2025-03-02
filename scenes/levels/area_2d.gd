extends Area2D

@export var message: String
@onready var speech_bubble = $SpeechBubble

var has_played: bool = false  # Track if the speech bubble has been triggered
var player_body: CharacterBody2D

func _on_body_entered(body):
	if body is CharacterBody2D and not has_played:
		player_body = body
		print("Character entered! Showing message.")
		if speech_bubble:
			player_body.in_cutscene = true  # Freeze player movement
			player_body.velocity = Vector2.ZERO
			speech_bubble.show_message(message, body, self)  # Pass self as reference
		else:
			print("ERROR: SpeechBubble NOT found!")

func on_message_finished():
	has_played = true  # Set this only after the message is done
	player_body.in_cutscene = false
