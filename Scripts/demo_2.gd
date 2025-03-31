extends Node3D

var xr_interface : XRInterface

func _ready() -> void:
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialised succesfully")
		
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		
		get_viewport().use_xr = true
	else:
		print("OpenXR not initialialised, headset prbably desconnected")
		
	print("Posición global del XROrigin3D: ", global_transform.origin)

func _process(delta: float) -> void:
	const move_speed := 2.0
	#Left Path
	$Overview/Path3DLeft/PathFollow3DLeft.progress += move_speed*delta
	$Overview/Path3DLeft/PathFollow3DLeft2.progress += move_speed*delta
	$Overview/Path3DLeft/PathFollow3DLeft3.progress += move_speed*delta
	$Overview/Path3DLeft/PathFollow3DLeft4.progress += move_speed*delta
	$Overview/Path3DLeft/PathFollow3DLeft5.progress += move_speed*delta
	#Middle Path
	$Overview/Path3DAhead/PathFollow3DAhead.progress += move_speed*delta
	$Overview/Path3DAhead/PathFollow3DAhead2.progress += move_speed*delta
	$Overview/Path3DAhead/PathFollow3DAhead3.progress += move_speed*delta
	$Overview/Path3DAhead/PathFollow3DAhead4.progress += move_speed*delta
	$Overview/Path3DAhead/PathFollow3DAhead5.progress += move_speed*delta
	#Right Path
	$Overview/Path3DRight/PathFollow3DRight.progress += move_speed*delta
	$Overview/Path3DRight/PathFollow3DRight2.progress += move_speed*delta
	$Overview/Path3DRight/PathFollow3DRight3.progress += move_speed*delta
	$Overview/Path3DRight/PathFollow3DRight4.progress += move_speed*delta
	$Overview/Path3DRight/PathFollow3DRight5.progress += move_speed*delta

func Fire_body_entered(_body: Node3D) -> void:
	$Selection/Fire/Fire.play()


func Fire_body_exited(_body: Node3D) -> void:
	$Selection/Fire/Fire.stop()


func Weather_body_entered(_body: Node3D) -> void:
	$Selection/Weather/Weather.play()


func Weather_body_exited(_body: Node3D) -> void:
	$Selection/Weather/Weather.stop()


func Air_body_entered(_body: Node3D) -> void:
	$Selection/AirQuality/Wind.play()


func Air_body_exited(_body: Node3D) -> void:
	$Selection/AirQuality/Wind.stop()


func Intro_body_entered(_body: Node3D) -> void:
	print("Intro")
	$Attention/Intro.play()


func Intro_body_exited(_body: Node3D) -> void:
	$Attention/Intro.stop()

func Overview_body_entered(_body: Node3D) -> void:
	print("Overview")
	$Overview/AnimationPlayer.play("RESET")


func Overview_body_exited(_body: Node3D) -> void:
	print("Overview Out")
	$Overview/AnimationPlayer.stop()
	$Overview/AnimationPlayer.seek(0)
	$Overview/Audio/Intro.stop()
	$Overview/Audio/Left.stop()
	$Overview/Audio/Ahead.stop()
	$Overview/Audio/Right.stop()
	$Overview/Audio/End.stop()
	$Overview/Path3DLeft.visible = false
	$Overview/Path3DAhead.visible = false
	$Overview/Path3DRight.visible = false
