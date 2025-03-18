extends Node3D

signal SignalPhase2In
signal SignalPhase2Out
signal SignalPhase3In
signal SignalPhase3Out
signal SignalPhase4In
signal SignalPhase4Out
signal SignalPhase5In
signal SignalPhase5Out
signal SignalPhase6LeftIn
signal SignalPhase6LeftOut

func Phase2In(_body: Node3D) -> void:
	SignalPhase2In.emit()


func Phase2Out(_body: Node3D) -> void:
	SignalPhase2Out.emit() 


func Phase3In(_body: Node3D) -> void:
	SignalPhase3In.emit()


func Phase3Out(_body: Node3D) -> void:
	SignalPhase3Out.emit()


func Phase4In(_body: Node3D) -> void:
	SignalPhase4In.emit()


func Phase4Out(_body: Node3D) -> void:
	SignalPhase4Out.emit()


func Phase5In(_body: Node3D) -> void:
	SignalPhase5In.emit()


func Phase5Out(_body: Node3D) -> void:
	SignalPhase5Out.emit()


func Phase6LeftIn(_body: Node3D) -> void:
	SignalPhase6LeftIn.emit()


func Phase6LeftOut(_body: Node3D) -> void:
	SignalPhase6LeftOut.emit()
