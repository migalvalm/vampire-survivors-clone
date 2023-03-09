extends Area2D
class_name HurtboxComponent

@export var health_component: HealthComponent

func _ready() -> void:
	area_entered.connect(on_area_entered)
	
func on_area_entered(area: Area2D) -> void:
	if not area is HitboxComponent: return
	if health_component == null: return
	
	var hitbox_component = area as HitboxComponent
	health_component.damage(hitbox_component.damage)
	
