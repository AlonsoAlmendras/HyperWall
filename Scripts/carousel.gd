extends Node3D

signal image_change(image_id)
@export var xr_origin: XROrigin3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_viewport().use_xr = true
	
	# Give XROrigin3D to CarouselContainer
	$CarouselContainer.set_xr_origin(xr_origin)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	

func selected_image(image_id: Variant) -> void:
	emit_signal("image_change", image_id)
