extends Node2D

# === Wave Progression Configuration ===
var wave_index := 0
var wave_configs = [
	{"count": 10, "type": "base"},
	{"count": 10, "type": "big"},
	{"count": 10, "type": "small"},
	{"count": 10, "type": "mixed"}
]


func _ready():
	# === Observer Pattern: Listen for game over signal from Player ===
	%Player.health_depleted.connect(_on_player_health_depleted)
	
	# Spawn the first wave immediately
	spawn_mob_wave()

	# Start timer to spawn next wave
	$SpawnTimer.start()
	

# === Build and spawn mob wave based on current wave config ===
func spawn_mob_wave():
	if wave_index < wave_configs.size():
		var config = wave_configs[wave_index]
		wave_index += 1

		var wave_builder = preload("res://scenes/mob/MobCreation/wave_builder.gd").new()
		
		# === Fluent Interface + Builder Pattern ===
		# Chain configuration steps to create the wave
		(
			wave_builder
			.set_mob_count(config["count"])
			.set_mob_type(config["type"])
			.set_spawn_area(self)
			.build_wave()
		)

	else:
		print("All waves complete.")


# Triggered when the player dies 
func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true	 # pause the entire game


# Called when the wave timer times out 
func _on_spawn_timer_timeout() -> void:
	spawn_mob_wave()
	$SpawnTimer.start()  # restart the timer


# Upgrades using key inputs
func _unhandled_input(event):
	if event.is_action_pressed("upgrade_fire"):
		var player = get_node("Player")
		PowerUpManager.apply_upgrade(player, "IncreaseFireRate")

	if event.is_action_pressed("upgrade_bullet_size"):
		var player = get_node("Player")
		PowerUpManager.apply_upgrade(player, "IncreaseBulletSize")
