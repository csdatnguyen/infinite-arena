extends Node

# === Mob Factory with Prototype Pattern ===
# This factory creates base, small, and big mob variants by cloning a shared prototype.
# Each variant is customized after duplication to fit its behavior and appearance.

# Base mob scene used as the prototype for cloning variants
const BASE_MOB = preload("res://scenes/mob/mob.tscn")

# Cache a single base mob instance for duplication (Prototype Pattern)
var prototype_mob = BASE_MOB.instantiate()


# Factory Method + Prototype Pattern:
# Clone the prototype and configure a default/base mob
func create_base_mob() -> Node2D:
	var mob = prototype_mob.duplicate()
	
	# Assign Straight movement strategy
	mob.movement_strategy = preload("res://scenes/mob/MobMovement/straightMovementStrategy.gd").new()
	
	# Keep base mob untinted
	set_tint(mob, Color.WHITE, 0.0)
	return mob


# Factory Method + Prototype Pattern:
# Clone the prototype and configure a small, fast variant
func create_small_mob() -> Node2D:
	var mob = prototype_mob.duplicate()
	mob.scale = Vector2(0.5, 0.5)
	mob.health = 1
	mob.speed = 300
	
	# Assign ZigZag movement strategy
	mob.movement_strategy = preload("res://scenes/mob/MobMovement/zigZagMovementStrategy.gd").new()
	
	# Cyan tint for small mob
	set_tint(mob, Color(0.4, 1.0, 1.0), 0.7)  # cyan
	return mob


# Factory Method + Prototype Pattern:
# Clone the prototype and configure a large, tanky variant
func create_big_mob() -> Node2D:
	var mob = prototype_mob.duplicate()
	mob.scale = Vector2(1.5, 1.5)
	mob.health = 5
	mob.speed = 100
	
	# Assign Straight movement strategy
	mob.movement_strategy = preload("res://scenes/mob/MobMovement/straightMovementStrategy.gd").new()
	
	# Pink tint for big mob
	set_tint(mob, Color(1.0, 0.6, 0.8), 0.7) # pink
	return mob


# Utility function to apply color tint through the mob's shader
func set_tint(mob: Node2D, color: Color, strength: float) -> void:
	var mat = mob.get_node("Slime/Anchor/SlimeBody").material
	if mat is ShaderMaterial:
		mat.set_shader_parameter("base_tint_color", color)
		mat.set_shader_parameter("tint_strength", strength)
