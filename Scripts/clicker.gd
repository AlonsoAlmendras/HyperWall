extends MeshInstance3D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	status = false
	set_surface_override_material(0, material_off)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	

	
