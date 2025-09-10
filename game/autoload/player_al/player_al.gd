extends Node

signal hp_changed

var hp: int = 5

func set_hp(new_hp: int):
	self.hp = new_hp
	self.hp_changed.emit()

func save(save_file: SaveFile) -> void:
	save_file.hp = self.hp

func restore_save(save_file: SaveFile) -> void:
	self.hp = save_file.hp
