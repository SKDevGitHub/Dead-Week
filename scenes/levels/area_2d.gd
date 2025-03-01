extends Area2D

@export var message: String
@onready var speech_bubble = $SpeechBubble

func _on_body_entered(body):
	if body is CharacterBody2D:
		print("Character entered! Trying to get SpeechBubble.")

		if speech_bubble:
			print("SpeechBubble found! Showing message.")
			speech_bubble.show_message(message)
		else:
			print("ERROR: SpeechBubble NOT found!")
