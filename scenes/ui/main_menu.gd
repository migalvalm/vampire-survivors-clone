extends CanvasLayer

var options_scene = preload('res://scenes/ui/options_menu.tscn')
var meta_menu_scene = preload('res://scenes/ui/meta_menu.tscn')

func _ready() -> void:
	%PlayButton.pressed.connect(on_play_pressed)
	%UpgradesButton.pressed.connect(on_upgrade_pressed)
	%OptionsButton.pressed.connect(on_options_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)

func on_play_pressed() -> void:
	ScreenTransition.transition_to_scene('res://scenes/main/main.tscn')

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
	get_tree().quit()

func on_options_closed(options_instance: Node) -> void:
	options_instance.queue_free()
