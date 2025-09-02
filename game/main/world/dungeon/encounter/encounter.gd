extends RefCounted

class_name Encounter

var challenge: int = 0

func _init(template: EncounterTemplate) -> void:
	self.challenge = template.challenge
