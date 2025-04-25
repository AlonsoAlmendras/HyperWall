extends Node3D

var xr_interface : XRInterface

#Stage of the user
var stage = null

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
	stage = "attention"
	$Attention/Speaker/Voice.play()
	await get_tree().create_timer(15.0).timeout
	if stage == "attention":
		stage = "motivation"
		$Motivation/StandHere.visible = true

func Attention_body_exited(_body: Node3D) -> void:
	$Attention/Speaker/Voice.stop()
	$Attention/StandHere.visible = false
	

func Motivation_body_entered(body: Node3D) -> void:
	stage = "motivation"
	$Motivation/Speaker/Voice.play()
	await get_tree().create_timer(18.0).timeout
	if stage == "motivation":
		stage = "overview"
		$Overview/StandHere.visible = true

func Motivation_body_exited(body: Node3D) -> void:
	$Motivation/Speaker/Voice.stop()
	$Motivation/StandHere.visible = false

	
func Overview_body_entered(_body: Node3D) -> void:
	stage = "overview"
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
	stage = "selection_fire" 
	$Selection/Fire/Speaker/Voice.play()
	$Selection/Fire/Speaker/Ambient.play()
	await get_tree().create_timer(10.0).timeout
	$Explain/Left/StandHere.visible = true


func Selection_Fire_body_exited(body: Node3D) -> void:
	$Selection/Fire/Speaker/Voice.stop()
	$Selection/Fire/Speaker/Ambient.stop()
	$Explain/Left/StandHere.visible = false


func Selection_Weather_body_entered(body: Node3D) -> void:
	stage = "selection_weather"
	$Selection/Weather/Speaker/Voice.play()
	$Selection/Weather/Speaker/Ambient.play()
	await get_tree().create_timer(11.5).timeout
	$Explain/Middle/StandHere.visible = true


func Selection_Weather_body_exited(body: Node3D) -> void:
	
	$Selection/Weather/Speaker/Voice.stop()
	$Selection/Weather/Speaker/Ambient.stop()
	$Explain/Middle/StandHere.visible = false


func Selection_Air_body_entered(body: Node3D) -> void:
	stage = "selection_air"
	$Selection/AirQuality/Speaker/Voice.play()
	$Selection/AirQuality/Speaker/Ambient.play()
	await get_tree().create_timer(10.0).timeout
	$Explain/Right/StandHere.visible = true



func Selection_Air_body_exited(body: Node3D) -> void:
	$Selection/AirQuality/Speaker/Voice.stop()
	$Selection/AirQuality/Speaker/Ambient.stop()
	$Explain/Right/StandHere.visible = false


func Explain_Fire_body_entered(body: Node3D) -> void:
	stage = "explain_fire"
	$Explain/Left/AnimationPlayer.play("ExplainFire")
	

func Explain_Fire_body_exited(body: Node3D) -> void:
	$Explain/Left/AnimationPlayer.stop()
	$Explain/Left/AnimationPlayer.seek(0)
	#Stop Audios
	$Explain/Left/Speaker/Intro.stop()
	$Explain/Left/Speaker/Index.stop()
	$Explain/Left/Speaker/ActiveYear.stop()
	$Explain/Left/Speaker/ActiveMonth.stop()
	$Explain/Left/Speaker/Smoke.stop()
	
	



func Explain_Weather_body_entered(body: Node3D) -> void:
	stage = "explain_weather"
	$Explain/Middle/AnimationPlayer.play("ExplainWeather")
	


func Explain_Weather_body_exited(body: Node3D) -> void:
	$Explain/Middle/AnimationPlayer.stop()
	#Stop Audios
	$Explain/Middle/Speaker/Intro.stop()
	$Explain/Middle/Speaker/WaterExtremes.stop()
	$Explain/Middle/Speaker/TemperatureIntro.stop()
	$Explain/Middle/Speaker/TemperatureConclution.stop()
	$Explain/Middle/Speaker/ArcticSea.stop()
	

func Explain_Air_body_entered(_body: Node3D) -> void:
	stage = "explain_air"
	$Explain/Right/AnimationPlayer.play("ExplainAir")
	
func Explain_Air_body_exited(_body: Node3D) -> void:
	$Explain/Right/AnimationPlayer.stop()
	#Stop Audios
	$Explain/Right/Speaker/Intro.stop()
	$Explain/Right/Speaker/Nox.stop()
	$Explain/Right/Speaker/CO.stop()
	$Explain/Right/Speaker/Ozone.stop()
	$Explain/Right/Speaker/PM.stop()
