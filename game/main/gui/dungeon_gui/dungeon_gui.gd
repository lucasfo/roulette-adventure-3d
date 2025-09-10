extends Control

@export var roullete_scene: PackedScene

func _ready() -> void:
	DungeonAL.roullete_data_entered.connect(_on_roullete_data_entered)

func _input(event: InputEvent) -> void:
	var attr: Enums.Attribute = Enums.Attribute.NONE

	if event.is_action_pressed("melee_atk"):
		attr = Enums.Attribute.MELEE
	elif event.is_action_pressed("ranged_atk"):
		attr = Enums.Attribute.RANGED
	elif event.is_action_pressed("magic_atk"):
		attr = Enums.Attribute.MAGIC

	if attr != Enums.Attribute.NONE:
		DungeonAL.send_attr(attr)

func _on_melee_pressed() -> void:
	DungeonAL.send_attr(Enums.Attribute.MELEE)

func _on_ranged_pressed() -> void:
	DungeonAL.send_attr(Enums.Attribute.RANGED)

func _on_magic_pressed() -> void:
	DungeonAL.send_attr(Enums.Attribute.MAGIC)

func _on_roullete_data_entered(data: RoulleteData):
	var roullete: Roullete = self.roullete_scene.instantiate() as Roullete
	roullete.spin_finished.connect(_on_roullete_spin_finished)
	self.add_child(roullete)
	roullete.position = Vector2(20, 120) #FIXME
	roullete.set_data(data)
	roullete.spin()

func _on_roullete_spin_finished():
	DungeonAL.send_roullete_spin_finished()
	#self.get_tree().change_scene_to_file("res://extra_scenes/menu/menu.tscn")
