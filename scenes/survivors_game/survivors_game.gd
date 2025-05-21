extends Node2D

# for creating mob waves
var wave_index := 0
var wave_configs = [
	{"count": 10, "type": "base"},
	{"count": 10, "type": "big"},
	{"count": 10, "type": "small"},
	{"count": 10, "type": "mixed"}
]


func _ready():
	# Behavioral Pattern: Observer: connect to player's health_depleted signal
	%Player.health_depleted.connect(_on_player_health_depleted)
	
	# Spawn the first wave immediately
	spawn_mob_wave()

	# Then start the timer to handle the next waves
	$SpawnTimer.start()
	

func spawn_mob_wave():
	if wave_index < wave_configs.size():
		var config = wave_configs[wave_index]
		wave_index += 1

		var wave_builder = preload("res://scenes/mob/wave_builder.gd").new()
		wave_builder\
			.set_mob_count(config["count"])\
			.set_mob_type(config["type"])\
			.set_spawn_area(self)\
			.build_wave()
	else:
		print("All waves complete.")


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true	#get scene tree, root of all game nodes


func _on_spawn_timer_timeout() -> void:
	spawn_mob_wave()
	$SpawnTimer.start()  # restart the timer to trigger the next wave
