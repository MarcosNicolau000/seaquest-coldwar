
extends Node2D

@onready var shark = preload("res://MainGame/Entities/Shark/shark2.tscn")
@onready var spawn_points = $SpawnPoints.get_children()
@onready var spawn_parent = get_node("../Enemies")

func _on_timer_timeout() -> void:
	var tubarao = shark.instantiate()
	var spawn = spawn_points[randi() % spawn_points.size()]
	tubarao.global_position = spawn.global_position
	spawn_parent.add_child(tubarao)
