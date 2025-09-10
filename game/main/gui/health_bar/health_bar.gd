extends Control

@onready var hearts: Control = $Hearts

func _ready() -> void:
	PlayerAL.hp_changed.connect(self._on_player_hp_changed)
	self._on_player_hp_changed()

func _on_player_hp_changed() -> void:
	var i: int = 0
	for heart in self.hearts.get_children():
		heart.visible = (i < PlayerAL.hp)
		i += 1
