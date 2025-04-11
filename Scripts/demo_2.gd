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
	
	
	
	
	#Configuration to capture the first frame of every video
	$Room/WallFront/MeshInstance3D/Dashboard/Left/Fires2/SubViewport/VideoStreamPlayer.play()
	$Room/WallFront/MeshInstance3D/Dashboard/Left/Fires3/SubViewport/VideoStreamPlayer.play()
	$Room/WallFront/MeshInstance3D/Dashboard/Left/Fires4/SubViewport/VideoStreamPlayer.play()
	$Room/WallFront/MeshInstance3D/Dashboard/Middle/Weather/SubViewport/VideoStreamPlayer.play()
	$Room/WallFront/MeshInstance3D/Dashboard/Middle/Weather2/SubViewport/VideoStreamPlayer.play()
	$Room/WallFront/MeshInstance3D/Dashboard/Middle/Weather3/SubViewport/VideoStreamPlayer.play()
	$Room/WallFront/MeshInstance3D/Dashboard/Right/AirQuality/SubViewport/VideoStreamPlayer.play()
	$Room/WallFront/MeshInstance3D/Dashboard/Right/AirQuality2/SubViewport/VideoStreamPlayer.play()
	$Room/WallFront/MeshInstance3D/Dashboard/Right/AirQuality3/SubViewport/VideoStreamPlayer.play()
	$Room/WallFront/MeshInstance3D/Dashboard/Right/AirQuality4/SubViewport/VideoStreamPlayer.play()
	
	await get_tree().process_frame
	$Room/WallFront/MeshInstance3D/Dashboard/Left/Fires2/SubViewport/VideoStreamPlayer.paused =true
	$Room/WallFront/MeshInstance3D/Dashboard/Left/Fires3/SubViewport/VideoStreamPlayer.paused =true
	$Room/WallFront/MeshInstance3D/Dashboard/Left/Fires4/SubViewport/VideoStreamPlayer.paused =true
	$Room/WallFront/MeshInstance3D/Dashboard/Middle/Weather/SubViewport/VideoStreamPlayer.paused =true
	$Room/WallFront/MeshInstance3D/Dashboard/Middle/Weather2/SubViewport/VideoStreamPlayer.paused =true
	$Room/WallFront/MeshInstance3D/Dashboard/Middle/Weather3/SubViewport/VideoStreamPlayer.paused =true
	$Room/WallFront/MeshInstance3D/Dashboard/Right/AirQuality/SubViewport/VideoStreamPlayer.paused =true
	$Room/WallFront/MeshInstance3D/Dashboard/Right/AirQuality2/SubViewport/VideoStreamPlayer.paused =true
	$Room/WallFront/MeshInstance3D/Dashboard/Right/AirQuality3/SubViewport/VideoStreamPlayer.paused =true
	$Room/WallFront/MeshInstance3D/Dashboard/Right/AirQuality4/SubViewport/VideoStreamPlayer.paused =true

	#var video_texture: Texture2D = $Room/WallFront/MeshInstance3D/Dashboard/Middle/Weather3/SubViewport/VideoStreamPlayer.get_texture()
	#var frame_image: Image = video_texture.get_image()
	#var static_texture = ImageTexture.create_from_image(frame_image)
	#$Room/WallFront/MeshInstance3D/Dashboard/Left/Fires.texture = static_texture
	#$Room/WallFront/MeshInstance3D/Dashboard/Left/Fires/SubViewport/VideoStreamPlayer.stop()

	#$Room/WallFront/MeshInstance3D/Dashboard/Left/Fires2.texture = static_texture
	#$Room/WallFront/MeshInstance3D/Dashboard/Middle/Weather3/SubViewport/VideoStreamPlayer.stop()


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




func Attention_body_entered(_body: Node3D) -> void:
	print("Entra Attention")
	$Attention/Speaker/Voice.play()
	await get_tree().create_timer(15.0).timeout
	$Motivation/StandHere.visible = true

func Attention_body_exited(_body: Node3D) -> void:
	$Attention/Speaker/Voice.stop()
	$Attention/StandHere.visible = false
	


func Motivation_body_entered(body: Node3D) -> void:
	print("Entra Motivation")
	$Motivation/Speaker/Voice.play()
	await get_tree().create_timer(18.0).timeout
	$Overview/StandHere.visible = true

func Motivation_body_exited(body: Node3D) -> void:
	$Motivation/Speaker/Voice.stop()
	$Motivation/StandHere.visible = false

	
func Overview_body_entered(_body: Node3D) -> void:
	print("Entra Overview")
	$Overview/AnimationPlayer.play("Overview")


func Overview_body_exited(_body: Node3D) -> void:
	$Overview/AnimationPlayer.stop()
	$Overview/AnimationPlayer.seek(0)
	$Overview/Speaker/Voice.stop()
	$Selection/Fire/StandHere.visible = true
	$Selection/Weather/StandHere.visible = true
	$Selection/AirQuality/StandHere.visible = true
	$Overview/Path3DLeft.visible = false
	$Overview/Path3DAhead.visible = false
	$Overview/Path3DRight.visible = false
	$Overview/StandHere.visible = false




func Selection_Fire_body_entered(body: Node3D) -> void:
	print("Entra Selection Fire")
	$Selection/Fire/Speaker/Voice.play()
	$Selection/Fire/Speaker/Ambient.play()
	
	await get_tree().create_timer(10.0).timeout
	$Explain/Left/StandHere.visible = true


func Selection_Fire_body_exited(body: Node3D) -> void:
	$Selection/Fire/Speaker/Voice.stop()
	$Selection/Fire/Speaker/Ambient.stop()
	$Explain/Left/StandHere.visible = false


func Selection_Weather_body_entered(body: Node3D) -> void:
	print("Entra Selection Weather")
	$Selection/Weather/Speaker/Voice.play()
	$Selection/Weather/Speaker/Ambient.play()
	
	await get_tree().create_timer(11.5).timeout
	$Explain/Middle/StandHere.visible = true


func Selection_Weather_body_exited(body: Node3D) -> void:
	$Selection/Weather/Speaker/Voice.stop()
	$Selection/Weather/Speaker/Ambient.stop()
	$Explain/Middle/StandHere.visible = false


func Selection_Air_body_entered(body: Node3D) -> void:
	print("Entra Selection AirQuality")
	$Selection/AirQuality/Speaker/Voice.play()
	$Selection/AirQuality/Speaker/Ambient.play()
	
	await get_tree().create_timer(10.0).timeout
	$Explain/Right/StandHere.visible = true



func Selection_Air_body_exited(body: Node3D) -> void:
	$Selection/AirQuality/Speaker/Voice.stop()
	$Selection/AirQuality/Speaker/Ambient.stop()
	$Explain/Right/StandHere.visible = false


func Explain_Fire_body_entered(body: Node3D) -> void:
	print("Entra Explain Left")
	$Explain/Right/AnimationPlayer.play("Left")


func Explain_Fire_body_exited(body: Node3D) -> void:
	$Explain/Right/AnimationPlayer.stop()



func Explain_Weather_body_entered(body: Node3D) -> void:
	
	print("Entra Explain Weather")


func Explain_Weather_body_exited(body: Node3D) -> void:
	pass # Replace with function body.




func Explain_Air_body_entered(_body: Node3D) -> void:
	
	print("Entra Explain Air")
	$Explain/Right/AnimationPlayer.play("Tutorial")
	
func Explain_Air_body_exited(_body: Node3D) -> void:
	$Explain/Right/AnimationPlayer.stop()
	$Explain/Right/AnimationPlayer.seek(0)

	
