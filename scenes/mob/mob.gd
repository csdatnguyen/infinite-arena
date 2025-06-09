extends CharacterBody2D

# === State Pattern: manages mob behavior through interchangeable state objects ===
# Reference to the current behavior state (Idle, Chase, or Dead)
var current_state: MobState

# Preloaded starting state (Idle)
const IdleState = preload("res://scenes/mob/MobStates/idle_state.gd")

# === Creational Pattern: Lazy Initialization for smoke effect ===
# Cache smoke effect only when first needed (used in DeadState)
var smoke_scene = null

# === Knockback Effect ===
# Stores velocity applied when hit, gradually decays over time
var knockback_velocity = Vector2.ZERO

# === Mob Attributes ===
# Health and movement speed (can be customized by mob type)
var health = 3
var speed: float = 200.0

# Ensure death logic only happens once
var dead_handled = false

# === Movement Strategy Pattern ===
# Strategy script that defines how this mob moves
var movement_strategy: MobMovementStrategy
var target: Node2D

# === Initialization ===
# To ensure everything is loaded before getting the player's position
@onready var player = get_node("/root/Game/Player")

# Duplicate shader material to prevent flash/tint effects from affecting other mobs
@onready var shader_material: ShaderMaterial = $Slime/Anchor/SlimeBody.material.duplicate()


func _ready():
	target = player
	
	# Assign unique shader material to this mob instance
	$Slime/Anchor/SlimeBody.material = shader_material
	
	# Start in IdleState
	change_state(IdleState.new())


func _physics_process(delta):
	# Call the active state's update logic (e.g., Idle, Chase, or Dead behavior)
	if current_state:
		current_state.update(self, delta)
	
	# Apply knockback effect if active
	if knockback_velocity.length() > 0.1:
		position += knockback_velocity * delta
		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, 800 * delta)	# smooth deceleration
	
	
# === Lazy Initialization: only load smoke effect the first time it's needed needed ===
func get_smoke_scene():
	if smoke_scene == null:
		smoke_scene = preload("res://assets/smoke_explosion/smoke_explosion.tscn")
	return smoke_scene



# Called when mob takes damage
func take_damage():
	health -= 1
	#flash()
	%Slime.play_hurt()
	
	# No need to manually trigger DeadState here — it's now handled within ChaseState


# Called when a bullet hits and applies force to the mob
func apply_knockback(force: Vector2):
	knockback_velocity = force


# === State Pattern: Switch to a new behavior state ===
func change_state(new_state: MobState):
	current_state = new_state
	current_state.enter(self)


# === Animation Wrapper Methods ===
func play_walk_animation():
	%Slime.play_walk()

func play_idle_animation():
	%Slime.play_idle()

func play_hurt_animation():
	%Slime.play_hurt()
