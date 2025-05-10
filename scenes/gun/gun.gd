extends Area2D

# In Collision, Layer controls what can detect the gun
# Mask controls what the gun detects

# for creating bullets
var bullet_factory = preload("res://scenes/bullet/bullet_factory.gd").new()

func _physics_process(delta):
	#  returns a list (Array) of physics bodies that are currently touching or inside the Area2D's collision shape
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front() # first element in the array
		look_at(target_enemy.global_position)
		
		
func shoot():
	var new_bullet = bullet_factory.create_bullet()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)


func _on_timer_timeout() -> void:
	shoot()
