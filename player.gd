extends CharacterBody2D

func _physics_process(delta: float) -> void:
	
	velocity.y += 1000.0 * delta
	
	velocity.x += 500.0 * delta
	velocity.x = min(velocity.x, 100.0)
	
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y = -350.0
	
	move_and_slide()
	pass
