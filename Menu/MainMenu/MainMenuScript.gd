extends Control

@onready var menu_entrada: VBoxContainer = $"Menu entrada"
@onready var menu_opçoes: Panel = $"Menu opçoes"

func _ready():
	menu_entrada.visible = true
	menu_opçoes.visible = false




func _on_iniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://MainGame/GamePhases/Phase3.tscn")
	
func _on_opcoes_pressed() -> void:
	menu_entrada.visible = false
	menu_opçoes.visible = true


func _on_sair_pressed() -> void:
	get_tree().quit()
	


func _on_voltar_pressed() -> void:
	_ready()
