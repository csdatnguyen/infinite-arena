extends Node
class_name MobState

# === State Pattern: Base class for mob states ===
# This abstract class defines the interface for mob behavior states.
# Concrete states (Idle, Chase, Dead) inherit from this and implement their own logic.

# Called once when the mob enters this state
func enter(mob): pass


# Called every frame to update behavior in this state
func update(mob, delta): pass
