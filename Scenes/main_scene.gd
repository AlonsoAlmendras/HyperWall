extends Node3D


func _ready() -> void:
	$Characters/Woman/AnimationPlayer.play("WomanAnimation/Stand")
	$Characters/Man/AnimationPlayer.play("ManAnimation/StopWalk")
