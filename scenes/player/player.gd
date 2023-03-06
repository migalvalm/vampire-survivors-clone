extends CharacterBody2D
class_name Player

const MAX_SPEED = 200

func _process(delta: float) -> void:
	var direction = get_movement_vector().normalized()
	
	velocity = direction * MAX_SPEED
	move_and_slide()

func get_movement_vector() -> Vector2:	
	var x_movement = Input.get_action_strength('move_right') - Input.get_action_strength('move_left')
	var y_movement = Input.get_action_strength('move_down') - Input.get_action_strength('move_up')
	
	return Vector2(x_movement, y_movement)
