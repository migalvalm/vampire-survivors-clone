extends CanvasLayer

func _ready() -> void:
	GameEvents.player_damaged.connect(on_player_damaged)
	
func on_player_damaged() -> void:
	$AnimationPlayer.play('hit')
