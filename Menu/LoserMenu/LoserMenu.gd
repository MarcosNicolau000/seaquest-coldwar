extends Control


func _ready() -> void:
	$RichTextLabel.text = "Score: " + str(GameStartRoutine.scoreCount)
	GameStartRoutine.isGameRunning = false
	pass 


func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	GameStartRoutine.gameLife = 3
	GameStartRoutine.gamePhase = 0
	GameStartRoutine.isGameRunning = false
	get_tree().change_scene_to_file("res://Menu/MainMenu/MainMenu.tscn")
	pass # Replace with function body.
