extends Node3D

# Variables de referencia
var right_hand: XRController3D
var left_hand: XRController3D
@export var rotation_speed: float = 3.0  # Velocidad de rotación ajustable

func _ready():
	# Obtener la referencia al controlador derecho
	var xr_origin = get_node("../XROrigin3D")  # Asumiendo que XROrigin3D es hermano en la escena
	if xr_origin:
		right_hand = xr_origin.get_node("RightHand")
		left_hand = xr_origin.get_node("LeftHand")

func _process(delta):
	# Verificar si el botón está presionado y rotar el mesh
	if right_hand.is_button_pressed("ax_button"):
		$MeshInstance3D.rotate_y(rotation_speed * delta)
	
	if left_hand.is_button_pressed("ax_button"):
		$MeshInstance3D.rotate_y(-rotation_speed * delta)
