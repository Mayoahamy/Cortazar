extends CharacterBody2D

@export var move_speed = 40
@export var chase_speed = 115

@onready var animated_sprite=$angry_animated

@onready var view1 = $view/view1
@onready var view2 = $view/view2
@onready var view3 = $view/view3
@onready var view4 = $view/view4
@onready var view_back = $view/view_back

var facing_right= true

func _ready() -> void:
	velocity.x = move_speed
	animated_sprite.play("walk")

func _physics_process(delta: float) -> void:
	move_and_slide()
	move_y(delta)
	move_x()
	flip()

func move_y(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

func move_x():
	if (not view1.get_collider())and(not view2.get_collider()):
		if facing_right:
			velocity.x = move_speed
		else:
			velocity.x = -move_speed
		animated_sprite.play("walk")
	else: 
		if facing_right:
			velocity.x = chase_speed
		else:
			velocity.x = -chase_speed
		animated_sprite.play("run")
	if (view3.get_collider()):
		if not facing_right:
			velocity.x = move_speed
		elif  facing_right:
			velocity.x = -move_speed
	if (view_back.get_collider())and(not view4.get_collider()):
		if facing_right:
			velocity.x = -move_speed
		else:
			velocity.x = move_speed

func flip():
		if (facing_right and velocity.x <0)or(not facing_right and velocity.x >0):
			scale.x*=-1
			facing_right= not facing_right

func collide_with_gilver():
	set_physics_process(false)
	animated_sprite.play("stun")
	await (animated_sprite.animation_finished)
	set_physics_process(true)
	
func die ():
	$angry_collision.queue_free()
	set_physics_process(false)
	velocity.y = 0
	velocity.x = 0
	animated_sprite.play("die")
	await (animated_sprite.animation_finished)
	queue_free()
