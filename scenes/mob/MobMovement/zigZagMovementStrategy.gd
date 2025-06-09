extends MobMovementStrategy
class_name ZigZagMovement

# === Strategy Pattern: Zig-zag movement behavior ===
# This movement strategy makes the mob weave left and right while moving toward the target.

var zigzag_amplitude := 500.0	# How far side-to-side the mob sways
var zigzag_frequency := 5.0		# How quickly it zig-zags
var time := 0.0					# Internal timer to drive sine wave movement


func move(mob: Node2D, delta: float) -> void:
	if mob.target:
		time += delta
		
		# Base direction toward the player
		var direction = (mob.target.global_position - mob.global_position).normalized()
		
		# Perpendicular direction for side-to-side movement
		var perpendicular = Vector2(-direction.y, direction.x)
		
		# Calculate zig-zag offset using sine wave
		var offset = perpendicular * sin(time * zigzag_frequency) * zigzag_amplitude
		
		# Final zig-zag direction with offset applied
		var zigzag_dir = (mob.target.global_position + offset - mob.global_position).normalized()

		# Set velocity and apply movement
		mob.velocity = zigzag_dir * mob.speed
		mob.move_and_slide()
