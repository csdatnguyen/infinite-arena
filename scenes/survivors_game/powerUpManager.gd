extends Node
class_name PowerUpManager

# === Facade Pattern: Provides a unified interface for applying power-ups ===
# This centralizes upgrade logic so other scripts don't need to handle specific upgrade implementation.

static func apply_upgrade(player: Node, upgrade_type: String) -> void:
	match upgrade_type:
		"IncreaseFireRate":
			# Check if the player has a Gun node
			if player.has_node("Gun"):
				var gun = player.get_node("Gun")
				
				# Verify the gun supports modifying fire rate
				if gun.has_method("set_fire_rate"):
					var new_rate = gun.fire_rate * 0.9  # Reduce wait time by 10%
					gun.set_fire_rate(new_rate)
					print("PowerUp: Increased fire rate to ", new_rate)
				else:
					print("Gun does not support set_fire_rate.")
			else:
				print("Player has no Gun node.")
				
		"IncreaseBulletSize":
			# Check if the player has a Gun node
			if player.has_node("Gun"):
				var gun = player.get_node("Gun")
				
				# Verify the gun supports scaling bullets
				if gun.has_method("set_bullet_scale"):
					gun.set_bullet_scale(1.1)  # increase size by 10%
					print("PowerUp: Increased bullet size.")
				else:
					print("Gun does not support set_bullet_scale.")
			else:
				print("Player has no Gun node.")
		
		_:
			# Fallback for unknown upgrade keys
			print("Unknown upgrade type: ", upgrade_type)
