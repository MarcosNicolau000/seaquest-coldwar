extends Control


func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/MainMenu/MainMenu.tscn")
	GameStartRoutine.gameLife = 3
	GameStartRoutine.gamePhase = 0
	GameStartRoutine.isGameRunning = false
	$RichTextLabel.text = "Score: " + str(GameStartRoutine.scoreCount)
	pass # Replace with function body.
