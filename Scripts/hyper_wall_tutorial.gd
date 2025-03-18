extends Node3D
signal IntroductionFinish

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	


func animation_finished(anim_name: StringName) -> void:
	IntroductionFinish.emit()
