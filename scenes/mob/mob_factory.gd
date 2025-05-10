extends Node

# Creational Pattern: Factory Method
# for creating mobs
func create_mob() -> Node2D:
	const MOB = preload("res://scenes/mob/mob.tscn")
	return MOB.instantiate()
