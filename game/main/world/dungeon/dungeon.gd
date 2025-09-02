extends Node3D

@onready var player: Player = $PlayerAvatar.player
@onready var encounter: Encounter = $EncounterFactory.create_encounter()

func _input(event: InputEvent) -> void:
	var attr: Enums.Attribute = Enums.Attribute.NONE

	if event.is_action_pressed("melee_atk"):
		attr = Enums.Attribute.MELEE
	elif event.is_action_pressed("ranged_atk"):
		attr = Enums.Attribute.RANGED
	elif event.is_action_pressed("magic_atk"):
		attr = Enums.Attribute.MAGIC
	
	if attr != Enums.Attribute.NONE:
		self.run_turn(attr)

func run_turn(attr: Enums.Attribute) -> void:
	const BASE_ROLL: int = 20
	var win_n: int = BASE_ROLL + player.attr_power(attr) - encounter.challenge
	var win_odds: float = float(max(win_n, 0))/float(BASE_ROLL)

	var dice_roll: int  = randi() % BASE_ROLL
	var roll: int  = max(dice_roll + player.attr_power(attr), 0)

	var won: bool = roll > encounter.challenge
	var attr_to_str: Dictionary[Enums.Attribute, String] = {
		Enums.Attribute.MELEE: "Melee"
		, Enums.Attribute.RANGED: "Ranged"
		, Enums.Attribute.MAGIC: "Magic"
	}
	print("-= New Turn =-")
	print("-- Player Attributes --")
	print("Melee: %d, Ranged: %d, Magic %d:" % [self.player.melee, self.player.ranged, self.player.magic])
	print("Attribute used: %s" % attr_to_str[attr])
	print("-- Encounter Info --")
	print("Challenge: %d" % encounter.challenge)
	print("Base roll: %d" % BASE_ROLL)
	print("Win N#: %d" % win_n)
	print("Win Odds: %.2f" % win_odds)
	print("-- Result --")
	print("Dice roll: %d" % dice_roll)
	print("Actual roll: %d" % roll)
	print("Victory: %s" % won)
	self.get_tree().change_scene_to_file("res://extra_scenes/menu/menu.tscn")
