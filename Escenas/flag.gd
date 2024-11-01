extends AnimatedSprite2D

func _ready() -> void:
	$".".play("default")

func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("gilver"): 
		get_tree().call_group("game_controller","game_win")
