extends Area2D

@export var message: String
@onready var speech_bubble = get_tree().current_scene.find_child("SpeechBubble", true, false)

func _on_body_entered(body):
	if body is CharacterBody2D:
		print("Character entered! Trying to get SpeechBubble.")

		if speech_bubble:
			print("SpeechBubble found! Showing message.")
			speech_bubble.show_message("I don't want to go to class today!")
		else:
			print("ERROR: SpeechBubble NOT found!")
