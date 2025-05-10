extends Node2D

# for creating mobs
var mob_factory = preload("res://scenes/mob/mob_factory.gd").new()

func _ready():
	# Behavioral Pattern: Observer: connect to player's health_depleted signal
	%Player.health_depleted.connect(_on_player_health_depleted)

func spawn_mob():
	var new_mob = mob_factory.create_mob()
	%PathFollow2D.progress_ratio = randf()	# random num between 0 and 1
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)


func _on_timer_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true	#get scene tree, root of all game nodes
