extends Node2D
	

func spawn_mob():
	const MOB = preload("res://mob.tscn")
	var new_mob = MOB.instantiate()
	%PathFollow2D.progress_ratio = randf()	# random num between 0 and 1
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)


func _on_timer_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true	#get scene tree, root of all game nodes
