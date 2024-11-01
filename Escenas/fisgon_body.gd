extends CharacterBody2D

@onready var animated_sprite = $"fisgón_animated"

var speed = 10

func _ready() -> void:
	animated_sprite.play("fly")

func collide_with_gilver():
	die()

func die ():
	$fisgón_collision.queue_free()
	set_physics_process(false)
	animated_sprite.play("die")
	get_parent().speed = 0;
	await (animated_sprite.animation_finished)
	queue_free()
