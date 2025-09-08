extends Node

signal attr_entered(attr: Enums.Attribute)
signal roullete_data_entered(data: RoulleteData)

func send_attr(attr: Enums.Attribute) -> void:
	self.attr_entered.emit(attr)

func send_roullete_data(data: RoulleteData) -> void:
	self.roullete_data_entered.emit(data)
