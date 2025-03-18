extends Node3D

@onready var sound: AudioStreamPlayer = $Sound


var material_on: Material = load("res://Materials/button_on.tres")
var material_off: Material = load("res://Materials/button_off.tres")

var status: bool
signal status_changed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	status = false
	$Clicker.set_surface_override_material(0, material_off)

	
func change_value(_buttom: Variant) -> void:
	sound.play()
	status = !status
	if status:
		print("ON")
		$Clicker.set_surface_override_material(0, material_on)
	else:
		print("OFF")
		$Clicker.set_surface_override_material(0, material_off)
		
	emit_signal("status_changed")
		
