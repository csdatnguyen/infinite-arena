extends Node

# === Creational Pattern: Factory Method ===
# Provides a centralized method for creating new bullet instances

func create_bullet() -> Area2D:
	const BULLET = preload("res://scenes/bullet/bullet.tscn")  # Load bullet scene
	return BULLET.instantiate()   # Instantiate and return a new bullet
