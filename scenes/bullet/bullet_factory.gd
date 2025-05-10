extends Node

# Creational Pattern: Factory Method
# Creating bullets
func create_bullet() -> Area2D:
	const BULLET = preload("res://scenes/bullet/bullet.tscn")
	return BULLET.instantiate()
