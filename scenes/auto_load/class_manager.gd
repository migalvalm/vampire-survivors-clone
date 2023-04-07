extends Node

const PLAYER_CLASSES = {
	'default': 'res://resources/player_classes/default.tres',
	'knight': 'res://resources/player_classes/knight.tres',
	'archer': 'res://resources/player_classes/archer.tres',
	'skeleton': 'res://resources/player_classes/skeleton.tres'
}

var current_class: PlayerClass = preload(PLAYER_CLASSES.default)

func set_class(class_id: String) -> void:
	current_class = load(PLAYER_CLASSES[class_id])
