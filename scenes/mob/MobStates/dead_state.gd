extends MobState

# === State Pattern: Dead State ===
# This state handles death behavior — spawning a smoke effect and removing the mob from the scene.

# Called once when the mob enters the DeadState
func enter(mob):
	if not mob.dead_handled:
		mob.dead_handled = true

		# Instantiate smoke explosion effect once
		var smoke = mob.get_smoke_scene().instantiate()
		mob.get_parent().add_child(smoke)
		smoke.global_position = mob.global_position

		# Remove the mob from the scene
		mob.queue_free()

# Called every frame — mob no longer moves in this state
func update(mob, delta):
	mob.velocity = Vector2.ZERO
	mob.move_and_slide()
