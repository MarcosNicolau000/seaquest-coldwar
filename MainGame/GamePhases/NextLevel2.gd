extends Control

func _ready() -> void:
	Statistics.set_process(true)

func _on_proxima_fase_pressed() -> void:
	GameStartRoutine.oxygenCount = 100
	GameStartRoutine.diverGoal = 0
	GameStartRoutine.diveWaveCount = 0
	get_tree().change_scene_to_file("res://MainGame/GamePhases/Phase2.tscn")
