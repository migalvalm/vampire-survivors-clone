extends CharacterBody2D
class_name Player

@export var arena_time_manager: ArenaTimeManager
@export var hurtbox_area: Area2D
@export var town_mode: bool = false

@onready var player_texture: PlayerTexture = %PlayerTexture
@onready var damage_interval_timer = $DamageIntervalTimer as Timer
@onready var health_component = $HealthComponent as HealthComponent
@onready var health_bar = $HealthBar
@onready var abilities = $Abilities
@onready var animation_player = $AnimationPlayer
@onready var visuals = $Visuals
@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var dash_component: DashComponent = $DashComponent 

var number_colliding_bodies: int = 0
var base_speed = 0

func _ready() -> void:
	player_texture.set_player_skin(ClassManager.current_class.texture_path)
	
	health_bar.visible = !town_mode
	if not town_mode:
		arena_time_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)
		
	
	base_speed = velocity_component.max_speed
	
	hurtbox_area.body_entered.connect(on_body_entered)
	hurtbox_area.body_exited.connect(on_body_exited)
	damage_interval_timer.timeout.connect(on_damage_interval_timer_timeout)
	health_component.health_decreased.connect(on_health_decreased)
	health_component.health_changed.connect(on_health_changed)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	health_bar.set_value(health_component.get_health_percent())
	
func _process(delta: float) -> void:
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()

	velocity_component.accelerate_in_direction(
		Vector2(sign(movement_vector.x), (movement_vector.y)).normalized(), dash_component.speed, dash_component.acceleration
	) if dash_component.dashing else velocity_component.accelerate_in_direction(direction) 
	
	velocity_component.move(self)
	play_animation(movement_vector)

func play_animation(direction: Vector2) -> void:
	if not dash_component.dashing:
		if (direction.x != 0 || direction.y != 0):
			animation_player.play('walk')
		else: 
			animation_player.play('idle')
	
	var move_sign = sign(direction.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)

func get_movement_vector() -> Vector2:
	var x_movement = Input.get_action_strength('move_right') - Input.get_action_strength('move_left')
	var y_movement = Input.get_action_strength('move_down') - Input.get_action_strength('move_up')
	
	return Vector2(x_movement, y_movement)

func check_deal_damage() -> void:
	if number_colliding_bodies == 0 || !damage_interval_timer.is_stopped(): return
	
	health_component.damage(1)
	damage_interval_timer.start()

func update_health_display():
	health_bar.value = health_component.get_health_percent()
	
func on_body_entered(body: Node2D) -> void:
	if dash_component.dashing:
		return

	number_colliding_bodies += 1
	check_deal_damage()

func on_body_exited(body: Node2D) -> void:
	if number_colliding_bodies == 0: return
	number_colliding_bodies -= 1

func on_damage_interval_timer_timeout() -> void:
	check_deal_damage()

func on_health_decreased() -> void:
	GameEvents.emit_player_damaged()
	update_health_display()
	$HitRandomStreamPlayer.play_random()

func on_health_changed() -> void:
	update_health_display()

func on_ability_upgrade_added(ability_upgrade: AbilityUpgrade, current_upgrades: Dictionary) -> void:
	if ability_upgrade is Ability:
		var ability = ability_upgrade as Ability
		abilities.add_child(ability.ability_controller_scene.instantiate())
	elif ability_upgrade.id == 'player_speed':
		velocity_component.max_speed = base_speed + (base_speed * current_upgrades["player_speed"]["quantity"] * .1)

func on_arena_difficulty_increased(difficulty: int):
	var health_regeneration_quantity = MetaProgression.get_upgrade_count('health_regeneration')
	if health_regeneration_quantity > 0:
		var is_thirty_second_interval = (difficulty % 6) == 0
		if is_thirty_second_interval:
			health_component.heal(health_regeneration_quantity)
