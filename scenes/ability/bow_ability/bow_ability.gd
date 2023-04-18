extends Node2D
class_name BowAbility

@onready var spawn_position = $Position
var bullet_scene: PackedScene = preload('res://scenes/game_object/bullet/bullet.tscn')

func shoot(damage: int) -> void:
	var bullet_instance: Bullet = bullet_scene.instantiate()
	bullet_instance.global_position = spawn_position.position
	
	bullet_instance.hitbox_component.damage = damage
	
