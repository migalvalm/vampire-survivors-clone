extends Node
class_name DashComponent

@export var dash_effect_scene: PackedScene
@export var	acceleration: float = 50
@export var speed: int = 250

var dashing = false
var can_dash = true

func _input(event: InputEvent):
	var entity: Player = owner
	if event.is_action_pressed('dash') and allow_dash():
		dashing = true
		can_dash = false
		
		play_effect()
		entity.animation_player.play('dash')
		
		await get_tree().create_timer(0.4).timeout
		dashing = false
		await get_tree().create_timer(0.2).timeout
		can_dash = true

func play_effect() -> void:
	var dash_effect: Node2D = dash_effect_scene.instantiate()
	
	var move_sign_x = sign(owner.get_movement_vector().x)
	var move_sign_y = sign(owner.get_movement_vector().y)

	apply_direction(Vector2(move_sign_x, move_sign_y), dash_effect)
	owner.add_child(dash_effect)
	dash_effect.play()


func apply_direction(direction: Vector2, dash_effect: Node2D) -> void:
	if direction.y == 1:
		dash_effect.rotate(deg_to_rad(90))
		return
	
	elif direction.y == -1:
		dash_effect.rotate(deg_to_rad(-90))
		return
	
	if direction.x == -1:
		dash_effect.rotate(deg_to_rad(-180))
		return

func allow_dash() -> bool:
	return not dashing and can_dash
