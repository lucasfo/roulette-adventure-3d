extends Node3D

@export var template: EncounterTemplate

func create_encounter() -> Encounter:
	return Encounter.new(template)
