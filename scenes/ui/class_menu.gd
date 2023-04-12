extends CanvasLayer

var player_class_card_scene = preload('res://scenes/ui/player_class_card.tscn')

signal back_pressed

@onready var grid_container = %GridContainer
@onready var back_button: Button = %BackButton

func _ready():
	back_button.pressed.connect(on_back_pressed)
	for player_class_id in ClassManager.PLAYER_CLASSES.keys():
		var player_class_card_instance = player_class_card_scene.instantiate()
		grid_container.add_child(player_class_card_instance)
		player_class_card_instance.set_class_card(player_class_id)

func on_back_pressed():
	ScreenTransition.transition_to_scene('res://scenes/ui/main_menu.tscn')
	await ScreenTransition.transitioned_halfway
	back_pressed.emit()
