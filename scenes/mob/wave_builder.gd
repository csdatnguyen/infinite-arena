extends Node

# Builder Pattern: builds waves with configurable parameters

var mob_count := 5
var mob_type := "base"  # "base", "small", "big", "mixed"
var mob_factory := preload("res://scenes/mob/mob_factory.gd").new()
var spawn_area_node: Node = null  # reference to where mobs should spawn (set by caller)

func set_mob_count(count: int) -> Node:
	mob_count = count
	return self

func set_mob_type(type: String) -> Node:
	mob_type = type
	return self

func set_spawn_area(area: Node) -> Node:
	spawn_area_node = area
	return self


func build_wave():
	for i in range(mob_count):
		var mob = create_mob()
		if mob and spawn_area_node:
			spawn_area_node.add_child(mob)
			spawn_mob_randomly(mob)


# Create mob based on selected type
func create_mob() -> Node2D:
	match mob_type:
		"small":
			return mob_factory.create_small_mob()
		"big":
			return mob_factory.create_big_mob()
		"mixed":
			var roll = randf()
			if roll < 0.33:
				return mob_factory.create_base_mob()
			elif roll < 0.66:
				return mob_factory.create_small_mob()
			else:
				return mob_factory.create_big_mob()
		_:
			return mob_factory.create_base_mob()


# Position mob somewhere randomly along a path
func spawn_mob_randomly(mob: Node2D):
	if spawn_area_node.has_node("Player/Path2D/PathFollow2D"):
		var path = spawn_area_node.get_node("Player/Path2D/PathFollow2D")
		path.progress_ratio = randf()
		mob.global_position = path.global_position
