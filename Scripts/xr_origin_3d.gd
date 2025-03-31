extends XROrigin3D

# Asegúrate de que la ruta al RayCast3D sea correcta
@onready var raycast = $XRCamera3D/RayCast3D
signal object_seen(object)
var LastObjectSeen


func _process(_delta):
	# Actualiza la dirección del RayCast para que siga la mirada de la cámara
	raycast.force_raycast_update()  # Fuerza una actualización del RayCast

	if raycast.is_colliding():
		var ActualObjectSeen = raycast.get_collider()
		var ColitionPoint = raycast.get_collision_point()
		print("Last Object: ", LastObjectSeen)
		print("Actual Object: ", ActualObjectSeen)
		if LastObjectSeen != ActualObjectSeen:
			LastObjectSeen = ActualObjectSeen
			emit_signal("object_seen", ActualObjectSeen)
		#print("Objeto mirado: ", objeto_mirado.name)
		#print("Posición de colisión: ", punto_colision)
	#else:
	#	print("El usuario no está mirando ningún objeto")
