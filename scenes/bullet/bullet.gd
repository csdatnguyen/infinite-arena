extends Area2D

# === Bullet Behavior ===

# Tracks how far the bullet has traveled
var travelled_distance = 0

func _ready():
	# Scale visuals and hitbox to match this bullet's size
	$Projectile.scale = self.scale
	$CollisionShape2D.scale = self.scale


func _physics_process(delta):
	const SPEED = 300
	const RANGE = 1000
	
	# Move bullet forward based on rotation
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta

	# Track distance and remove if it exceeds range
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()


func _on_body_entered(body: Node2D):
	# Remove bullet on hit
	queue_free()
	
	# Deal damage if the target can take it
	if body.has_method("take_damage"):
		body.take_damage()

	# Apply knockback if supported
	if body.has_method("apply_knockback"):
		var direction = (body.global_position - global_position).normalized()
		body.apply_knockback(direction * 350)
