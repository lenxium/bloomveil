extends CharacterBody2D

@export var speed = 200

var dir = Vector2.ZERO
var last_dir = "down"

@onready var anim_sprite = $AnimatedSprite2D

func _physics_process(_delta):
	dir = Vector2.ZERO

	# 键盘输入检测（Arrow Keys / WASD）
	if Input.is_action_pressed("ui_right"):
		dir.x += 1
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1
	if Input.is_action_pressed("ui_down"):
		dir.y += 1
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1

	if dir != Vector2.ZERO:
		dir = dir.normalized()
		velocity = dir * speed
		move_and_slide()

		# 动画切换
		if abs(dir.x) > abs(dir.y):
			if dir.x > 0:
				anim_sprite.play("walk_right")
				last_dir = "right"
			else:
				anim_sprite.play("walk_left")
				last_dir = "left"
		else:
			if dir.y > 0:
				anim_sprite.play("walk_down")
				last_dir = "down"
			else:
				anim_sprite.play("walk_up")
				last_dir = "up"
	else:
		velocity = Vector2.ZERO
		move_and_slide()

		# idle 动画切换
		match last_dir:
			"up":
				anim_sprite.play("idle_up")
			"down":
				anim_sprite.play("idle_down")
			"left":
				anim_sprite.play("idle_left")
			"right":
				anim_sprite.play("idle_right")
