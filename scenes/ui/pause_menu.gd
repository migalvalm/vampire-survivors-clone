extends CanvasLayer

@onready var panel_container: PanelContainer = %PanelContainer
@onready var resume_button: Button = %ResumeButton
@onready var options_button: Button = %OptionsButton
@onready var quit_button: Button = %QuitButton

var options_menu_scene = preload("res://scenes/ui/options_menu.tscn")
var is_closing: bool

func _ready() -> void:
	get_tree().paused = true
	panel_container.pivot_offset = panel_container.size / 2
	
	resume_button.pressed.connect(on_resume_pressed)
	options_button.pressed.connect(on_options_pressed)
	quit_button.pressed.connect(on_quit_pressed)
	
	open()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('pause'):
		close()
		get_tree().root.set_input_as_handled()

func open() -> void:
	$AnimationPlayer.play('default')
	
	var tween = create_tween()
	
	tween.tween_property(
		panel_container, 'scale', Vector2.ZERO, 0
	)
	tween.tween_property(
		panel_container, 'scale', Vector2.ONE, .3
	).set_ease(
		Tween.EASE_OUT
	).set_trans(
		Tween.TRANS_BACK
	)

func close() -> void:
	if is_closing: return
	
	is_closing = true
	$AnimationPlayer.play_backwards('default')
	
	var tween = create_tween()
	tween.tween_property(
		panel_container, 'scale', Vector2.ONE, 0
	)
	tween.tween_property(
		panel_container, 'scale', Vector2.ZERO, .3
	).set_ease(
		Tween.EASE_IN
	).set_trans(
		Tween.TRANS_BACK
	)
	
	await tween.finished
	
	get_tree().paused = false
	queue_free()

func on_resume_pressed() -> void:
	close()

func on_options_pressed() -> void:
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	var options_menu_instance = options_menu_scene.instantiate()
	add_child(options_menu_instance)
	
	options_menu_instance.back_pressed.connect(on_options_back_pressed.bind(options_menu_instance))

func on_quit_pressed() -> void:
	ScreenTransition.transition_to_scene('res://scenes/ui/main_menu.tscn', true)

func on_options_back_pressed(options_menu: Node):
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	options_menu.queue_free()
