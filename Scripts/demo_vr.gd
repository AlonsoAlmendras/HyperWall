extends Node3D

var xr_interface : XRInterface
# Reference to the AudioStreamPlayer
@onready var voice_welcome = $Voices/Welcome
@onready var voice_begin = $Voices/Begin
@onready var select_dashboard: AudioStreamPlayer = $Voices/SelectDashboard
@onready var select_topic: AudioStreamPlayer = $Voices/SelectTopic

var ObjectSeen
var ActualStage
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
	InicialStates()
	
	await get_tree().create_timer(0.5).timeout
	voice_welcome.play()
	await get_tree().create_timer(3).timeout
	voice_begin.play()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
		
	
	
func InicialStates()-> void:
	ActualStage = 1
	#$CarouselRoot.visible = false
	
	#Hyperwalls not visibles
	$Room/WallFront/HyperWallAir.visible=false
	$Room/WallFront/HyperWallFire.visible=false
	$Room/WallFront/HyperWallWeather.visible = false
	
	
	


func Phase2In(_body) -> void:
	print("FASE 2 IN")
	ActualStage = 2
	$Room/WallFront/MeshInstance3D/SubViewport/VideoStreamPlayer.play()
	$Voices/Welcome.play()
	$Phases/Phase2/ShiningText.visible = false

func Phase2Out(_body) -> void:
	print("FASE 2 Out")
	$Room/WallFront/MeshInstance3D/SubViewport/VideoStreamPlayer.pause()
	
	
func Phase3In(_body) -> void:
	#Show Dashboards and select.
	select_dashboard.play()
	$CarouselRoot.visible = true
	$Text.visible = false
	select_topic.stop()
	ActualStage = 3
	

func Phase3Out(_body) -> void:
	#print("Body Out Phase5")
	$CarouselRoot.visible = false
	$Text.visible = true
	select_dashboard.stop()


func Phase4In(_body) -> void:
	ActualStage = 4
	if ActualDashboard == "Air":
		$Room/WallFront/HyperWallAir/DashBoard/Background/Video2/MeshInstance3D2/US.visible = true
		$Room/WallFront/HyperWallAir/DashBoard/Background/Video2/MeshInstance3D2/Asia.visible = true
		$Room/WallFront/HyperWallAir/DashBoard/Background/Video2/MeshInstance3D2/SouthAmerica.visible = true
		

func Phase4Out(_body) -> void:
	pass

func Phase5In(_body) -> void:
	ActualStage = 5
	#print("Body Enter Phase5")
	$SphereVideo.visible = true
	$SphereVideo2.visible = true
	
		

func Phase5Out(_body) -> void:
	#print("Body Out Phase5")
	$SphereVideo.visible = false
	$SphereVideo2.visible = false
	$Room/WallFront/HyperWallAir/Animation.pause()


func Phase6LeftIn(_body) -> void:
	ActualStage = 6
	if ActualDashboard == "Air":
		$Room/WallFront/HyperWallAir/Animation.play("PlayLeft")
		$Room/WallFront/HyperWallAir/Audios/Middle/SouthAmerica.stop()
		$Room/WallFront/HyperWallAir/Audios/Middle/Asia.stop()		
		$Room/WallFront/HyperWallAir/Audios/Middle/US.stop()
	
func Phase6LeftOut(_body) -> void:
	$Room/WallFront/HyperWallAir/Animation.stop()
	$Room/WallFront/HyperWallAir/Animation.seek(0)
	


func carousel_image_change(image_id: Variant) -> void:
	if image_id == 0:
		$Room/WallFront/HyperWallAir.visible=true
		$Room/WallFront/HyperWallWeather.visible=false
		$Room/WallFront/HyperWallFire.visible = false
		ActualDashboard = "Air"
	if image_id == 1:
		$Room/WallFront/HyperWallAir.visible=false
		$Room/WallFront/HyperWallWeather.visible=true
		$Room/WallFront/HyperWallFire.visible = false
		ActualDashboard = "Weather"
	if image_id == 2:
		$Room/WallFront/HyperWallAir.visible=false
		$Room/WallFront/HyperWallWeather.visible=false
		$Room/WallFront/HyperWallFire.visible = true
		ActualDashboard = "Fire"


func XROrigin_ObjectSeen(object: Variant) -> void:
	print(object)
	ObjectSeen = object
	print(ObjectSeen)
	if ActualDashboard == "Air":
		
		if ObjectSeen == $Room/WallFront/HyperWallAir/DashBoard/Background/MeshInstance3D2/US:
			print("US")
			$Room/WallFront/HyperWallAir/Audios/Middle/SouthAmerica.stop()
			$Room/WallFront/HyperWallAir/Audios/Middle/Asia.stop()		
			$Room/WallFront/HyperWallAir/Audios/Middle/US.play()
			
		elif ObjectSeen == $Room/WallFront/HyperWallAir/DashBoard/Background/MeshInstance3D2/SouthAmerica:
			print("SouthAmerica")
			$Room/WallFront/HyperWallAir/Audios/Middle/US.stop()
			$Room/WallFront/HyperWallAir/Audios/Middle/Asia.stop()
			$Room/WallFront/HyperWallAir/Audios/Middle/SouthAmerica.play()
		
		elif ObjectSeen == $Room/WallFront/HyperWallAir/DashBoard/Background/MeshInstance3D2/Asia:
			print("Asia")
			$Room/WallFront/HyperWallAir/Audios/Middle/SouthAmerica.stop()
			$Room/WallFront/HyperWallAir/Audios/Middle/US.stop()
			$Room/WallFront/HyperWallAir/Audios/Middle/Asia.play()


func Introduction_finish() -> void:
	await get_tree().create_timer(1).timeout 
	if ActualStage == 2:
		select_topic.play()
	
	await get_tree().create_timer(1).timeout 
	if ActualStage == 2:
		$Text/ShiningText/Rotation.play("rotate")
		$Text/Label3D.visible = true
		$Text/ShiningText.visible = true
		
