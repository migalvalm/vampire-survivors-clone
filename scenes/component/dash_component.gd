extends Node
class_name DashComponent

@export var dash_effect_scene: PackedScene
@export var	acceleration: float = 50
@export var speed: int = 250

var dashing = false
var can_dash = true

func _input(event: InputEvent):
	if event.is_action_pressed('dash') and allow_dash():
		dashing = true
		can_dash = false
		play_effect()
		await get_tree().create_timer(0.4).timeout
		dashing = false
		await get_tree().create_timer(0.2).timeout
		can_dash = true

func play_effect() -> void:
	var dash_effect: AnimatedSprite2D = dash_effect_scene.instantiate()
	
	var move_sign_x = sign(owner.get_movement_vector().x)
	var move_sign_y = sign(owner.get_movement_vector().y)

	apply_direction(Vector2(move_sign_x, move_sign_y), dash_effect)
	owner.add_child(dash_effect)
	dash_effect.play()
	owner.animation_player.play('dash')

func apply_direction(direction: Vector2, dash_effect: AnimatedSprite2D) -> void:
	print(direction)
	match direction:
		#Up
		Vector2(0, -1):
			print('up')
			dash_effect.scale.y = 1
		#Down
		Vector2(0, 1):
			print('down')
			dash_effect.scale.y = -1
		#Left
		Vector2(-1, 0):
			print('left')
			dash_effect.rotation = 90
			dash_effect.scale = Vector2(-1, 1)
		#Right
		Vector2(1, 0):
			print('right')
			dash_effect.rotation = -90
			dash_effect.scale = Vector2(1, 1)

func allow_dash() -> bool:
	return not dashing and can_dash
