extends CharacterBody2D

var can_talk = false
var player_body = null

func _ready():
	pass

func _process(_delta):
	if can_talk and Input.is_action_just_pressed("ui_accept"):
		talk()

func talk():
	var dialog_box = get_tree().get_current_scene().get_node("UI/DialogBox")
	var label = dialog_box.get_node("Label")
	label.text = "Hello, world!"
	dialog_box.visible = true


func face_player():
	if player_body == null:
		return
	var dir = player_body.global_position - global_position
	var anim := ""
	
	if abs(dir.x) > abs(dir.y):
		anim = "idle_right" if dir.x > 0 else "idle_left"
	else:
		anim = "idle_down" if dir.y > 0 else "idle_up"
	
	$AnimatedSprite2D.play(anim)

func _on_area_2d_body_entered(body: Node) -> void:
	if body.name == "Player":
		can_talk = true
		player_body = body
		print("Player entered the range")
		face_player()

func _on_area_2d_body_exited(body: Node) -> void:
	if body.name == "Player":
		can_talk = false
		player_body = null
		print("Player exited the range")
