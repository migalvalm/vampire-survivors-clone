extends CharacterBody2D

@onready var visuals = $Visuals
@onready var velocity_component = $VelocityComponent

var is_moving: bool = false

func _process(_delta: float) -> void:
	if is_moving: velocity_component.accelerate_to_player()
	else: velocity_component.decelerate()
	
	velocity_component.move(self)
	
	var move_sign = sign(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)

func set_is_moving(moving: bool):
	is_moving = moving
