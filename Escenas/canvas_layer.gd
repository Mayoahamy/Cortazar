extends CanvasLayer

const heart = preload("res://Images/heart.png")
const heart_empty = preload("res://Images/heart_empty.png")

@export var gilver_life = 3

func life_update():
	if gilver_life >0:
		gilver_life -=1	
		if gilver_life >=1:
			$HBoxContainer/TextureRect1.texture = heart
		else: 
			$HBoxContainer/TextureRect1.texture = heart_empty
		if gilver_life >=2:
			$HBoxContainer/TextureRect2.texture = heart
		else:
			$HBoxContainer/TextureRect2.texture = heart_empty
		if gilver_life >=3:
			$HBoxContainer/TextureRect3.texture = heart
		else:
			$HBoxContainer/TextureRect3.texture = heart_empty
