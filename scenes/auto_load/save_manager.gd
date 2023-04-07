extends Node

const SAVE_FILE_PATH = 'user://game.save'

var save_data: Dictionary = {
	'player': {
		'meta_upgrade_currency': 0,
		'meta_upgrades': {},
		'current_class': 'no_class',
		'classes': {},
	}
}

func _ready():
	load_save_file()

func load_save_file():
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		return
	
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	save_data = file.get_var()

func save() -> void:
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_var(save_data)
