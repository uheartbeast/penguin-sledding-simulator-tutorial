extends CharacterBody2D

@export var acceleration: = 150
@export var max_speed: = 290
@export var friction: = 200
@export var air_friction: = 60
@export var up_gravity: = 250
@export var down_gravity: = 500
@export var jump_force: = 180
@export var unjump_force: = 25
@export var landing_acceleration: = 2250.0

var target_tilt: = 0.0

@onready var anchor: Node2D = $Anchor
@onready var sprite_2d: Sprite2D = $Anchor/Sprite2D

func _physics_process(delta: float) -> void:
	if is_on_floor():
		target_tilt = 0
		if velocity.x <= max_speed:
			velocity.x = move_toward(velocity.x, max_speed, acceleration * delta)
		else:
			velocity.x = move_toward(velocity.x, max_speed, friction * delta)
		
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -jump_force
	else:
		target_tilt = clamp(velocity.y / 4, -30, 30)
		
		velocity.x = move_toward(velocity.x, 0, air_friction * delta)
		
		if Input.is_action_just_released("ui_up"):
			velocity.y = unjump_force
		if velocity.y > 0:
			velocity.y += down_gravity * delta
		else:
			velocity.y += up_gravity * delta
	
	var previous_velocity = velocity
	
	move_and_slide()
	
	if velocity.y == 0 and previous_velocity.y > 5:
		anchor.scale = Vector2(1.5, 0.8)
		velocity.x += landing_acceleration * delta
	
	sprite_2d.rotation_degrees = lerp(sprite_2d.rotation_degrees, target_tilt, 0.2)
	anchor.scale = anchor.scale.lerp(Vector2.ONE, 0.05)
