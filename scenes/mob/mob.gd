extends CharacterBody2D


# Creational Pattern: Lazy Initialization
var smoke_scene = null 	# only load when needed

var health = 3

# To ensure everything is loaded before getting the player's position
@onready var player = get_node("/root/Game/Player")

func _ready():
	%Slime.play_walk()

func _physics_process(delta):
	# global_position: where something is in the game world
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 200.0
	move_and_slide()
	
	
# Lazy Initialization: loads smoke scene only once when first needed
func get_smoke_scene():
	if smoke_scene == null:
		smoke_scene = preload("res://assets/smoke_explosion/smoke_explosion.tscn")
	return smoke_scene
	
func take_damage():
	health -= 1
	%Slime.play_hurt()
	
	if health == 0:
		queue_free()
		
		# Load smoke only the first time it's needed
		var smoke = get_smoke_scene().instantiate()
		get_parent().add_child(smoke)	# get_parent() add sibling of a mob, smoke does not disappear after queue_free()
		smoke.global_position = global_position
