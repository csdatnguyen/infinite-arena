extends CharacterBody2D

# === Observer Pattern: Custom signal to notify game over ===
signal health_depleted

# === Player Stats ===
var health = 100
var is_taking_damage: bool = false	# tracks if player is currently in contact with enemies

# === Dash Properties ===
var dash_direction := Vector2.ZERO
var is_dashing: bool = false
var dash_speed: float = 1000.0
var dash_duration: float = 0.2
var dash_cooldown: float = 2.0
var dash_timer := 0.0
var dash_cooldown_timer := 0.0

# === Movement and Damage Logic ===
func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Dash cooldown management
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta

	# Dash Activation
	if Input.is_action_just_pressed("dash") and not is_dashing and dash_cooldown_timer <= 0:
		is_dashing = true
		dash_timer = dash_duration
		dash_cooldown_timer = dash_cooldown
		dash_direction = direction.normalized()
		velocity = dash_direction * dash_speed
	
	# During dash
	elif is_dashing:
		dash_timer -= delta
		velocity = dash_direction * dash_speed
		if dash_timer <= 0:
			is_dashing = false
	
	# Regular movement
	else:
		velocity = direction * 400  # normal move speed
	
	# Apply movement (handles collisions and sliding)
	move_and_slide()

	# Animation Control
	if velocity.length() > 0.0:		# when not inputing any key, direction = 0, so velocity = 0
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
	
	# Damage Detection & Application
	const DAMAGE_RATE = 5
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		is_taking_damage = true
		
		# Damage scales with number of overlapping mobs
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		# %ProgressBar.max_value = 500	# increase max health to 500
		
		# Trigger "game over" signal if health reaches 0
		if health <= 0:
			health_depleted.emit()

	else:
		is_taking_damage = false

	# Flashing Shader Effect
	flash()


# === Flash shader on damage ===
func flash():
	# Access the shader material on the player's main sprite
	var mat = %HappyBoo.get_node("Colorizer/SquareBody").material
	
	if mat and mat is ShaderMaterial:
		if is_taking_damage:
			mat.set_shader_parameter("flash_amount", 1.0)
		else:
			mat.set_shader_parameter("flash_amount", 0.0)
