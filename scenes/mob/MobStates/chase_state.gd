extends MobState

# === State Pattern: Chase State ===
# In this state, the mob actively moves toward the player using its assigned movement strategy.

# Preload DeadState to allow immediate transition when mob dies during chase
const DeadState = preload("res://scenes/mob/MobStates/dead_state.gd")

# Called once when the mob starts chasing
func enter(mob):
	mob.play_walk_animation()


# Called every frame — executes movement and checks for death transition
func update(mob, delta):
	# Move toward the player using the assigned strategy (e.g., straight or zig-zag)
	mob.movement_strategy.move(mob, delta)

	# If health is depleted, switch to DeadState
	if mob.health <= 0:
		mob.change_state(DeadState.new())
