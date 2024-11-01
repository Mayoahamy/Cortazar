extends Timer

signal time_update
@export var time = 60
var time_flow = true

func _ready() -> void:
	time_update.emit(time)

func time_stop():
	time_flow = false

func _on_timeout() -> void:
	if time_flow:
		if time > 0:
			time -= 1
			time_update.emit(time)
		else:
			get_tree().call_group("game_controller", "game_over")
