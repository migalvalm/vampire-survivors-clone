extends Node2D
class_name Door

@export var to_scene: String = 'res://scenes/main/main.tscn'
@onready var area: Area2D = $Area

func _ready() -> void:
	area.body_entered.connect(on_body_entered)

#TODO Add PopupComponent Integration Here
func on_body_entered(body: Node2D) -> void:
	if body is Player:
		ScreenTransition.transition_to_scene(to_scene)
