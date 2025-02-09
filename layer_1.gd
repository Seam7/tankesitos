extends TileMapLayer

@onready var tileset_layer = $"."
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(tileset_layer)
	tileset_layer.set_cell(Vector2i(-10, 10))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
