extends Node3D

var angle = 23.5
var rotation_axis = Vector3(0, angle, 0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate(rotation_axis, 1 * delta)
