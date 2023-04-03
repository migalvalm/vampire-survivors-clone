extends Node2D

@onready var hitbox_component: Area2D = $HitboxComponent

func start_queue_free_timer():
	await get_tree().create_timer(5).timeout
	
	queue_free()
