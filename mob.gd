extends CharacterBody2D

var health = 3

@onready var player = get_node("/root/Game/Player")
# shorthand for below:
# var player
# _ready(): To ensure everything is loaded before getting the player's position
# func _ready():
#	 player = get_node("/root/Game/Player")

func _ready():
	%Slime.play_walk()

func _physics_process(delta):
	# global_position: where something is in the game world
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 200.0
	move_and_slide()
	
func take_damage():
	health -= 1
	%Slime.play_hurt()
	
	if health == 0:
		queue_free()
		
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)	# get_parent() add sibling of a mob, smoke does not disappear after queue_free()
		smoke.global_position = global_position
