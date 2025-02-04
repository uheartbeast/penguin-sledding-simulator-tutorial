class_name VisibleCollisionPolygon2D extends CollisionPolygon2D

@export var color: Color = Color.WHITE

func _ready() -> void:
	var sprite = Polygon2D.new()
	add_child(sprite)
	sprite.polygon = polygon
	sprite.color = color
