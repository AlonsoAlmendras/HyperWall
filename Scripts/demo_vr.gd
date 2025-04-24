extends Node3D

var xr_interface : XRInterface
# Reference to the AudioStreamPlayer
var ObjectSeen      #Track the object that is seen by the user
var ActualStage     #Track the value of the actual stage
var StageChange     #True when ActualStage just change his value
var ActualDashboard

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialised succesfully")
		
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		
		get_viewport().use_xr = true
	else:
		print("OpenXR not initialialised, headset prbably desconnected")
		
	print("Posición global del XROrigin3D: ", global_transform.origin)
	ActualStage = "None"
	$Phases/Introduction/ShiningText/Rotation.play("Rotation")
	$Phases/Orientation/ShiningText2/Rotation.play("Rotation")
	
	#Play and Pause all videos, for see them without use of RAM
	$Room/WallFront/HyperWallAir/SubViewPorts/SubViewport/VideoStreamPlayer.play()
	$Room/WallFront/HyperWallAir/SubViewPorts/SubViewport2/VideoStreamPlayer.play()
	$Room/WallFront/HyperWallAir/SubViewPorts/SubViewport3/VideoStreamPlayer.play()
	$Room/WallFront/HyperWallAir/SubViewPorts/SubViewport4/VideoStreamPlayer.play()
	$Room/WallFront/HyperWallWeather/SubViewPorts/SubViewport/VideoStreamPlayer.play()
	$Room/WallFront/HyperWallWeather/SubViewPorts/SubViewport2/VideoStreamPlayer.play()
	$Room/WallFront/HyperWallWeather/SubViewPorts/SubViewport3/VideoStreamPlayer.play()
	$Room/WallFront/HyperWallFire/SubViewPorts/SubViewport/VideoStreamPlayer.play()
	$Room/WallFront/HyperWallFire/SubViewPorts/SubViewport2/VideoStreamPlayer.play()
	$Room/WallFront/HyperWallFire/SubViewPorts/SubViewport3/VideoStreamPlayer.play()
	await get_tree().process_frame
	#Pause all videos in the first frame
	$Room/WallFront/HyperWallAir/SubViewPorts/SubViewport/VideoStreamPlayer.paused =true
	$Room/WallFront/HyperWallAir/SubViewPorts/SubViewport2/VideoStreamPlayer.paused =true
	$Room/WallFront/HyperWallAir/SubViewPorts/SubViewport3/VideoStreamPlayer.paused =true
	$Room/WallFront/HyperWallAir/SubViewPorts/SubViewport4/VideoStreamPlayer.paused =true
	$Room/WallFront/HyperWallWeather/SubViewPorts/SubViewport/VideoStreamPlayer.paused =true
	$Room/WallFront/HyperWallWeather/SubViewPorts/SubViewport2/VideoStreamPlayer.paused =true
	$Room/WallFront/HyperWallWeather/SubViewPorts/SubViewport3/VideoStreamPlayer.paused =true
	$Room/WallFront/HyperWallFire/SubViewPorts/SubViewport/VideoStreamPlayer.paused =true
	$Room/WallFront/HyperWallFire/SubViewPorts/SubViewport2/VideoStreamPlayer.paused =true
	$Room/WallFront/HyperWallFire/SubViewPorts/SubViewport3/VideoStreamPlayer.paused =true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ActualStage == "Intro":
		if $Phases/Introduction/Path3D.visible == true:
			const move_speed := 2.0
			$Phases/Introduction/Path3D/PathFollow3D1.progress += move_speed*delta
			$Phases/Introduction/Path3D/PathFollow3D2.progress += move_speed*delta
			$Phases/Introduction/Path3D/PathFollow3D3.progress += move_speed*delta
			$Phases/Introduction/Path3D/PathFollow3D4.progress += move_speed*delta
			$Phases/Introduction/Path3D/PathFollow3D5.progress += move_speed*delta
					
	

func IntroductionIn(_body) -> void:
	print("FASE 2 IN")
	$Phases/Introduction/ShiningText/Text.visible = false
	ActualStage = "Intro"
	StageChange = true
	$Phases/Introduction/AnimationPlayer.play("Intro")

func IntroductionOut(_body) -> void:
	print("FASE 2 Out")
	$Room/WallFront/Intro/Welcome.visible = false
	$Room/WallFront/Intro/NasaSatelites.visible = false
	$Room/WallFront/Intro/DataCollected.visible = false
	$Room/WallFront/Intro/NasaSatelites/Video/SubViewport/VideoStreamPlayer.stop()
	$Phases/Introduction/Welcome.stop()
	$Phases/Introduction/Satelites.stop()
	$Phases/Introduction/PlanetaryChanges.stop()
	$Phases/Introduction/MoveFurther.stop()
	
func OrientationIn(_body) -> void:
	ActualStage = "Overview"
	StageChange = true
	print("Phase3")
	$Phases/Orientation/ShiningText2.visible = false
	$Phases/Orientation/AnimationPlayer.play("Overview")
	
	

func OrientationOut(_body) -> void:
	#print("Body Out Phase5")
	$CarouselRoot.visible = false
	ActualStage = "Explain"
	StageChange = true


func ExplainIn(_body) -> void:
	ActualStage = "Explain"
	$Phases/Explain/StandHere.visisble = false
	
	if ActualDashboard == "Air":
		$Room/WallFront/HyperWallAir/Dashboard/Background/Video2/MeshInstance3D2/US.visible = true
		$Room/WallFront/HyperWallAir/Dashboard/Background/Video2/MeshInstance3D2/Asia.visible = true
		$Room/WallFront/HyperWallAir/Dashboard/Background/Video2/MeshInstance3D2/SouthAmerica.visible = true
		

func ExplainOut(_body) -> void:
	pass

func ExploreLeftIn(_body) -> void:
	ActualStage = "Explore"
	if ActualDashboard == "Air":
		$Room/WallFront/HyperWallAir/Animation.play("PlayLeft")
		$Room/WallFront/HyperWallAir/Audios/Middle/SouthAmerica.stop()
		$Room/WallFront/HyperWallAir/Audios/Middle/Asia.stop()		
		$Room/WallFront/HyperWallAir/Audios/Middle/US.stop()
	
func ExploreLeftOut(_body) -> void:
	$Room/WallFront/HyperWallAir/Animation.stop()
	$Room/WallFront/HyperWallAir/Animation.seek(0)
	

func carousel_image_change(image_id: Variant) -> void:
	if $CarouselRoot.visible == true:
		if image_id == 0: #stage no es esteee
			ActualStage = "OverviewAir"
			ActualDashboard = "Air"
			checkStage()
			$Room/WallFront/HyperWallAir.visible=true
			$Room/WallFront/HyperWallWeather.visible=false
			$Room/WallFront/HyperWallFire.visible = false
		if image_id == 1:
			ActualStage = "OverviewFire"
			ActualDashboard = "Fire"
			checkStage()
			$Room/WallFront/HyperWallAir.visible=false
			$Room/WallFront/HyperWallWeather.visible=false
			$Room/WallFront/HyperWallFire.visible = true
		if image_id == 2:
			ActualStage = "OverviewWeather"
			ActualDashboard = "Weather"
			checkStage()
			$Room/WallFront/HyperWallAir.visible=false
			$Room/WallFront/HyperWallWeather.visible=true
			$Room/WallFront/HyperWallFire.visible = false



func checkStage() -> void:
	print("ActualState")
	
	
	if ActualStage == "OverviewAir":
		print("HyperWallAir")
		$Room/WallFront/HyperWallAir/SubViewPorts/SubViewport/VideoStreamPlayer.paused = false
		$Room/WallFront/HyperWallAir/SubViewPorts/SubViewport2/VideoStreamPlayer.paused = false
		$Room/WallFront/HyperWallAir/SubViewPorts/SubViewport3/VideoStreamPlayer.paused = false
		$Room/WallFront/HyperWallAir/SubViewPorts/SubViewport4/VideoStreamPlayer.paused = false
		#Pause Other Videos
		$Room/WallFront/HyperWallWeather/SubViewPorts/SubViewport/VideoStreamPlayer.paused = true
		$Room/WallFront/HyperWallWeather/SubViewPorts/SubViewport2/VideoStreamPlayer.paused = true
		$Room/WallFront/HyperWallWeather/SubViewPorts/SubViewport3/VideoStreamPlayer.paused = true
		$Room/WallFront/HyperWallFire/SubViewPorts/SubViewport/VideoStreamPlayer.paused = true
		$Room/WallFront/HyperWallFire/SubViewPorts/SubViewport2/VideoStreamPlayer.paused = true
		$Room/WallFront/HyperWallFire/SubViewPorts/SubViewport3/VideoStreamPlayer.paused = true
		
	if ActualStage == "OverviewWeather":
		print("HyperWallWeather")
		$Room/WallFront/HyperWallWeather/SubViewPorts/SubViewport/VideoStreamPlayer.paused = false
		$Room/WallFront/HyperWallWeather/SubViewPorts/SubViewport2/VideoStreamPlayer.paused = false
		$Room/WallFront/HyperWallWeather/SubViewPorts/SubViewport3/VideoStreamPlayer.paused = false
		
		#Pause Other Videos
		$Room/WallFront/HyperWallAir/SubViewPorts/SubViewport/VideoStreamPlayer.paused = true
		$Room/WallFront/HyperWallAir/SubViewPorts/SubViewport2/VideoStreamPlayer.paused = true
		$Room/WallFront/HyperWallAir/SubViewPorts/SubViewport3/VideoStreamPlayer.paused = true
		$Room/WallFront/HyperWallAir/SubViewPorts/SubViewport4/VideoStreamPlayer.paused = true
		$Room/WallFront/HyperWallFire/SubViewPorts/SubViewport/VideoStreamPlayer.paused = true
		$Room/WallFront/HyperWallFire/SubViewPorts/SubViewport2/VideoStreamPlayer.paused = true
		$Room/WallFront/HyperWallFire/SubViewPorts/SubViewport3/VideoStreamPlayer.paused = true
		
	if ActualStage == "OverviewFire":
		print("HyperWallFire")
		$Room/WallFront/HyperWallFire/SubViewPorts/SubViewport/VideoStreamPlayer.paused = false
		$Room/WallFront/HyperWallFire/SubViewPorts/SubViewport2/VideoStreamPlayer.paused = false
		$Room/WallFront/HyperWallFire/SubViewPorts/SubViewport3/VideoStreamPlayer.paused = false

		#Pause Other Videos
		$Room/WallFront/HyperWallAir/SubViewPorts/SubViewport/VideoStreamPlayer.paused = true
		$Room/WallFront/HyperWallAir/SubViewPorts/SubViewport2/VideoStreamPlayer.paused = true
		$Room/WallFront/HyperWallAir/SubViewPorts/SubViewport3/VideoStreamPlayer.paused = true
		$Room/WallFront/HyperWallAir/SubViewPorts/SubViewport4/VideoStreamPlayer.paused = true
		$Room/WallFront/HyperWallWeather/SubViewPorts/SubViewport/VideoStreamPlayer.paused = true
		$Room/WallFront/HyperWallWeather/SubViewPorts/SubViewport2/VideoStreamPlayer.paused = true
		$Room/WallFront/HyperWallWeather/SubViewPorts/SubViewport3/VideoStreamPlayer.paused = true
		
	



func XROrigin_ObjectSeen(object: Variant) -> void:
	print(object)
	ObjectSeen = object
	print(ObjectSeen)
	if ActualDashboard == "Air":
		
		if ObjectSeen == $Room/WallFront/HyperWallAir/Dashboard/Background/MeshInstance3D2/US:
			print("US")
			$Room/WallFront/HyperWallAir/Audios/Middle/SouthAmerica.stop()
			$Room/WallFront/HyperWallAir/Audios/Middle/Asia.stop()		
			$Room/WallFront/HyperWallAir/Audios/Middle/US.play()
			
		elif ObjectSeen == $Room/WallFront/HyperWallAir/Dashboard/Background/MeshInstance3D2/SouthAmerica:
			print("SouthAmerica")
			$Room/WallFront/HyperWallAir/Audios/Middle/US.stop()
			$Room/WallFront/HyperWallAir/Audios/Middle/Asia.stop()
			$Room/WallFront/HyperWallAir/Audios/Middle/SouthAmerica.play()
		
		elif ObjectSeen == $Room/WallFront/HyperWallAir/Dashboard/Background/MeshInstance3D2/Asia:
			print("Asia")
			$Room/WallFront/HyperWallAir/Audios/Middle/SouthAmerica.stop()
			$Room/WallFront/HyperWallAir/Audios/Middle/US.stop()
			$Room/WallFront/HyperWallAir/Audios/Middle/Asia.play()
