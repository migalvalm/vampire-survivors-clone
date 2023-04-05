extends CharacterBody2D

@onready var visuals = $Visuals
@onready var velocity_component = $VelocityComponent
@onready var hurtbox_component = $HurtboxComponent
@onready var hit_random_audio_player: RandomStreamPlayer2DComponent = $HitRandomAudioPlayerComponent

func _ready():
	hurtbox_component.hit.connect(on_hit)

func _process(_delta: float) -> void:
	velocity_component.accelerate_to_player()
	velocity_component.move(self)
	
	var move_sign = sign(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(-move_sign, 1)

func on_hit():
	hit_random_audio_player.play_random()
