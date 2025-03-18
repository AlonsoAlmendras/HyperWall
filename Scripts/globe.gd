extends Node3D

var rotation_speed = 1.0
var angle = deg_to_rad(23.5)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(rotation_speed * delta)
