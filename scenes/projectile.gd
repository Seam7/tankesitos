extends RigidBody2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	print("in projectile")
	if body is StaticBody2D and body.is_in_group("breakable"):
		body.queue_free()  # Destroy the terrain
	if body.is_in_group("trophy"):
		body.queue_free()
	queue_free()
