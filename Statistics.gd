extends Node

var shark_count: int = 0
var enemy_submarine_count: int = 0
var rescued_divers_count: int = 0 
var death_count: int = 0 
var lost_diver_count: int = 0 
var time: float = 0.0

signal stats_updated()

func _process(delta: float):
	time += delta

func format_time() -> String:
	var m = int(time) / 60
	var s = int(time) % 60
	return "%02d:%02d" % [m, s]

func add_shark():
	shark_count += 1
	emit_signal("stats_updated")

func add_enemy_submarine():
	enemy_submarine_count += 1
	emit_signal("stats_updated")

func add_rescued_diver():
	rescued_divers_count += 6
	emit_signal("stats_updated")

func add_death():
	death_count += 1
	emit_signal("stats_updated")

func add_lost_diver():
	lost_diver_count += 1
	emit_signal("stats_updated")

func reset():
	shark_count = 0
	enemy_submarine_count = 0
	rescued_divers_count = 0
	death_count = 0
	lost_diver_count = 0
	emit_signal("stats_updated")
