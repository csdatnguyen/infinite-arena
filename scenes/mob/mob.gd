extends CharacterBody2D

# Behavioral Pattern: State – manage mob behavior with distinct states
enum MobState { IDLE, CHASE, DEAD }
var state: MobState = MobState.IDLE  # Start in idle state

# Creational Pattern: Lazy Initialization
var smoke_scene = null 	# only load when needed

# Mob's hp and speed
var health = 3
var speed: float = 200.0

# For handling mobs deaths (MobState.DEAD)
var dead_handled = false

# To ensure everything is loaded before getting the player's position
@onready var player = get_node("/root/Game/Player")

# Duplicate the material to prevent shared flashing across all mobs
@onready var shader_material: ShaderMaterial = $Slime/Anchor/SlimeBody.material.duplicate()


func _ready():
	# Apply the unique material to this mob instance
	$Slime/Anchor/SlimeBody.material = shader_material
	
	%Slime.play_walk()


func _physics_process(delta):
	match state:
		MobState.IDLE:
			# Do nothing and play idle animation
			%Slime.play_idle()
			velocity = Vector2.ZERO
			move_and_slide()

		MobState.CHASE:
			# global_position: where something is in the game world
			var direction = global_position.direction_to(player.global_position)
			velocity = direction * speed
			move_and_slide()

		MobState.DEAD:
			if not dead_handled:
				dead_handled = true
				
				# Load smoke only the first time it's needed
				var smoke = get_smoke_scene().instantiate()
				get_parent().add_child(smoke)	# get_parent() add sibling of a mob, smoke does not disappear after queue_free()
				smoke.global_position = global_position
				
				queue_free()
				
			# No movement when dead
			velocity = Vector2.ZERO
			move_and_slide()
			
	# State transition: from IDLE to CHASE when player is nearby
	if state == MobState.IDLE:
		var distance_to_player = global_position.distance_to(player.global_position)
		if distance_to_player < 1000:  # Adjust threshold as needed
			state = MobState.CHASE
	
	
# Lazy Initialization: loads smoke scene only once when first needed
func get_smoke_scene():
	if smoke_scene == null:
		smoke_scene = preload("res://assets/smoke_explosion/smoke_explosion.tscn")
	return smoke_scene


# Shader Effect: Flash the mob briefly when taking damage
func flash():
	#print("Flashing!")
	shader_material.set_shader_parameter("flash_amount", 1.0)
	await get_tree().create_timer(0.1).timeout
	shader_material.set_shader_parameter("flash_amount", 0.0)


func take_damage():
	health -= 1
	flash()
	%Slime.play_hurt()
	
	if health <= 0 and state != MobState.DEAD:
		state = MobState.DEAD
