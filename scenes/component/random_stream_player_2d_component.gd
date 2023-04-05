extends AudioStreamPlayer2D
class_name RandomStreamPlayer2DComponent

@export var streams: Array[AudioStream]
@export var randomize_pitch = true
@export var min_pitch: float = .9
@export var max_pitch: float = 1.1

func _ready() -> void:
	pass

func play_random() -> void:
	if streams == null || streams.size() == 0: return
	if randomize_pitch: pitch_scale = randf_range(min_pitch, max_pitch)
	else: pitch_scale = 1
	
	stream = streams.pick_random()
	play()
