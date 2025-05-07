extends Area2D

# In Collision, Layer controls what can detect the gun
# Mask controls what the gun detects

func _physics_process(delta):
	#  returns a list (Array) of physics bodies that are currently touching or inside the Area2D's collision shape.
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front() # first element in the array
		look_at(target_enemy.global_position)
		
func shoot():
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)


func _on_timer_timeout() -> void:
	shoot()
