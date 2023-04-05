extends Node

const BASE_RANGE = 100
const BASE_DAMAGE = 15

@export var anvil_ability_scene: PackedScene

@onready var timer: Timer = $Timer 

func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)

func on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group('player') as Node2D
	if player == null: return
	
	var direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player.global_position + (direction * randf_range(0, BASE_RANGE)) 
	
	var query_parameters = PhysicsRayQueryParameters2D.create(
			player.global_position,
			spawn_position,
			1 #Layer Mask Bit
		)
		
	var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)
	if !result.is_empty():
		spawn_position = result['position']
	
	var anvil_ability = anvil_ability_scene.instantiate()
	get_tree().get_first_node_in_group('foreground_layer').add_child(anvil_ability)
	anvil_ability.global_position = spawn_position
	anvil_ability.hitbox_component.damage = BASE_DAMAGE
