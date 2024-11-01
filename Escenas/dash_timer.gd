extends Timer

signal time_update
var time = 100

func _ready() -> void:
	time_update.emit(time)

func _on_timeout() -> void:
	time -= 1
	time_update.emit(time)
