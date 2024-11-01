extends CanvasLayer

func _on_timer_time_update(time) -> void:
	$Label.text = str(time)
