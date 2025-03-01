extends Area2D

@export var message: String
@onready var speech_bubble = $SpeechBubble

var has_played: bool = false  # Track if the speech bubble has been triggered

func _on_body_entered(body):
	if body is CharacterBody2D and not has_played:
		print("Character entered! Showing message.")
		if speech_bubble:
			body.set_physics_process(false)  # Freeze player movement
			speech_bubble.show_message(message, body, self)  # Pass self as reference
		else:
			print("ERROR: SpeechBubble NOT found!")

func on_message_finished():
	has_played = true  # Set this only after the message is done
