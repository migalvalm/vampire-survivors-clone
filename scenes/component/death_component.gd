extends Node2D

@export var health_component: HealthComponent
@export var sprite: Sprite2D

@onready var particles_generator: GPUParticles2D = $GPUParticles2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_random_audio_player: RandomStreamPlayer2DComponent = $HitRandomAudioPlayerComponent

func _ready():
	particles_generator.texture = sprite.texture
	health_component.died.connect(on_died)


func on_died():
	if owner == null || not owner is Node2D:
		return
	
	var entity: Node2D = owner
	
	var spawn_position = entity.global_position
	
	var entities = get_tree().get_first_node_in_group('entities_layer')
	get_parent().remove_child(self)
	entities.add_child(self)
	
	global_position = spawn_position
	animation_player.play('default')
	hit_random_audio_player.play_random()
	

