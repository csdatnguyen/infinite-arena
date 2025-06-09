extends MobMovementStrategy
class_name StraightMovement

# === Strategy Pattern: Straight-line movement behavior ===
# This movement strategy causes the mob to move directly toward the player in a straight line.

@warning_ignore("unused_parameter")
func move(mob: Node2D, delta: float) -> void:
	if mob.target:
		# Calculate direction to player
		var direction = (mob.target.global_position - mob.global_position).normalized()
		
		# Set mob velocity based on direction and speed
		mob.velocity = direction * mob.speed
		
		# Apply movement using Godot's physics
		mob.move_and_slide()
