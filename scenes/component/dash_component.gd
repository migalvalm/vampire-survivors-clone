extends Node

@export var	acceleration: float = 50
@export var speed: int = 2000

var dashing = false
var can_dash = true

func _input(event: InputEvent):
	if event.is_action_pressed('dash') and allow_dash():
		dashing = true
		can_dash = false
		await get_tree().create_timer(0.2).timeout
		dashing = false
		await get_tree().create_timer(0.2).timeout
		can_dash = true

func dash_tween() -> void:
	var tween = create_tween()

func allow_dash() -> bool:
	return not dashing and can_dash
