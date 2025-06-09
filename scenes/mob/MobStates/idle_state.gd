extends MobState

# === State Pattern: Idle State ===
# This state represents passive behavior — the mob waits until the player gets close.

# Preload ChaseState so mob can transition when player enters detection range
const ChaseState = preload("res://scenes/mob/MobStates/chase_state.gd")

# Called once when mob enters idle state
func enter(mob):
	mob.velocity = Vector2.ZERO
	mob.play_idle_animation()


# Called every frame — transitions to ChaseState when player is near
func update(mob, delta):
	var distance_to_player = mob.global_position.distance_to(mob.player.global_position)
	if distance_to_player < 1000:
		mob.change_state(ChaseState.new())
