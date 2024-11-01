extends Node2D

@export var gilver_life = 3

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass

func hurt():
	if gilver_life >0:
		gilver_life -= 1
		get_tree().call_group("interface","life_update")
		if gilver_life <=0:
			game_over()

func game_over():
	print("perdiste")
	get_tree().call_group("timer", "time_stop")
	get_tree().call_group("gilver","die")

func game_win():
	print("ganaste")
	get_tree().call_group("timer", "time_stop")
	get_tree().call_group("enemy","die")
