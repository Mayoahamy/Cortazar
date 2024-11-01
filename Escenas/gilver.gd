extends CharacterBody2D

@export var move_speed = 100
@export var jump_speed = -350 #-385 = 3 bloques
@export var jump_particles : PackedScene
@export var dash_particles_right : PackedScene
@export var dash_particles_left : PackedScene

@onready var animated_sprite = $gilver_animated
@onready var dash_bar = $CanvasLayer/dash_meter

var doublejump=true 
var dash=true
var gilver_die=false
var facing_right=true
var input_axis:Vector2
var direction := 0
var dir_dash :=0
var dash_speed = 330
var dash_duration = 0.2
var dash_cd = 800
var last_dash = Time.get_ticks_msec()

func _physics_process(delta: float) -> void:
	move_and_slide()
	move_y(delta)
	move_x()
	vector_x()
	input_dash()
	update_floor()
	update_animations()

func update_floor():
	if is_on_floor():
		doublejump=true
		dash=true

func update_animations():
	if(dashing()):
		animated_sprite.play("dash")
	else:
		if not is_on_floor():
			if velocity.y < 0:
				animated_sprite.play("jump")
			else:
				animated_sprite.play("fall")
			return
		if velocity.x:
			animated_sprite.play("walk")
		else:
			animated_sprite.play("idle")

func move_y(delta):
	if not (dashing()): 
		if Input.is_action_just_pressed("jump") :
			if is_on_floor():
				velocity.y=jump_speed
			elif doublejump:
				velocity.y=jump_speed
				doublejump=false
				jump_smoke()
	if not (dashing()):
		velocity += get_gravity() * delta
	else:
		velocity.y=0


func move_x():
	var speed = move_speed
	direction = Input.get_axis("left", "right")
	if(dashing()):
		if($dash_timer.time_left < 0.01):
			dash_bar.play("recharge")
		speed = dash_speed
		direction = dir_dash
		if not Input.is_action_just_pressed("left") and not Input.is_action_just_pressed("right"):
			if facing_right==true:
				dash_smoke_right()
				direction = 1
			else:
				dash_smoke_left()
				direction = -1
	if direction:
		velocity.x = direction * speed 
	else:
		velocity.x = move_toward(velocity.x, 0,move_speed)

func vector_x():
	if (facing_right and velocity.x <0)or(not facing_right and velocity.x >0):
		scale.x*=-1
		facing_right= not facing_right

func input_dash():
	if Input.is_action_just_pressed("dash"):
		if dash:
			start_dash()
			dash=false

func start_dash():
	var time_now = Time.get_ticks_msec()
	if (time_now - last_dash) < dash_cd:
		return
	dash_bar.play("default")
	dir_dash = direction
	last_dash = time_now
	$dash_timer.wait_time = dash_duration
	$dash_timer.start()
	
func dashing():
	return not $dash_timer.is_stopped()

func jump_smoke():
	var jump_instantiate = jump_particles.instantiate()
	add_sibling(jump_instantiate)
	jump_instantiate.global_position = global_position + Vector2(0,5)

func dash_smoke_right():
	var dash_instantiate = dash_particles_right.instantiate()
	add_sibling(dash_instantiate)
	dash_instantiate.global_position = global_position + Vector2(-3,1.5)

func dash_smoke_left():
	var dash_instantiate = dash_particles_left.instantiate()
	add_sibling(dash_instantiate)
	dash_instantiate.global_position = global_position + Vector2(3,1.5)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.collide_with_gilver()
		get_tree().call_group("game_controller", "hurt")
		set_physics_process(false)
		animated_sprite.play("hurt")
		await (animated_sprite.animation_finished)
		if not gilver_die:
			set_physics_process(true)
			

func die():
	await (animated_sprite.animation_finished)
	gilver_die=true
	set_physics_process(false)
	$Gilver_collision_shape.queue_free()
	$Area2D.queue_free()
