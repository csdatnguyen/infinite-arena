extends RefCounted
class_name MobMovementStrategy

# === Strategy Pattern: Base class for enemy movement behavior ===
# This abstract strategy defines the interface for all mob movement behaviors.
# Concrete strategies (e.g., straight, zig-zag) will implement the move() method differently.

func move(mob, delta):
	pass
