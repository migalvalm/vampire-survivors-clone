extends CanvasLayer

@export var upgrades: Array[MetaUpgrade] = []
var meta_upgrade_car_scene = preload('res://scenes/ui/meta_upgrade_card.tscn')

@onready var grid_container = %GridContainer
@onready var back_button: Button = %BackButton

func _ready():
	back_button.pressed.connect(on_back_pressed)

	for upgrade in upgrades:
		var meta_upgrade_card_instance = meta_upgrade_car_scene.instantiate()
		grid_container.add_child(meta_upgrade_card_instance)
		meta_upgrade_card_instance.set_meta_upgrade(upgrade)

func on_back_pressed():
	ScreenTransition.transition_to_scene('res://scenes/ui/main_menu.tscn')
