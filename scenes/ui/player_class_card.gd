extends PanelContainer

@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var select_button: Button = %SelectButton
@onready var progress_label: Label = %ProgressLabel
@onready var count_label: Label = %CountLabel
@onready var texture: TextureRect = %Texture

var player_class: PlayerClass

func _ready() -> void:
	select_button.pressed.connect(on_select_pressed)

func play_in(delay: float = 0) -> void:
	modulate = Color.TRANSPARENT
	await get_tree().create_timer(delay).timeout
	modulate = Color.WHITE
	$AnimationPlayer.play('in')

func update_progress():
	pass

func set_class_card(class_id):
	self.player_class = load(ClassManager.PLAYER_CLASSES[class_id])
	name_label.text = player_class.title
	texture.texture = load(player_class.texture_path)
	description_label.text = player_class.description

func on_select_pressed():
	ClassManager.set_class(player_class.id)
