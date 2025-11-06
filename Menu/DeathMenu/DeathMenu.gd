extends Control


func _ready() -> void:
	$RichTextLabel2.text = str(GameStartRoutine.gameLife)
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://MainGame/MainGameEssentials/MainGame.tscn")

	pass # Replace with function body.
