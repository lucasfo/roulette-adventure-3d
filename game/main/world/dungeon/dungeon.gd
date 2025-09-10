extends Node3D

@onready var player: Player = $PlayerAvatar.player
@onready var factory = $EncounterFactory

var encounter: Encounter = null
var roullete_data: RoulleteData = null

func _ready() -> void:
	DungeonAL.attr_entered.connect(run_turn)
	DungeonAL.roullete_spin_finished.connect(self._on_roullete_spin_finished)
	if !factory.start_encounter():
		self.get_tree().change_scene_to_file("res://extra_scenes/menu/menu.tscn")
		return

	self.encounter = factory.current_encounter()

func run_turn(attr: Enums.Attribute) -> void:
	const BASE_ROLL: int = 20
	var win_unb: int = BASE_ROLL + player.attr_power(attr) - encounter.challenge
	var win_n: int = max(min(BASE_ROLL, win_unb), 0)
	var win_odds: float = float(win_n)/float(BASE_ROLL)

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
	self.roullete_data = RoulleteData.new(BASE_ROLL, win_n, dice_roll)
	DungeonAL.send_roullete_data(self.roullete_data)

func _on_roullete_spin_finished():
	if self.roullete_data.won():
		if self.factory.defeat_encounter():
			self.encounter = factory.current_encounter()
		else:
			self.get_tree().change_scene_to_file("res://extra_scenes/menu/menu.tscn")

