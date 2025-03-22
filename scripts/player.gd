extends AnimatedSprite2D

# Movement speed (pixels per second)
var speed = 200

# Current input direction
var dir = Vector2.ZERO

# Last movement direction (used for idle animation)
var last_dir = "down"

func _physics_process(delta):
	dir = Vector2.ZERO

	# Input detection (Arrow keys and WASD)
	if Input.is_action_pressed("ui_right"):
		dir.x += 1
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1
	if Input.is_action_pressed("ui_down"):
		dir.y += 1
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1

	# Movement logic
	if dir != Vector2.ZERO:
		dir = dir.normalized()
		position += dir * speed * delta
		
		# Direction-based animation and last_dir update
		if abs(dir.x) > abs(dir.y):
			if dir.x > 0:
				play("walk_right")
				last_dir = "right"
			else:
				play("walk_left")
				last_dir = "left"
		else:
			if dir.y > 0:
				play("walk_down")
				last_dir = "down"
			else:
				play("walk_up")
				last_dir = "up"
	else:
		# No movement → Play idle animation based on last_dir
		match last_dir:
			"up":
				play("idle_up")
			"down":
				play("idle_down")
			"left":
				play("idle_left")
			"right":
				play("idle_right")
