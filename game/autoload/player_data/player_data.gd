extends Node

signal update

var hp: int = 3

func change_hp(new_hp: int):
	self.hp = new_hp
	self.update.emit()

func save(save_file: SaveFile) -> void:
	save_file.hp = self.hp

func restore_save(save_file: SaveFile) -> void:
	self.hp = save_file.hp
