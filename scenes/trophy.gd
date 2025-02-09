extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))


func _on_body_entered(body: Node) -> void:
	print(body)
	if body is RigidBody2D and body.is_in_group("bullets"):
		print("ded")
		queue_free()
