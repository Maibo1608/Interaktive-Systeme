extends Control

const WORLD = preload("res://Scenes/World.tscn")


func _on_start_pressed():
	get_tree().change_scene_to_packed(WORLD)


func _on_quit_pressed():
	get_tree().quit()
