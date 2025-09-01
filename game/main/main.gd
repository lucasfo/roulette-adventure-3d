extends Node

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		self.get_tree().change_scene_to_file("res://extra_scenes/menu/menu.tscn")
