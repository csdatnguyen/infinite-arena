extends CharacterBody2D

# create game over signal
signal health_depleted

var health = 100

# delta helps ensure your movement, animations, and timers are frame rate independent 
# — so they run at the same speed no matter how fast the game is running.
# delta: Time passed since the last frame (in seconds) 
func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 400		# move in input direction at 600 pixels/sec
	move_and_slide()	# helps character slide along the surface instead of stopping

	if velocity.length() > 0.0:		# when not inputing any key, direction = 0, so velocity = 0
		# get_node("HappyBoo") -> get_node("path"), e.g get_node("CollisionShape2D/HappyBoo")
		# $HappyBoo as shortcut
		%HappyBoo.play_walk_animation() # Access as Unique Name -> no need for path. Only works within the scene
	else:
		%HappyBoo.play_idle_animation() # Access as Unique Name -> no need for path. Only works within the scene
	
	const DAMAGE_RATE = 5
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		# With delta, we scale actions by time, not frames. So damage is consistent no mater the FPS
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		# %ProgressBar.max_value = 500	# increase max health to 500
		
		if health <= 0:
			health_depleted.emit()
