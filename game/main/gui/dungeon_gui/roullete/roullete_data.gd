extends RefCounted

class_name RoulleteData

var base: int = 0
var win_n: int = 0
var roll: int = 0

func _init(base_inp: int, win_n_inp: int, roll_inp: int) -> void:
	self.base = base_inp
	self.win_n = win_n_inp
	self.roll = roll_inp
