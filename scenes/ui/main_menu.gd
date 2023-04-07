extends CanvasLayer

var options_scene = preload('res://scenes/ui/options_menu.tscn')
var class_menu_scene = preload('res://scenes/ui/class_menu.tscn')
var meta_menu_scene = preload('res://scenes/ui/meta_menu.tscn')

@onready var play_button: Button = %PlayButton
@onready var class_button: Button = %ClassButton
@onready var upgrades_button: Button = %UpgradesButton
@onready var options_button: Button = %OptionsButton
@onready var quit_button: Button = %QuitButton

func _ready() -> void:
	play_button.pressed.connect(on_play_pressed)
	class_button.pressed.connect(on_class_pressed)
	upgrades_button.pressed.connect(on_upgrade_pressed)
	options_button.pressed.connect(on_options_pressed)
	quit_button.pressed.connect(on_quit_pressed)

func on_play_pressed() -> void:
	ScreenTransition.transition_to_scene('res://scenes/main/main.tscn', true)

func on_class_pressed() -> void:
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	var class_menu_instance = class_menu_scene.instantiate()
	add_child(class_menu_instance)

func on_upgrade_pressed() -> void:
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	var meta_menu_instance = meta_menu_scene.instantiate()
	add_child(meta_menu_instance)

func on_options_pressed() -> void:
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	var options_instance = options_scene.instantiate()
	add_child(options_instance)
	options_instance.back_pressed.connect(on_options_closed.bind(options_instance))

func on_quit_pressed() -> void:
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	SaveManager.save()
	get_tree().quit()


func on_options_closed(options_instance: Node) -> void:
	options_instance.queue_free()
