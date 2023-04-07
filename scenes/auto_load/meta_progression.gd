extends Node

func _ready():
	GameEvents.experience_vial_collected.connect(on_experience_collected)

func add_meta_upgrade(upgrade: MetaUpgrade):
	if not SaveManager.save_data['player']['meta_upgrades'].has(upgrade.id):
		SaveManager.save_data['player']['meta_upgrades'][upgrade.id] = {
			'quantity': 0
		}
	
	SaveManager.save_data['player']['meta_upgrades'][upgrade.id]['quantity'] += 1
	SaveManager.save()

func get_upgrade_count(upgrade_id: String) -> int:
	if not SaveManager.save_data['player']['meta_upgrades'].has(upgrade_id): return 0
	return SaveManager.save_data['player']['meta_upgrades'][upgrade_id]['quantity']

func on_experience_collected(number: float) -> void:
	SaveManager.save_data['player']['meta_upgrade_currency'] += number
