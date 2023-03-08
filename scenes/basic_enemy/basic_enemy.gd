extends CharacterBody2D

const MAX_SPEED = 75

func _ready() -> void:
	$Hitbox.area_entered.connect(on_area_entered)

func _process(_delta: float) -> void:
	var direction = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()

func get_direction_to_player() -> Vector2:
	var player_node = get_tree().get_first_node_in_group('player')
	
	if player_node != null:
		return (player_node.global_position - global_position).normalized()
	
	return Vector2.ZERO
	
func on_area_entered(_area: Area2D) -> void:
	queue_free()
	
