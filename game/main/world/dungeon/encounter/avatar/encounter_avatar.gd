extends Node3D

class_name EncounterAvatar

@export var template: EncounterTemplate
@onready var encounter: Encounter = Encounter.new(self.template)
