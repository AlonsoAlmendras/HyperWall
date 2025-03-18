extends Node3D

var xr_interface : XRInterface
# Reference to the AudioStreamPlayer
@onready var voice_welcome = $Voices/Welcome
@onready var voice_begin = $Voices/Begin
@onready var select_dashboard: AudioStreamPlayer = $Voices/SelectDashboard

var ObjectSeen
var ActualStage

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
	#if ActualStage == 5:
	#	if ObjectSeen == "WallFront":
	#		$Rooms/Hallway/WallFront/HyperWallTutorial/Animation.play("PlayRight")
	#print(ObjectSeen)
	pass
		
	
	
func InicialStates()-> void:
	ActualStage = 1
	$CarouselRoot.visible = false
	#Lights
	#$Lights/FirstLight.visible = true
	$Lights/HyperwallLight.visible = false
	$Rooms/Hallway/Path.visible = false
	#Hyperwalls not visibles
	$Rooms/Hallway/WallFront/HyperWallFire1.visible=false
	$Rooms/Hallway/WallFront/HyperWallFire2.visible=false
	$Rooms/Hallway/WallFront/HyperWallTutorial.visible = false
	
	await get_tree().create_timer(4.0).timeout 
	$Rooms/Hallway/Path.visible = true
	$Rooms/RoomDoor/CSGBox3D/Label3D.visible = true
	$Rooms/RoomDoor/CSGBox3D/Label3D2.visible = true
	$Rooms/Hallway/Path.visible = true
	$Lights/FirstLight.visible = true
	
	$Rooms/Hallway/Path.visible = true
	
	
func LightSwitch() -> void:
	print("LightSwitch")
	if $Lights/FirstLight.visible:
		$Lights/FirstLight.visible = false
	else:
		$Lights/FirstLight.visible = true
	
	


func Phase2In() -> void:
	print("FASE 2 IN")
	$Rooms/Hallway/WallFront/HyperWallTutorial/Node3D/DashBoard/MeshInstance3D/EastAsia.visible = false
	$Rooms/Hallway/WallFront/HyperWallTutorial.visible = true
	$Rooms/Hallway/WallFront/HyperWallTutorial/Node3D/DashBoard/MeshInstance3D/SouthAsia.visible = false
	$Rooms/Hallway/WallFront/HyperWallTutorial/Animation.play("Introduction")
	
	await get_tree().create_timer(13.5).timeout 
	
	$Text/ShiningText/Rotation.play("rotate")
	$Text/Label3D.visible = true
	$Text/ShiningText.visible = true
	ActualStage = 2

func Phase2Out() -> void:
	print("FASE 2 Out")
	$Rooms/Hallway/WallFront/HyperWallTutorial/Animation.pause()
	
	
func Phase3In() -> void:
	$Rooms/Hallway/WallFront/HyperWallTutorial.visible = false
	select_dashboard.play()
	$Rooms/Hallway/WallFront/HyperWallTutorial.visible = false
	$CarouselRoot.visible = true
	$Text.visible = false
	$Text/ShiningText/Rotation.pause()
	ActualStage = 2

func Phase3Out() -> void:
	#print("Body Out Phase5")
	$CarouselRoot.visible = false
	$Text.visible = true


func Phase4In() -> void:
	ActualStage = 4

func Phase4Out() -> void:
	pass

func Phase5In() -> void:
	ActualStage = 5
	#print("Body Enter Phase5")
	$Lights/HyperwallLight.visible = false
	$SphereVideo.visible = true
	$SphereVideo2.visible = true
	
		

func Phase5Out() -> void:
	#print("Body Out Phase5")
	$Lights/HyperwallLight.visible = true
	$SphereVideo.visible = false
	$SphereVideo2.visible = false
	$Rooms/Hallway/WallFront/HyperWallTutorial/Animation.pause()


func Phase6LeftIn() -> void:
	print("Phase6 In")
	ActualStage = 6
	$Rooms/Hallway/WallFront/HyperWallTutorial/Animation.play("PlayLeft")
	
func Phase6LeftOut() -> void:
	$Rooms/Hallway/WallFront/HyperWallTutorial/Animation.pause()


func ButtonPressed() -> void:
	$Rooms/Hallway/Path.visible = true
	$Rooms/RoomDoor/Wall2/Label3D.visible = true
	$Rooms/RoomDoor/Wall4/Label3D.visible = true
	$Rooms/RoomDoor/CSGBox3D/Label3D.visible = true
	
	
	

	


func carousel_image_change(image_id: Variant) -> void:
	if image_id == 0:
		$Rooms/Hallway/WallFront/HyperWallFire1.visible=true
		$Rooms/Hallway/WallFront/HyperWallFire2.visible=false
		$Rooms/Hallway/WallFront/HyperWallTutorial.visible = false
	if image_id == 1:
		$Rooms/Hallway/WallFront/HyperWallFire1.visible=false
		$Rooms/Hallway/WallFront/HyperWallFire2.visible=true
		$Rooms/Hallway/WallFront/HyperWallTutorial.visible = false
	if image_id == 2:
		$Rooms/Hallway/WallFront/HyperWallFire1.visible=false
		$Rooms/Hallway/WallFront/HyperWallFire2.visible=false
		$Rooms/Hallway/WallFront/HyperWallTutorial.visible = true


func XROrigin_ObjectSeen(object: Variant) -> void:
	print(object)
	ObjectSeen = object
	print(ObjectSeen)
	if ObjectSeen == $Rooms/Hallway/WallFront/HyperWallTutorial/Node3D/DashBoard/MeshInstance3D2/US:
		print("US")
		$Rooms/Hallway/WallFront/HyperWallTutorial/Audios/Middle/SouthAmerica.stop()
		$Rooms/Hallway/WallFront/HyperWallTutorial/Audios/Middle/Asia.stop()		
		$Rooms/Hallway/WallFront/HyperWallTutorial/Audios/Middle/US.play()
		
	elif ObjectSeen == $Rooms/Hallway/WallFront/HyperWallTutorial/Node3D/DashBoard/MeshInstance3D2/SouthAmerica:
		print("SouthAmerica")
		$Rooms/Hallway/WallFront/HyperWallTutorial/Audios/Middle/US.stop()
		$Rooms/Hallway/WallFront/HyperWallTutorial/Audios/Middle/Asia.stop()
		$Rooms/Hallway/WallFront/HyperWallTutorial/Audios/Middle/SouthAmerica.play()
	
	elif ObjectSeen == $Rooms/Hallway/WallFront/HyperWallTutorial/Node3D/DashBoard/MeshInstance3D2/Asia:
		print("Asia")
		$Rooms/Hallway/WallFront/HyperWallTutorial/Audios/Middle/SouthAmerica.stop()
		$Rooms/Hallway/WallFront/HyperWallTutorial/Audios/Middle/US.stop()
		$Rooms/Hallway/WallFront/HyperWallTutorial/Audios/Middle/Asia.play()
