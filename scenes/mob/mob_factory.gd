extends Node

# Base mob scene used as the prototype for cloning variants
const BASE_MOB = preload("res://scenes/mob/mob.tscn")

# Factory Method: Create a new base mob instance (used as prototype)
func create_base_mob() -> Node2D:
	var mob = BASE_MOB.instantiate()
	set_tint(mob, Color.WHITE, 0.0) # remain untined
	return mob

# Prototype Pattern: Create a small mob by cloning the base and customizing its properties
func create_small_mob() -> Node2D:
	var mob = create_base_mob()
	mob.scale = Vector2(0.5, 0.5)
	mob.health = 1
	mob.speed = 300
	set_tint(mob, Color(0.4, 1.0, 1.0), 0.7)  # cyan
	return mob

# Prototype Pattern: Create a big mob by cloning the base and customizing its properties
func create_big_mob() -> Node2D:
	var mob = create_base_mob()
	mob.scale = Vector2(1.5, 1.5)
	mob.health = 5
	mob.speed = 100
	set_tint(mob, Color(1.0, 0.6, 0.8), 0.7) # pink
	return mob

# Apply a base tint color to the mob's shader material
func set_tint(mob: Node2D, color: Color, strength: float) -> void:
	var mat = mob.get_node("Slime/Anchor/SlimeBody").material
	if mat is ShaderMaterial:
		mat.set_shader_parameter("base_tint_color", color)
		mat.set_shader_parameter("tint_strength", strength)
