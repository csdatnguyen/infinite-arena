extends Area2D

# In collision settings:
# - Layer: who can detect this gun
# - Mask: who this gun detectshe gun detects

# === Bullet System ===
# Factory for creating bullet instances
var bullet_factory = preload("res://scenes/bullet/BulletCreation/bullet_factory.gd").new()

# Controls how fast bullets are fired (seconds between shots)
var fire_rate: float = 1.0

# Default bullet size (can be scaled via power-ups)
var bullet_scale: Vector2 = Vector2(0.8, 0.8)	# default bullet size

# Shooting modes: aim at closest enemy or toward mouse
enum ShootingMode { CLOSEST_ENEMY, MOUSE_POSITION }
var shooting_mode: ShootingMode = ShootingMode.CLOSEST_ENEMY

# Reference to the internal timer used for auto-shooting
@onready var shoot_timer := $Timer


func _physics_process(delta):
	# Auto-aiming logic based on current shooting mode
	if shooting_mode == ShootingMode.CLOSEST_ENEMY:
		# Get enemies within range using the Area2D's collision shape
		var enemies_in_range = get_overlapping_bodies()
		if enemies_in_range.size() > 0:
			var target_enemy = enemies_in_range.front() # first element in the array
			look_at(target_enemy.global_position)
			
	elif shooting_mode == ShootingMode.MOUSE_POSITION:
		var mouse_position = get_viewport().get_camera_2d().get_global_mouse_position()
		look_at(mouse_position)


func shoot():
	# Create and fire a new bullet
	var new_bullet = bullet_factory.create_bullet()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	new_bullet.scale = bullet_scale
	
	%ShootingPoint.add_child(new_bullet)
	$ShootSound.play()


func _on_timer_timeout() -> void:
	# Called automatically when shoot timer reaches zero
	shoot()


func set_fire_rate(new_rate: float) -> void:
	# Update firing rate and adjust timer accordingly
	fire_rate = new_rate
	shoot_timer.wait_time = fire_rate


func set_bullet_scale(scale_multiplier: float) -> void:
	# Increase bullet size by a multiplier
	bullet_scale *= scale_multiplier
	
	# Cap the scale so it doesn't exceed 2x size
	if bullet_scale.x > 2.0:
		bullet_scale = Vector2(2.0, 2.0)


func _unhandled_input(event):
	# Toggle between shooting modes using key input
	if event.is_action_pressed("toggle_shoot_mode"):
		if shooting_mode == ShootingMode.CLOSEST_ENEMY:
			shooting_mode = ShootingMode.MOUSE_POSITION
			print("Switched to MOUSE_POSITION mode")
		else:
			shooting_mode = ShootingMode.CLOSEST_ENEMY
			print("Switched to CLOSEST_ENEMY mode")
