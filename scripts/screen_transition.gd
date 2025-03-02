extends CanvasLayer

@onready var fade_rect = $ColorRect

# Fade out over a given duration
func fade_out(duration: float = 0.5) -> void:
	fade_rect.visible = true
	fade_rect.modulate.a = 0
	var tween = get_tree().create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, duration)
	await tween.finished

func fade_in(duration: float = 0.5) -> void:
	fade_rect.visible = true
	fade_rect.modulate.a = 1
	var tween = get_tree().create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0.0, duration)
	await tween.finished
	fade_rect.visible = false
