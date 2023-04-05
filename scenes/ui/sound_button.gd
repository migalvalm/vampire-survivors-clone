extends Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(on_pressed)

func on_pressed() -> void:
	$RandomStreamPlayerComponent.play_random()
