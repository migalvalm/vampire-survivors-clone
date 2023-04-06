extends Node2D

@onready var dash_effect: AnimatedSprite2D = $DashEffect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dash_effect.animation_finished.connect(on_animation_finished)

func play() -> void:
	dash_effect.play()

func on_animation_finished() -> void:
	queue_free()
