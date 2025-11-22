extends Control

func _ready() -> void:
	Statistics.set_process(true)

func _on_proxima_fase_pressed() -> void:
	get_tree().change_scene_to_file("res://MainGame/GamePhases/Phase3.tscn")
