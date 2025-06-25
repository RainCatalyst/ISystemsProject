extends Node2D

@export var ui: UI

func _ready():
	await Serial.connected
	ui.show_text("Select a room to learn about!")


func _on_kitchen_pressed():
	get_tree().change_scene_to_file("res://scenes/game/level_kitchen.tscn")


func _on_living_room_pressed():
	get_tree().change_scene_to_file("res://scenes/game/level_livingroom.tscn")
