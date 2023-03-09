extends CanvasLayer

@export var arena_time_manager: Node
@onready var label: Label = $%Label

func _process(delta) -> void:
	if arena_time_manager == null:
		return
	
	var time_elapsed = arena_time_manager.get_time_elapsed()

	label.text = format_seconds_to_string(time_elapsed)

func format_seconds_to_string(seconds: float) -> String:
	var minutes = floor(seconds / 60)
	var remaining_seconds = seconds - (minutes * 60)
	
	return str(minutes) + ":" + ("%02d" % floor(remaining_seconds))
