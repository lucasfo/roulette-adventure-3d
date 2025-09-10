extends Node3D

@export var template: EncounterTemplate

var avatars: Array[EncounterAvatar] = []

func _ready() -> void:
	for child in $Encounters.get_children():
		avatars.push_back(child as EncounterAvatar)

	if avatars.size() == 0:
		print("WARN: No encounters found in EncounterFactory")

func is_active() -> bool:
	return avatars.size() > 0

func start_encounter() -> bool:
	if !self.is_active():
		return false

	avatars[0].visible = true
	return true

func defeat_encounter() -> bool:
	var defeated: EncounterAvatar = avatars.pop_front()
	defeated.queue_free()
	return self.start_encounter()

func current_encounter() -> Encounter:
	return avatars[0].encounter
