extends Node
class_name VialDropComponent

@export_range(0, 1) var drop_percent: float = .5
@export var health_component: Node
@export var vial_scene: PackedScene

func _ready():
	(health_component as HealthComponent).died.connect(on_died)

func on_died() -> void:
	var adjusted_drop_percent = drop_percent
	var experience_gain_upgrade_count = MetaProgression.get_upgrade_count('experience_gain')
	
	if experience_gain_upgrade_count > 0:
		adjusted_drop_percent += .1 * experience_gain_upgrade_count
	
	if randf() > adjusted_drop_percent: return
	if vial_scene == null: return
	if not owner is Node2D: return
	
	var spawn_position = (owner as Node2D).global_position
	var vial_instance = vial_scene.instantiate() as Node2D
	
	var entities_layer = get_tree().get_first_node_in_group('entities_layer')
	entities_layer.add_child(vial_instance)
	vial_instance.global_position = spawn_position
