extends Node3D

signal selected_image(image_id)

# Carousel configuration
@export var radius: float = 2.0  # Carousel radius
@export var angle_step: float = 15.0  # Angular step between images
@export var rotation_speed: float = 0.0  # Current rotation speed
@export var damping: float = 0.8  # Damping factor for inertia
@export var swipe_sensitivity: float = 3.5  # Swipe sensitivity
@export var image_count: int = 3  # Number of images

var images: Array = []  # Array to store images
var is_grabbed: bool = false
var is_trigger_held: bool = false  # Indicates if the trigger is pressed
var previous_controller_position: Vector3
var carousel_angle: float = 0.0


@export var right_hand: XRController3D  
@onready var interaction_area: Area3D = $InteractionArea

# List of image paths to be loaded dynamically
var image_paths: Array = [
	"res://Materials/DashboardFireExample.png",
	"res://Materials/DashboardFireExample2.png",
	"res://Materials/DashboardTemplateComplete.png"
]
func set_xr_origin(origin: XROrigin3D):
	right_hand = origin.get_node_or_null("RightHand")  # Ajusta la ruta según tu escena
	if not right_hand:
		printerr("Error: RightHand no encontrado en XROrigin3D")
		
func _ready():
	create_images()
	position_images()

func _process(delta):
	if right_hand.is_button_pressed("trigger_click"):
		if not is_trigger_held:  # Execute only the first time the button is pressed
			is_trigger_held = true
			if is_grabbed:
				previous_controller_position = right_hand.global_transform.origin
				print("New position reference saved:", previous_controller_position)
	else: 
		is_trigger_held = false  # Reset when the button is released
		
	if is_grabbed and is_trigger_held:
		# Calculate rotation based on controller movement
		var controller_position = right_hand.global_transform.origin
		var delta_position = controller_position - previous_controller_position
		rotation_speed = delta_position.x * swipe_sensitivity
		default_images_styles()
	else:
		# Apply inertia
		rotation_speed *= damping
		
	carousel_angle += rotation_speed * delta  # Apply accumulated rotation
	var max_angle = (image_count - 1) * deg_to_rad(angle_step) / 2.0
	carousel_angle = clamp(carousel_angle, -max_angle, max_angle)
		
	# Auto-positioning when rotation stops
	if is_grabbed and not is_trigger_held and abs(rotation_speed) < 0.01:
		var target_angle = get_target_angle_for_central_image()
		carousel_angle = lerp(carousel_angle, target_angle, delta * 5.0)
		update_image_styles()
	if not is_grabbed:
		var target_angle = get_target_angle_for_central_image()
		carousel_angle = lerp(carousel_angle, target_angle, delta * 5.0)
		default_images_styles()

	position_images()

# Create images dynamically without using a separate scene
func create_images():
	for i in range(image_count):
		var mesh_instance = MeshInstance3D.new()  # Crear una nueva instancia de MeshInstance3D
		var quad_mesh = QuadMesh.new()  # Crear un QuadMesh
		
		# Establecer el tamaño del QuadMesh
		quad_mesh.size = Vector2(2, 1)
		
		# Asignar el QuadMesh al MeshInstance3D
		mesh_instance.mesh = quad_mesh
		
		# Verificar si hay una textura disponible para este índice
		if i < image_paths.size():
			var texture_path = image_paths[i]
			var texture = load(texture_path)
			
			# Verificar si la textura se cargó correctamente
			if texture:
				var material = StandardMaterial3D.new()  # Crear un material
				material.albedo_texture = texture  # Asignar la textura al material
				mesh_instance.material_override = material  # Aplicar el material al MeshInstance3D
				print("Textura cargada correctamente:", texture_path)
			else:
				print("Error: No se pudo cargar la textura en la ruta:", texture_path)
		else:
			print("Advertencia: No hay textura definida para el índice", i)
			
		add_child(mesh_instance)
		images.append(mesh_instance)

# Position images in a semicircular arc
func position_images():
	for i in range(image_count):
		var angle = (i - (image_count - 1) / 2.0) * deg_to_rad(angle_step) + carousel_angle
		
		# Verificar si el ángulo está fuera del rango [-45, 45] grados
		if angle < deg_to_rad(-45) or angle > deg_to_rad(45):
			# Desactivar la visibilidad de la imagen
			images[i].visible = false
		else:
			# Activar la visibilidad de la imagen si está dentro del rango
			images[i].visible = true
		
		var curvature = 2 #make the images curve more pronounced
		
		var x = radius * sin( angle*curvature)
		var z = radius * cos(angle*curvature) - radius
		
		var image = images[i]
		image.transform.origin = Vector3(x, 0, z)
		
		# Rotate images to face the center
		image.rotation.y = -angle * 2

func get_central_index() -> int:
	var min_angle = 360
	var central_index = 0

	for i in range(image_count):
		var image = images[i]
		var angle = abs(rad_to_deg(fmod(image.rotation.y - carousel_angle, TAU)))
		angle = min(angle, 360 - angle)  # Consider shortest angle

		if angle < min_angle:
			min_angle = angle
			central_index = i
	return central_index
	
func update_image_styles():
	var central_index = get_central_index()  # Get the central image index
	emit_signal("selected_image", central_index)
	for i in range(image_count):
		var image = images[i]

		# Smoothly scale the central image
		if i == central_index:
			image.scale = image.scale.lerp(Vector3(1.3, 1.3, 1.3), 0.1)
		else:
			image.scale = image.scale.lerp(Vector3(1, 1, 1), 0.1)

func default_images_styles():
	for i in range(image_count):
		var image = images[i]
		image.scale = image.scale.lerp(Vector3(1, 1, 1), 0.1)

func get_target_angle_for_central_image() -> float:
	var central_index = get_central_index()
	return -((central_index - (image_count - 1) / 2.0) * deg_to_rad(angle_step))

func _on_interaction_area_area_entered(area: Area3D) -> void:
	if area.is_in_group("controller"):
		is_grabbed = true

func _on_interaction_area_area_exited(area: Area3D) -> void:
	if area.is_in_group("controller"):
		is_grabbed = false
