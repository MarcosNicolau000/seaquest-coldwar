extends Node2D

@onready var diverSpawn = preload("res://MainGame/Entities/Diver/diver2.tscn")
@onready var spawn_points = $SpawnPoints2.get_children()
@onready var spawn_parent = get_tree().get_current_scene()

func _on_timer_timeout() -> void:
	var diver = diverSpawn.instantiate()
	var spawn = spawn_points[randi() % spawn_points.size()]
	diver.global_position = spawn.global_position
	spawn_parent.add_child(diver)
