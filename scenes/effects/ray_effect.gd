extends Sprite2D

@export var override_color: bool = false
@export var is_owner: bool = true

var color: Color 

func _ready():
	if override_color:
		return
	
	if not is_owner and not owner.owner == null:
		color = owner.owner.modulate
	else:
		color = owner.modulate
		
	material.set_shader_parameter('color', color)
